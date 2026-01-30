#!/bin/bash

umask 0007

scriptdir="/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src"
baseconda="/cluster/project/pangolin/resources/miniconda3"
. ${scriptdir}/config/fgcz.conf
. ${scriptdir}/config/server.conf

#working=working
worktest=lollipop
#sampleset=vpipe_input

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

validateProto() {
	case "$1" in
		v3|v4|v41|v532|v542)
			return
		;;
		*)
			echo "bad proto ${1}"
			exit 1;
		;;
	esac
}



lastmonth=$(date '+%Y%m' --date='-1 month')
thismonth=$(date '+%Y%m')
thisyear=$(date '+%Y')

case "$1" in
	autoaddww|autoaddwastewater)
                if [[ -z "$2" ]] || [[ "$2" != "last_month" &&  "$2" != "this_month" && "$2" != "year" && "$2" != "all" ]]; then
                        echo "Usage: $0 $1 <TIMEFRAME>" 1>&2;
			echo "Accepted timeframes: last_month, this_month, year, all"
                        exit 0
                fi
		
		timeframe=$2
		if [[ "$timeframe" == "last_month" ]]; then
			custom_date=$lastmonth
		elif [[ "$timeframe" == "this_month" ]]; then
                        custom_date=$thismonth
		elif [[ "$timeframe" == "year" ]]; then
			custom_date=$thisyear
		elif [[ "$timeframe" == "all" ]]; then
                        custom_date="2"
		fi

		projects=( 'p23224' )
		projpat="$( ( IFS='|';echo "${projects[*]}" ) )"
		gawk -v d="${custom_date}" '$2<d' ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv > ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv.old
		{
			# assemble samples.wastewateronly.tsv
			{
				printf '%s\n' ${clusterdir_old}/${clusterdir}/${sampleset}/projects.${custom_date}*.tsv | grep -vF '*' | sort -r | while read p; do
					echo -n "${p} - ${p//projects/samples} ... " >&2
					gawk -v projpat="${projpat}" '(FILENAME~/\/projects\./)&&($2~projpat){ww[$1]++;nww++};(FILENAME~/\/samples\./)&&(ww[$1]);END{print nww >> "/dev/stderr"}' "${p}" "${p//projects/samples}"
				done | tee >(cut -f4 >&3) # pass the protos to the second part bellow
				cat ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv.old
			} > ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv
		} 3>&1 | sort | uniq -c | while read cnt PROTO o; do
			echo "proto: ${PROTO} (${cnt})"
			gawk -v proto="${PROTO}" '$4==proto' ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv > ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.${PROTO}.tsv
			row_count=$(wc -l < "${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv")
			echo "${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv"
			echo "$row_count"
		done;
	;;

	shufflebatches)
		if [[ -z "$2" || "$2" == "--help" ]]; then
			echo "Usage: $0 $1 <BATCH>" 1>&2;
			exit 0
		fi

		BATCH=$2
		validateBatchName "${BATCH}"

		# check existing
		if [[ ! -e "sampleset/samples.${BATCH}.tsv" ]]; then
			echo "Cannot find batch ${BATCH}" >&2
			exit 1
		fi

		echo "batch ${BATCH}"

		# majority votre proto
		read cnt PROTO o < <(cut -f4 ${clusterdir_old}/${clusterdir}/${sampleset}/samples.${BATCH}.tsv | sort | uniq -c | tee /dev/stderr)
		echo "proto: ${PROTO}"

		#
		# Proto validate + specific files
		#
		case "${PROTO}" in
			v3)	bedfile="cojac/nCoV-2019.insert.${PROTO^^}.bed"	;;
			v4)	bedfile="cojac/SARS-CoV-2.insert.${PROTO^^}.txt"	;;
			v41)	bedfile="cojac/SARS-CoV-2.insert.${PROTO^^}.bed"	;;
			*)
				echo "bad proto ${PROTO}"
				exit 1;
			;;
		esac
		allprototsv=( ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.{v41,v4,v3}.tsv )
		if [[ ! -r "${bedfile}" ]]; then
			echo "missing bedfile ${bedfile}"
			exit 1;
		fi

		# 'lastweek' backup
		if grep -qF "${BATCH}" ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly${PROTO:+.${PROTO}}.tsv; then
			echo "using:"
			ls -l ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly${PROTO:+.${PROTO}}{,.lastweek,.thisweek}.tsv
		else
			echo "backing up lastweek:"
			cp -v ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly${PROTO:+.${PROTO}}{,.lastweek}.tsv
		fi

		(grep -vP '^(Y\d{2,}|NC|\d{6,})' "${clusterdir_old}/${clusterdir}/${sampleset}/samples.${BATCH}.tsv" | tee ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly${PROTO:+.${PROTO}}.thisweek.tsv ; cat ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly${PROTO:+.${PROTO}}.lastweek.tsv) > ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly${PROTO:+.${PROTO}}.tsv
		cat "${allprototsv[@]}" > ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv
	;;

	bring_results)
		TSV=samples.wastewateronly.tsv
		TSV_sixmonth=samples.tsv_six_months_ago.tsv
		overwrite=0
		if [[ -n "$2" ]]; then
			case "$2" in
				--overwrite)
					overwrite=1
				;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
		fi

		# bring current list in
		if cp ${clusterdir_old}/${clusterdir}/${working}/${TSV} ${clusterdir_old}/${clusterdir}/${worktest}/; then
			ln -sf "${TSV}" ${clusterdir_old}/${clusterdir}/${worktest}/samples.tsv
		else
			echo "Cannot find ${TSV}"
			exit 1
		fi

		# bring TSV_sixmonth list in
		if cp ${clusterdir_old}/${clusterdir}/${working}/${TSV_sixmonth} ${clusterdir_old}/${clusterdir}/${worktest}/; then
			continue
		else
			echo "Cannot find ${TSV_sixmonth}"
			exit 1
		fi

		if (( overwrite )); then
			echo "Entirely rebuilding results/ directory"
		else
			echo "Appending missing samples to results/ directory"
		fi

		mkdir -p ${clusterdir_old}/${clusterdir}/${worktest}/results/

		while read s b o; do
			rmdir --ignore-fail-on-non-empty ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/
			if (( overwrite )); then
				rm -rvf ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/
			elif [[ -e ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/alignments/REF_aln_trim.bam ]]; then
				continue
			fi

			mkdir -p ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/
			if grep -q ${s} /cluster/project/pangolin/resources/lollipop_blacklist.txt || grep -q ${b} /cluster/project/pangolin/resources/lollipop_blacklist.txt; then
				echo "Skipping ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/ in /cluster/project/pangolin/resources/lollipop_blacklist.txt"
			else
				#cp -alv ${clusterdir_old}/${clusterdir}/vpipe_output/${s}/${b}/{references,alignments} ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/
				cp -alv ${clusterdir_old}/${clusterdir}/vpipe_output/${s}/${b}/ ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/
			fi
		done < ${clusterdir_old}/${clusterdir}/${worktest}/${TSV}
        for i in $(cat /cluster/project/pangolin/resources/lollipop_blacklist.txt); do
            while read -r line
            do
                [[ ! $line =~ $i ]] && echo "$line"
            done <${clusterdir_old}/${clusterdir}/${worktest}/${TSV} > ${clusterdir_old}/${clusterdir}/${worktest}/${TSV}_temp
            mv ${clusterdir_old}/${clusterdir}/${worktest}/${TSV}_temp ${clusterdir_old}/${clusterdir}/${worktest}/${TSV}
        done
		for i in $(cat /cluster/project/pangolin/resources/lollipop_blacklist.txt); do
            while read -r line
            do
                [[ ! $line =~ $i ]] && echo "$line"
            done <${clusterdir_old}/${clusterdir}/${worktest}/${TSV_sixmonth} > ${clusterdir_old}/${clusterdir}/${worktest}/${TSV_sixmonth}_temp
            mv ${clusterdir_old}/${clusterdir}/${worktest}/${TSV_sixmonth}_temp ${clusterdir_old}/${clusterdir}/${worktest}/${TSV_sixmonth}
        done
	;;

	fetch_cooc)
		proto=${2:-v532}
		validateProto "${proto}"
		echo "fetching ${proto}:"

		gawk -v proto="${proto}" '$4==proto' ${clusterdir_old}/${clusterdir}/${worktest}/samples.tsv | while read s b o; do cat ${clusterdir_old}/${clusterdir}/${worktest}/results/${s}/${b}/signatures/cooc.yaml; echo -n '.' >&2; done > ${clusterdir_old}/${clusterdir}/${worktest}/cooc.${proto}.yaml
		echo "done"
	;;

	export)
		base_ww=/cluster/project/pangolin/work-vp-test
		base_main=/cluster/project/pangolin/working
		export_base=/cluster/project/pangolin/export

		timeline="${base_ww}/variants/timeline.tsv" # TODO marge with main in the future
		mainresults="${base_main}/samples/" # TODO switch to results in the future
		tail -n +2 "${timeline}" | while read s b o; do
			#mkdir -p --mode=0775 ${export_base}/{,${s}/{,${b}/{,uploads/,alignments/}}}
			install  --preserve-timestamps --mode=0775  -D --directory "${export_base}/${s}/${b}/"{uploads,alignments}/
			install  --preserve-timestamps --mode=0664  -D --target-directory="${export_base}/${s}/${b}/alignments/" "${mainresults}/${s}/${b}/alignments/"{dehuman.count,REF_aln_stats.yaml}
			cp --link -vf "${mainresults}/${s}/${b}/uploads/dehuman.cram"* "${export_base}/${s}/${b}/uploads/"
			chmod o+r "${export_base}/${s}/${b}/uploads/dehuman.cram"*
		done
	;;

	*)
		echo "Unkown subcommand ${1}" > /dev/stderr
		exit 2
	;;
esac
