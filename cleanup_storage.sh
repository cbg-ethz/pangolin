#!/bin/bash

scriptdir=/cluster/project/pangolin/test_automation/pangolin/pangolin_src
. ${scriptdir}/config/server.conf

umask 0007

#enable globbing
shopt -s nullglob
set +f

custom_date=$(date '+%Y%m%d' --date='-3 months')

if [ -z "${1-}" ]; then
  echo "Error: missing required argument." >&2
  exit 1
fi

if (( $# >= 2 )) && [[ $2 == "doit" ]]; then
	echo "THIS NOT A DRYRUN!"
	echo "Please run the dryrun beforehand and check the output!"
	echo "To do so, run the command without the additional option 'doit'"
	echo "The procedure will continue in 15 seconds. Please press CTRL+c to abort"
	doit=true
	sleep 15
else
	echo "This is a dry run."
	echo "The commands that would be run if you use the 'doit' option will be printed on screen"
        doit=false
fi


case "$1" in
	clean_sampleset_covid)
		virus="covid"
		virusbase=(".")
		parent="sampleset"
		togarbage=("raw_data/*" "extracted_data/*")
	;;
        clean_preproc_covid)
		virus="covid"
		virusbase=(".")
		parent="working/samples"
		togarbage=("preprocessed_data/*fastq.gz")
	;;
	clean_sampleset_rsv)
		virus="rsv"
		virusbase=("rsv_pipeline")
		parent="sampleset"
		togarbage=("raw_data/*" "extracted_data/*")
	;;
	clean_preproc_rsv)
		virus="rsv"
		virusbase=("rsv_pipeline/RSVA" "rsv_pipeline/RSVB")
		parent="working/results"
		togarbage=("preprocessed_data/*fastq.gz")
	;;
	clean_raw_rsv)
		virus="rsv"
                virusbase=("rsv_pipeline/RSVA" "rsv_pipeline/RSVB")
                parent="working/samples"
		togarbage=("raw_data/*fastq.gz")
	;;
	clean_sampleset_flu)
		virus="flu"
		virusbase=("influenza_pipeline")
		parent="sampleset"
		togarbage=("raw_data/*" "extracted_data/*")
	;;
	clean_preproc_flu)
		virus="flu"
		virusbase=("influenza_pipeline/IA_H1" "influenza_pipeline/IA_H3" "influenza_pipeline/IA_MP" "influenza_pipeline/IA_N1" "influenza_pipeline/IA_N2")
		parent="working/results"
		togarbage=("preprocessed_data/*fastq.gz")
	;;
	clean_raw_flu)
                virus="flu"
                virusbase=("influenza_pipeline/IA_H1" "influenza_pipeline/IA_H3" "influenza_pipeline/IA_MP" "influenza_pipeline/IA_N1" "influenza_pipeline/IA_N2")
		parent="working/samples"
                togarbage=("raw_data/*fastq.gz")
        ;;
	*)
		echo "Error: unrecognized option"
		exit 1
	;;
esac

for subtype in ${virusbase[@]}; do
	gawk -v d="${custom_date}" '$2 < d' \
		"${clusterdir_old}/${subtype}/working/samples.tsv" > "${clusterdir_old}/${subtype}/working/samples.tsv.toclean"
	while IFS=$'\t' read -r sample batch _rest; do
		for item in "${togarbage[@]}"; do
			tomove="${clusterdir_old}/${subtype}/${parent}/${sample}/${batch}/${item}"
			subtype_garbagedir=${subtype#*/}
			garbagedir="${clusterdir_old}/garbage/${virus}/${subtype_garbagedir}/${parent}/${sample}/${batch}/${item%/*}"
			echo "Garbaging ${tomove}/"
			if compgen -G "$tomove" > /dev/null; then
				#eval tomove=$tomove
				if $doit; then
					mkdir -p ${garbagedir}
					eval "mv ${tomove} ${garbagedir}"
				else
					echo [dryrun] mkdir -p ${garbagedir}
					eval "echo [dryrun] mv ${tomove} ${garbagedir}"
				fi
			fi
		done
	done < "${clusterdir_old}/${subtype}/working/samples.tsv.toclean"
done

