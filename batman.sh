#!/bin/bash

clusterdir=/cluster/project/pangolin
working=working
sampleset=sampleset

RXJOB='Job <([[:digit:]]+)> is submitted'
# Generic job.
# Job <129052039> is submitted to queue <light.5d>.

case "$1" in
	rsync)
		# rsync daemon : see ${SSH_ORIGINAL_COMMAND}
		rsync --server --daemon .
	;;
	logrotate)
		# rotate logs
		~/log/rotate
	;;
	addsamples)
		mkdir -p --mode=2770 ${clusterdir}/${working}/samples/
		cp -vrf --link ${clusterdir}/${sampleset}/*/ ${clusterdir}/${working}/samples/   ## failure: "no rule to create {SAMPLE}/extract/R1.fastq"
		sort ${clusterdir}/${sampleset}/samples.*.tsv > ${clusterdir}/${working}/samples.tsv
	;;
	vpipe)
		declare -A job
		list=('seq' 'seqqa' 'snv' 'snvqa' 'hugemem' 'hugememqa')
		# start first job
		cd ${clusterdir}/${working}/
		# use -H to put on hold for analysis
		if [[ "$(bsub < vpipe-no-shorah.bsub)" =~ ${RXJOB} ]]; then
			job['seq']=${BASH_REMATCH[1]}
			# schedule a gatherqa no mater what happens
			[[ "$(bsub -w "ended(${job['seq']})"  < gatherqa)" =~ ${RXJOB} ]] && job['seqqa']=${BASH_REMATCH[1]}
			# if no fail schedule a full job with snv
			if [[ "$(bsub -w "done(${job['seq']})" -ti < vpipe.bsub)"  =~ ${RXJOB} ]]; then
				job['snv']=${BASH_REMATCH[1]}
				# schedule a gatherqa no matter what happens to snv
				[[ "$(bsub -w "done(${job['seq']})&&ended(${job['snv']})"  < gatherqa)" =~ ${RXJOB} ]] && job['snvqa']=${BASH_REMATCH[1]}
				# schedule a hugemem job if snvjob failed
				if [[ "$(bsub -w "done(${job['seq']})&&exit(${job['snv']})" -ti < vpipe-hugemem.bsub)" =~ ${RXJOB} ]]; then
					job['hugemem']=${BASH_REMATCH[1]}
					# schedule a qa afterward
					[[ "$(bsub -w "done(${job['seq']})&&exit(${job['snv']})&&ended(${job['hugemem']})" -ti  < gatherqa)" =~ ${RXJOB} ]] && job['hugememqa']=${BASH_REMATCH[1]}
				fi
			fi
		fi >&2
		# write job chain list
		for v in "${list[@]}"; do
			printf "%s\t%s\n" "${v}" "${job[$v]}"
		done
	;;
	job)
		if [[ $2 =~ ^([[:digit:]]+)$ ]]; then
			bjobs $2 | gawk -v I=$2 '$1==I{print $3}'
		else
			bjobs
		fi
	;;
	completion)
		if [[ $2 =~ ^([[:digit:]]+)$ ]]; then
			bpeek $2 | gawk '$0~/^\[.*\]$/{date=$0};$0~/^[[:digit:]]+ of [[:digit:]]+ steps \([[:digit:]]+%\) done$/{print $0 "\t" date}'
		fi
	;;
	df)
		#df ${clusterdir} ${SCRATCH}
		lquota -2 ${clusterdir}
		lquota -2 ${SCRATCH}
	;;
	*)
		echo "Unkown sub-command ${1}" > /dev/stderr
		exit 2
	;;
esac
