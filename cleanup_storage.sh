#!/bin/bash

scriptdir=/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src
garbage_logs=/cluster/project/pangolin/data/garbage/logs
. ${scriptdir}/config/server.conf
. ${clusterdir}/config/fgcz.conf

umask 0007

#enable globbing
shopt -s nullglob
set +f

custom_date=$(date '+%Y%m%d' --date='-6 months')

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
		type="covid"
		virusbase=(".")
		parent="sampleset"
		togarbage=("raw_data/*" "extracted_data/*")
		if doit:
			garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_sampleset.log
		else:
			garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_sampleset_dry.log
		fi
	;;
        clean_preproc_covid)
		type="covid"
		virusbase=(".")
		parent="working/samples"
		togarbage=("preprocessed_data/*fastq.gz")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_preproc.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_preproc_dry.log
                fi
	;;
	clean_raw_covid)
		type="covid"
                virusbase=(".")
                parent="working/samples"
		togarbage=("raw_data/*fastq.gz")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw_dry.log
                fi
	;;
	clean_raw_uploads_covid)
		type="covid"
                virusbase=(".")
                parent="working/samples"
		togarbage=("raw_uploads/dehuman.cram" "raw_uploads/raw_reads.cram")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_cram.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_cram_dry.log
                fi
	;;
	clean_sampleset_rsv)
		type="rsv"
		virusbase=("rsv_pipeline")
		parent="sampleset"
		togarbage=("raw_data/*" "extracted_data/*")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_sampleset.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_sampleset_dry.log
                fi
	;;
	clean_preproc_rsv)
		type="rsv"
		virusbase=("rsv_pipeline/RSVA" "rsv_pipeline/RSVB")
		parent="working/results"
		togarbage=("preprocessed_data/*fastq.gz")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_preproc.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_preproc_dry.log
                fi
	;;
	clean_raw_rsv)
		type="rsv"
                virusbase=("rsv_pipeline/RSVA" "rsv_pipeline/RSVB")
                parent="working/samples"
		togarbage=("raw_data/*fastq.gz")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw_dry.log
                fi
	;;
	clean_sampleset_flu)
		type="flu"
		virusbase=("influenza_pipeline")
		parent="sampleset"
		togarbage=("raw_data/*" "extracted_data/*")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_sampleset.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_sampleset_dry.log
                fi
	;;
	clean_preproc_flu)
		type="flu"
		virusbase=("influenza_pipeline/IA_H1" "influenza_pipeline/IA_H3" "influenza_pipeline/IA_MP" "influenza_pipeline/IA_N1" "influenza_pipeline/IA_N2")
		parent="working/results"
		togarbage=("preprocessed_data/*fastq.gz")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_preproc.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_preproc_dry.log
                fi
	;;
	clean_raw_flu)
                type="flu"
                virusbase=("influenza_pipeline/IA_H1" "influenza_pipeline/IA_H3" "influenza_pipeline/IA_MP" "influenza_pipeline/IA_N1" "influenza_pipeline/IA_N2")
		parent="working/samples"
                togarbage=("raw_data/*fastq.gz")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw_dry.log
                fi
        ;;
	clean_raw_fgcz)
		type="fgcz"
		base=${clusterdir_old}/data/${bfabric_downloads}
		#NOTE: projlist MUST be a bash array defined in fgcz.conf
		if declare -p projlist &>/dev/null && \
			declare -p projlist | grep -q 'declare \-a'; then
			echo "projlist exists and is an array" | 
		else
			echo "projlist is not defined in fgcz.conf or not an array"
			exit 100
		fi
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_raw_dry.log
                fi
	;;
	clean_lollipop)
		type="lollipop"
		base=("work-vp-test/results")
		togarbage=("alignments/basecnt.tsv.gz" "alignments/host_aln.cram" "alignments/REF_aln.bam" "alignments/REF_aln_trim.bam")
		if doit:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}.log
                else:
                        garbage_logfile=${garbage_logs}/$(date '+%Y%m%d')_${type}_dry.log
                fi
	;;
	*)
		echo "Error: unrecognized option"
		exit 1
	;;
