#!/bin/bash

clusterdir=/cluster/work/bewi/pangolin
working=working-dev
sampleset=sampleset

RXJOB='Job <([[:digit:]]+)> is submitted'
# Generic job.
# Job <129052039> is submitted to queue <light.5d>.

case "$1" in
	rsync)
		# rsync daemon : see ${SSH_ORIGINAL_COMMAND}
		rsync --server --daemon .
	;;
	addsamples)
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
			if [[ "$(bsub -w "done(${job['seq']})" -ti < test.bsub)"  =~ ${RXJOB} ]]; then
				job['snv']=${BASH_REMATCH[1]}
				# schedulte a gatherqa no matter what happens
				[[ "$(bsub -w "ended(${job['snv']})"  < gatherqa)" =~ ${RXJOB} ]] && job['snvqa']=${BASH_REMATCH[1]}
				# schedule a hugemem job if snvjob failed
# 				if [[ "$(bsub -w "exited(${job['snv']})" -ti < vpipe-hugemem.bsub)" =~ ${RXJOB} ]]; then
# 					job['hugemem']=${BASH_REMATCH[1]}
# 					# schedule a qa afterward
# 					[[ "$(bsub -w "exited(${job['snv']})&&ended(${job['hugemem']})" -ti  < gatherqa)" =~ ${RXJOB} ]] && job['hugememqa']=${BASH_REMATCH[1]}
# 				fi
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
	*)
		echo "Unkown sub-command ${1}" > /dev/stderr
		exit 2
	;;
esac
