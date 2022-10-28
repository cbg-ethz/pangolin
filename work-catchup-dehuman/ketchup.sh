#!/usr/bin/env bash

umask 0007

scriptdir="$(dirname $(which $0))"
baseconda="$scriptdir/../"

#
# Input validator
#

validateDate() {
	if [[ "$1" =~ ^(20[0-9][0-9][0-1][0-9]([0-3][0-9]?)?)$ ]]; then
		return;
	else
		echo "bad date ${1}"
		exit 1;
	fi
}

validateBatchName() {
	if [[ "$1" =~ ^(20[0-9][0-9][0-1][0-9][0-3][0-9]_[[:alnum:]-]{4,})$ ]]; then
		return;
	else
		echo "bad batchname ${1}"
		exit 1;
	fi
}

validateTags() {
	for b in "${@}"; do
		validateBatchName "${b}"
	done
}


lastmonth=$(date '+%Y%m' --date='-1 month')

case "$1" in
	samples)
		list_tsv=( )
		case "$2" in
			--recent)
				list_tsv=( "${scriptdir}/../working/samples.recent.tsv" )
				shift
			;;
			--date)
				shift
				validateDate "${2}"
				list_tsv=( $(echo "../sampleset/samples.${2}"*".tsv" ) )
				shift
			;;
			--tsv)
				shift
				if [[ ! -r "${2}" ]]; then
					echo "Cannot read ${2}"
					exit 1
				fi
				# TODO validate
				list_tsv=( "${2}" )
				shift
			;;
		esac
		shift

		# get batches
		if [[ -n "${*}" ]]; then
			validateTags "${@}"
			for b in "${@}"; do
				s="${scriptdir}/../sampleset/samples.${b}.tsv"
				if [[ ! -s "${s}" ]]; then
					echo "missing sample file ${s}" > /dev/stderr
					exit 2
				fi
				list_tsv+=( "${s}" )
			done
		fi

		# check everything is normal
		if (( ${#list_tsv[@]} == 0 )); then
			echo "usage: ${0} samples [ --recent | --date <YYYYMM> | --tsv <TSV> ] <BATCH>..." > /dev/stderr
			exit 2
		fi

		echo "importing samples from:"
		printf ' - %s\n' "${list_tsv[@]}"
		sort -u "${list_tsv[@]}" > "${scriptdir}/samples.catchup.tsv"
		wc -l "${scriptdir}/samples.catchup.tsv"

		rm -rf "${scriptdir}/samples/"
		mkdir -p "${scriptdir}/samples/"
		cut -f1 "${scriptdir}/samples.catchup.tsv" | sort -u | while read s; do
			o="${scriptdir}/../working/samples/${s}"
			if [[ -d "${o}" ]]; then
				ln -fvs "$(realpath --relative-to="${scriptdir}/samples/" "${o}")" "${scriptdir}/samples/";
			fi; 
		done
		find "${scriptdir}/.snakemake/metadata/" "${scriptdir}/.snakemake/incomplete/" "${scriptdir}/cluster_logs/" -type f -print0 | xargs -r0 rm
		echo -e '\n\e[38;5;45;1mI ve experiments to run\e[0m\n\e[38;5;208;1mThere is research to be done\e[0m'
	;;

	scratch)
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
					filter='-name dehuman.sam'
					### dh_aln.sam
					### reject_R2.fastq.gz
					### reject_R1.fastq.gz
					### host_aln.sam
					### dehuman.filter
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

		hourago="${SCRATCH}/hourago.touch"
		temp_scratch="/cluster/scratch/bs-pangolin/pangolin/temp"
		touch --date="${olderthan} minutes ago" "${hourago}"

		if (( purge )); then
			echo "purging in ${temp_scratch}..."
		else
			echo "listing in ${temp_scratch}..."
		fi

		(cd "${temp_scratch}/" && find samples/ -type f ${filter} ) | grep -oP '(?<=samples/)[^/]+/[^/]+(?=/)' | sort -u | while read s; do 
			if [[ -s "${scriptdir}/samples/${s}/raw_uploads/dehuman.cram.md5" && "${scriptdir}/samples/${s}/raw_uploads/dehuman.cram.md5" -ot "${hourago}" ]]; then 
			#if [[ -r "${scriptdir}/../working/samples/${s}/upload_prepared.touch" && "${scriptdir}/../working/samples/${s}/upload_prepared.touch" -ot "${hourago}" ]]; then 
				if (( purge )); then
					rm -rvf  "${temp_scratch}/samples/${s}"
				else
					echo "${s}"; 
				fi
			fi; 
		done | tee /dev/stderr | wc -l 2>&1

		if (( loop )); then
			lquota -2 ${SCRATCH}
			echo -e '\n\e[38;5;45;1mYou just keep on trying\e[0m\n\e[38;5;208;1mTill you run out of cake\e[0m'
			if sleep "$(( 5 + olderthan))m"; then
				# loop if no breaks
				exec "${0}" scratch --minutes-ago "${olderthan}" --loop
			fi
			echo "I'm not even angry"
		fi
	;;

	check_reads)
		. $baseconda/miniconda3/bin/activate "qa"
		while read s b o; do
			declare -a r;
			r=( $(gawk -v s="${s}" -v b="${b}" 'BEGIN{FS=","};FNR==1{for(f=1;f<NF&&$f!="input_r1";f++);};$1==s&&$2==b{print $f " " $(f+1);}' ../working/qa/qa.${b}.csv) );
			f="$(<"samples/${s}/${b}/alignments/dehuman.count")";
			cram="samples/${s}/${b}/raw_uploads/dehuman.cram";
			cr="$(samtools view -c -F 2304 "${cram}")";
			(( tot=r[0] + r[1] - f ));
			echo -n "${r[0]}+${r[1]}-$f=${tot} vs ${cr} ";
			if (( tot > cr )); then
				echo "${cram}" | tee -a cram_error.txt;
			else
				echo ".";
			fi;
		done < samples.catchup.tsv
	;;

	delete_raw)
		cmd='printf %s\n'
		msg='\r\e[1mConsider %s/%b for deletion\e[0m\n'
		if [[ -n "$2" ]]; then
			case "$2" in
				--do-it)
					cmd='rm -v'
					msg='\r\e[36;1mDelete raw from %s/%b\e[0m\n'
				;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
		fi

		sort -u "${scriptdir}/samples.catchup.tsv" | while read s b o; do
			if [[ "${b}" > "${lastmonth}" ]]; then
				echo -e "\e[31;1mSkipping ${s}/${b} : too recent (${lastmonth})\e[0m"
				continue
			fi

			if [[
				-s "${scriptdir}/samples/${s}/${b}/raw_uploads/dehuman.cram.md5"
				&& -s "${scriptdir}/samples/${s}/${b}/raw_uploads/dehuman.cram"
				&& -e "${scriptdir}/samples/${s}/${b}/upload_prepared.touch"
				&& -s "${scriptdir}/samples/${s}/${b}/alignments/REF_aln.bam"
				&& -s "${scriptdir}/samples/${s}/${b}/references/consensus.bcftools.fasta"
			]]; then
				printf "${msg}" "${s}" "${b}"
			else
				echo -n '.'
				continue
			fi

			${cmd} "${scriptdir}/samples/${s}/${b}/"{raw_data,preprocessed_data}/*.fastq.gz "${scriptdir}/../sampleset/${s}/${b}/raw_data/"*.fastq.gz
			(cd "${scriptdir}/samples/"	&& rmdir --ignore-fail-on-non-empty --parents "${s}/${b}/raw_data" )
			(cd "${scriptdir}/../sampleset/" && rmdir --ignore-fail-on-non-empty --parents "${s}/${b}/raw_data" )
		done
		echo -e '\r\e[K\e[38;5;45;1mThis was a triumph! I m making a note here; "Huge success"\e[0m'
	;;

	still_around)
		sort -u "${scriptdir}/samples.catchup.tsv" | while read s b o; do
			if [[ -d "${scriptdir}/../sampleset/${s}/${b}/raw_data/" ]]; then
				echo -e "\r\e[K${s}/${b} still around"
			else
				echo -n '.'
			fi
		done 
		echo -e '\r\e[K\e[38;5;208;1mThe cake is a lie!\e[0m'
	;;

	df)
		exec "${scriptdir}/../batman.sh" "df"
		echo "Cannot find batman.sh"
		exit 2
	;;

	*)
		echo "Unkown subcommand ${1}" > /dev/stderr
		exit 2
	;;
esac