esac

if [[ "$type" == "fgcz" ]];then
	for prj in "${projlist[@]}"; do
		garbagedir="${clusterdir_old}/garbage/${type}/${prj}"
		readarray -t dirs < <(
			ls -l "${base}/${prj}" --time-style=+'%Y%m%d %H:%M:%S' | \
				awk -v d="$custom_date" '$6 < d { print $8 }' | \
				tail -n +2
		)
		for d in "${dirs[@]}"; do
			origin=${base}/${prj}/${d}
  			echo "Processing directory: $origin" | tee -a ${garbage_logfile}
				if $doit; then
                                        mkdir -p ${garbagedir}
                                        eval "mv ${origin} ${garbagedir}"
                                else
                                        echo "[dryrun] mkdir -p ${garbagedir}" | tee -a ${garbage_logfile}
                                        eval "echo [dryrun] mv ${origin} ${garbagedir}" | tee -a ${garbage_logfile}
                                fi
		done
	done
elif [[ "$type" == "lollipop" ]];then
	garbagedir="${clusterdir_old}/garbage/lollipop"
	gawk -v d="${custom_date}" '$2 < d' \
		"${clusterdir_old}/work-vp-test/samples.wastewateronly.tsv" > "${clusterdir_old}/work-vp-test/samples.tsv.toclean"
	while IFS=$'\t' read -r sample batch _rest; do
		for item in "${togarbage[@]}"; do
			tomove="${clusterdir_old}/${base}/${sample}/${batch}/${item}"
			garbagedir="${clusterdir_old}/garbage/${type}/${base}/${sample}/${batch}/${item%/*}"
			echo "Evaluating ${tomove}/" | tee -a ${garbage_logfile}
			if compgen -G "$tomove" > /dev/null; then
				if $doit; then
					echo "Moving ${tomove}/ to the garbage dir" | tee -a ${garbage_logfile}
                                	mkdir -p ${garbagedir}
					eval "mv ${tomove} ${garbagedir}"
				else
					echo [dryrun] mkdir -p ${garbagedir} | tee -a ${garbage_logfile}
			        	eval "echo [dryrun] mv ${tomove} ${garbagedir}" | tee -a ${garbage_logfile}
				fi
                        fi
		done
	done < "${clusterdir_old}/work-vp-test/samples.tsv.toclean"
else
	for subtype in "${virusbase[@]}"; do
		gawk -v d="${custom_date}" '$2 < d' \
			"${clusterdir_old}/${subtype}/working/samples.tsv" > "${clusterdir_old}/${subtype}/working/samples.tsv.toclean"
		while IFS=$'\t' read -r sample batch _rest; do
			for item in "${togarbage[@]}"; do
				tomove="${clusterdir_old}/${subtype}/${parent}/${sample}/${batch}/${item}"
				subtype_garbagedir=${subtype#*/}
				garbagedir="${clusterdir_old}/garbage/${type}/${subtype_garbagedir}/${parent}/${sample}/${batch}/${item%/*}"
				echo "Evalutating ${tomove}/" | tee -a ${garbage_logfile}
				if compgen -G "$tomove" > /dev/null; then
					#eval tomove=$tomove
					if $doit; then
						echo "Moving ${tomove}/ to the garbage dir" | tee -a ${garbage_logfile}
						mkdir -p ${garbagedir}
						eval "mv ${tomove} ${garbagedir}"
					else
						echo [dryrun] mkdir -p ${garbagedir} | tee -a ${garbage_logfile}
						eval "echo [dryrun] mv ${tomove} ${garbagedir}" | tee -a ${garbage_logfile}
					fi
				fi
			done
		done < "${clusterdir_old}/${subtype}/working/samples.tsv.toclean"
	done
fi
