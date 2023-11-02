#!/bin/bash

clusterdir=/cluster/project/pangolin
working=working
sampleset=sampleset
vilocadir=work-viloca/SARS-CoV-2-wastewater-sample-processing-VILOCA


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


now=$(date '+%Y%m%d')
lastmonth=$(date '+%Y%m' --date='-1 month')
thismonth=$(date '+%Y%m')
twoweeksago=$(date '+%Y%m%d' --date='-2 weeks')

if [[ "$1" == "--limited" ]]; then
	shift
	case "$1" in
		rsync|df)
			# sub-commands allowed in limited mode.
		;;
		*)
			echo "sub-command ${1} not allowed in limited mode" >&2
			exit 2
		;;
	esac
fi

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
					# use --hold to put on hold for analysis
					hold='--hold'
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

		job['seq']="$(sed "s/@TAG@/<${tag}>/g" vpipe-no-shorah.sbatch | sbatch --parsable ${hold} --job-name="COVID-vpipe-<${tag}>-cons")"
		if [[ -n "${job['seq']}" ]]; then
			# schedule a gatherqa no mater what happens
			job['seqqa']="$(sbatch --parsable  ${hold} --job-name="COVID-qa-<${tag}>" --dependency="afterany:${job['seq']}" qa-launcher)"
			# if no fail schedule a full job with snv
			if (( shorah )); then
				job['snv']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']}" --kill-on-invalid-dep=yes vpipe.sbatch)"
				if [[ -n "${job['snv']}" ]]; then
					# schedule a gatherqa no matter what happens to snv
					job['snvqa']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']},afterany:${job['snv']}" --kill-on-invalid-dep=yes qa-launcher)"
					# schedule a hugemem job if snvjob failed
					job['hugemem']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']},afternotok:${job['snv']}" --kill-on-invalid-dep=yes vpipe-hugemem.sbatch)"
					# schedule a qa afterward
					[[ -n "${job['hugemem']}" ]]	&& \
						job['hugememqa']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']},afternotok:${job['snv']},afterany:${job['hugemem']}" --kill-on-invalid-dep=yes qa-launcher)"
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
			read output other < <(sacct -j "$2" --format State --noheader)
			echo "${output}"
		else
			squeue
		fi
	;;
	purgelogs)
		find ${clusterdir}/${working}/cluster_logs/ -type f -mtime +28 -name '*.log' -print0 | xargs -0 rm -- 
	;;
	scratch)
		temp_scratch="${SCRATCH}/pangolin/temp"
		olderthan=60
		purge=0
		loop=0
		filter=
		while [[ -n $2 ]]; do
			case "$2" in
				--minutes-ago)
					if [[ ! "${3}" =~ ^[[:digit:]]+$ ]]; then
						echo "parameter of ${2} must be a number of minutes (digits only), got <${3}> instead" > /dev/stderr
						exit 2
					fi
					shift
					olderthan=$2
				;;
				--loop)
					loop=1
				;&
				--purge)
					purge=1
				;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
			shift
		done

		if (( purge )); then
			echo "purging in ${temp_scratch}..."
		else
			echo "listing in ${temp_scratch}..."
		fi

		count_all=0
		count_old=0
		while read s; do
			(( ++count_all ))
			if [[ -r "${clusterdir}/${working}/samples/${s}/upload_prepared.touch" &&  $(find "${clusterdir}/${working}/samples/${s}/upload_prepared.touch" '!' -newermt "${olderthan} minutes ago") ]]; then
				(( ++count_old ))
				if (( purge )); then
					rm -rvf  "${temp_scratch}/samples/${s}"
				else
					echo "${s}";
				fi
			fi;
		done < <((cd "${temp_scratch}/" && find samples/ -type f ${filter} ) | grep -oP '(?<=samples/)[^/]+/[^/]+(?=/)' | sort -u) | tee /dev/stderr | wc -l  2>&1
		echo "Samples: ${count_old} old / ${count_all} total"

		if (( loop )); then
			echo -e '\n\e[38;5;45;1mYou just keep on trying\e[0m\n\e[38;5;208;1mTill you run out of cake\e[0m'
			if sleep "$(( 5 + olderthan))m"; then
				# loop if no breaks
				exec "${0}" scratch --minutes-ago "${olderthan}" --loop
			fi
			echo "I'm not even angry"
		fi
	;;
	completion)
		if [[ $2 =~ ^([[:digit:]]+)$ ]]; then
			gawk '$0~/^\[.*\]$/{date=$0};$0~/^[[:digit:]]+ of [[:digit:]]+ steps \([[:digit:].]+%\) done$/{print $0 "\t" date}' "${clusterdir}/${working}/slurm-${2}.out"
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
	viloca)
		cd ${clusterdir}/${vilocadir}/
		. ../../miniconda3/bin/activate 'base'
		. run_workflow.sh
		# write job chain list
		for v in "${list[@]}"; do
			printf "%s\t%s\n" "${v}" "${job[$v]}"
		done
	;;
	unlock_viloca)
		cd ${clusterdir}/${vilocadir}/
		. ../../miniconda3/bin/activate 'base'
		snakemake --unlock
	;;
	archive_viloca_run)
		validateBatchName $2
		cd ${clusterdir}/work-viloca/
		if [ ! -d results_archive ]; then
			mkdir results_archive
		fi
		mkdir "results_archive/${2}"
		mv "${clusterdir}/${vilocadir}/results/*" "${clusterdir}/work-viloca/"
	;;
	*)
		echo "Unkown sub-command ${1}" > /dev/stderr
		exit 2
	;;
esac
