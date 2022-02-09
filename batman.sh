#!/bin/bash

clusterdir=/cluster/project/pangolin
working=working
sampleset=sampleset

#
# Input validator
#
validateBatchName() {
	if [[ "$1" =~ ^(20[0-9][0-9][0-1][0-9][0-3][0-9]_[[:alnum:]-]{4,})$ ]]; then
		return;
	else
		echo "bad batchname ${1}"
		exit 1;
	fi
}

validateTags() {
	local IFS="$1"
	for b in $2; do
		validateBatchName "${b}"
	done
}


RXJOB='Job <([[:digit:]]+)> is submitted'
# Generic job.
# Job <129052039> is submitted to queue <light.5d>.

now=$(date '+%Y%m%d')
lastmonth=$(date '+%Y%m' --date='-1 month')
thismonth=$(date '+%Y%m')
twoweeksago=$(date '+%Y%m%d' --date='-2 weeks')

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
		lst="${clusterdir}/${working}/samples.tsv"
		case "$2" in
			--recent)
				lst="${clusterdir}/${working}/samples.recent.tsv"
				echo "syncing recent: ${lastmonth}, ${thismonth}"
			;;
			*)
				echo "Unkown parameter ${2}" > /dev/stderr
				exit 2
			;;
		esac
		mkdir -p --mode=2770 "${clusterdir}/${working}/samples/"
		#cp -vrf --link ${clusterdir}/${sampleset}/*/ ${clusterdir}/${working}/samples/   ## failure: "no rule to create {SAMPLE}/extract/R1.fastq"
		cat ${clusterdir}/${sampleset}/samples.{${lastmonth},${thismonth}}*.tsv | sort -u > "${clusterdir}/${working}/samples.recent.tsv"
		sort -u ${clusterdir}/${sampleset}/samples.*.tsv > "${clusterdir}/${working}/samples.tsv"
		cut -f1 "${lst}" | xargs -P 8 -i cp -vrf --link "${clusterdir}/${sampleset}/{}/" "${clusterdir}/${working}/samples/"
	;;
	vpipe)
		declare -A job
		list=('seq' 'seqqa' 'snv' 'snvqa' 'hugemem' 'hugememqa')
		shorah=1
		hold=
		tag=
		while [[ -n $2 ]]; do
			case "$2" in
				--no-shorah)
					shorah=0
				;;
				--hold)
					hold='-H'
				;;
				--tag)
					shift
					if [[ ! "${2}" =~ ^[[:alnum:]]+$ ]]; then
						# if it's not just letters and number, test if it is a list of valid batches
						validateTags ';' "$2"
					fi
					tag="${2%;}"
				;;
 				--recent)
#					# TODO switch between full cohort and only recent
# 					#recent="..."
 				;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
			shift
		done
		# start first job
		cd ${clusterdir}/${working}/
		# use -H to put on hold for analysis
		if [[ "$(sed "s/@TAG@/<${tag}>/g" vpipe-no-shorah.bsub | bsub -J "COVID-vpipe-<${tag}>-cons" ${hold})" =~ ${RXJOB} ]]; then
			job['seq']=${BASH_REMATCH[1]}
			# schedule a gatherqa no mater what happens
			[[ "$(sed "s/@TAG@/<${tag}>/g" qa-launcher | bsub -J "COVID-vpipe-<${tag}>-qa" ${hold} -w "ended(${job['seq']})")" =~ ${RXJOB} ]] && job['seqqa']=${BASH_REMATCH[1]}
			# if no fail schedule a full job with snv
			if (( shorah )) && [[ "$(bsub ${hold} -w "done(${job['seq']})" -ti < vpipe.bsub)"  =~ ${RXJOB} ]]; then
				job['snv']=${BASH_REMATCH[1]}
				# schedule a gatherqa no matter what happens to snv
				[[ "$(bsub ${hold} -w "done(${job['seq']})&&ended(${job['snv']})"  < qa-launcher)" =~ ${RXJOB} ]] && job['snvqa']=${BASH_REMATCH[1]}
				# schedule a hugemem job if snvjob failed
				if [[ "$(bsub ${hold} -w "done(${job['seq']})&&exit(${job['snv']})" -ti < vpipe-hugemem.bsub)" =~ ${RXJOB} ]]; then
					job['hugemem']=${BASH_REMATCH[1]}
					# schedule a qa afterward
					[[ "$(bsub -w "done(${job['seq']})&&exit(${job['snv']})&&ended(${job['hugemem']})" -ti  < qa-launcher)" =~ ${RXJOB} ]] && job['hugememqa']=${BASH_REMATCH[1]}
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
	purgelogs)
		find ${clusterdir}/${working}/cluster_logs/ -type f -mtime +28 -name '*.log' -print0 | xargs -0 rm -- 
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
	garbage)
		validateBatchName "$2"
		cd ${clusterdir}

		for f in ${sampleset}/*/${2}; do 
			garbage=$(dirname "${f//${sampleset}/garbage}")
			mkdir --mode=0770 -p "${garbage}"
			mv -v "${f%/}" "${garbage}/"
		done
		for f in ${working}/samples/*/${2}/; do 
			garbage="${f//${working}\/samples/garbage}"
			mkdir --mode=0770 -p "${garbage%/}/"{raw_data,extracted_data}/
			mv -vf "${f%/}/raw_data/"* "${garbage%/}/raw_data/"
			rm "${f%/}/raw_data/"*.fa*
			rmdir "${f%/}/raw_data/"
			mv -vf "${f%/}/extracted_data/"* "${garbage%/}/extracted_data/"
			rm "${f%/}/extracted_data/"*{.log,.benchmark,_fastqc.html}
			rmdir "${f%/}/extracted_data/"
			mv -vf "${f%/}/"* "${garbage%/}/"
			rmdir "${f%/}"
		done
		mv "${sampleset}/batch.${2}.yaml" "${sampleset}/samples.${2}.tsv" "${sampleset}/missing.${2}.txt" "${sampleset}/projects.${2}.tsv" garbage/
	;;
	*)
		echo "Unkown sub-command ${1}" > /dev/stderr
		exit 2
	;;
esac
