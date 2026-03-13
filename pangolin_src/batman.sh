#!/bin/bash

scriptdir=/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src
. ${scriptdir}/config/server.conf

status=${clusterdir_old}/${clusterdir}/status
vilocadir=${remote_viloca_basedir}/${viloca_processing}



eval "$(/cluster/project/pangolin/resources/miniconda3/bin/conda shell.bash hook)"

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

#
# sync helper
#
checksyncoutput() {
    local new="${status}/sync${1}_new"
    local last="${status}/sync${1}_last"

    if [[ "${2}" =~ Total:\ +([[:digit:]]+)\ +directories,\ +([[:digit:]]+)\ +files,.*?New:\ +([[:digit:]]+)\ +files, ]]; then
        echo "Newfiles downloaded"
        echo -e "${BASH_REMATCH[2]}\n${BASH_REMATCH[1]}" > ${last}
        flock -x -o ${last} -c "sleep 1"
        echo "${BASH_REMATCH[3]}" > ${new}
    else
        echo "No files to sync found"
        touch ${last}
    fi 2>&1
}


RXJOB='Job <([[:digit:]]+)> is submitted'
# Generic job.
# Job <129052039> is submitted to queue <light.5d>.

now=$(date '+%Y%m%d')
lastmonth=$(date '+%Y%m' --date='-1 month')
thismonth=$(date '+%Y%m')
twoweeksago=$(date '+%Y%m%d' --date='-2 weeks')
year=$(date '+%Y')
lastyear=$(date '+%Y%m' --date='-1 year')

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
                # ---- Core paths and defaults ----------------------------------------
                shared_workdir="${clusterdir_old}/${clusterdir}/${working}"   # shared working directory
                samples_dir="${clusterdir_old}/${clusterdir}/${sampleset}"    # directory containing all samples.*.tsv files
                copy_list_name="samples.tsv"                                  # subtype list used later for copying
                aviti=0                                                       # legacy flag kept for compatibility

                # ---- Exclusion settings ---------------------------------------------
                # Load global and subtype-specific sample exclusions from fgcz.conf.
                . <(
                        grep -E '^(exclude_samples|exclude_samples_ia_h1|exclude_samples_ia_h3|exclude_samples_ia_mp|exclude_samples_ia_n1|exclude_samples_ia_n2)=' \
                        "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf" \
                        || true
                )

                influenza_subtypes_list=(IA_H1 IA_H3 IA_MP IA_N1 IA_N2)       # influenza subtype directories to prepare

                # ---- Helper: filter a TSV stream by sample name ----------------------
                # Removes rows whose sample name in column 1 appears in the provided
                # comma-separated exclusion list.
                filter_excluded_samples() {
                        local excl="$1"
                        awk -F '\t' -v excl="$excl" '
                        BEGIN {
                                n = split(excl, a, ",")
                                for (i = 1; i <= n; i++) {
                                        gsub(/^[ \t]+|[ \t]+$/, "", a[i])     # trim whitespace around sample names
                                        if (a[i] != "")
                                                drop[a[i]] = 1                # mark sample for exclusion
                                }
                        }
                        !($1 in drop)                                         # keep only non-excluded sample rows
                        '
                }

                # ---- Helper: build one filtered samples file -------------------------
                # Applies global exclusions first, then subtype-specific exclusions,
                # sorts uniquely, and writes the result to the requested output file.
                build_filtered_samples_file() {
                        local output_file="$1"
                        local subtype_exclude="$2"
                        shift 2

                        cat "$@" \
                                | filter_excluded_samples "${exclude_samples:-}" \
                                | filter_excluded_samples "${subtype_exclude}" \
                                | sort -u \
                                > "${output_file}"
                }

                # ---- Helper: collect the source samples.*.tsv files for a mode ------
                # Populates the global array "mode_files".
                collect_mode_files() {
                        local mode="$1"
                        mode_files=()

                        case "$mode" in
                                recent)
                                        # Use the last and current month.
                                        mapfile -t mode_files < <(
                                                ls -1 "${samples_dir}"/samples."${lastmonth}"*.tsv \
                                                      "${samples_dir}"/samples."${thismonth}"*.tsv 2>/dev/null \
                                                | sort -u
                                        )
                                ;;
                                year)
                                        # Use all files for the selected year.
                                        mapfile -t mode_files < <(
                                                ls -1 "${samples_dir}"/samples."${year}"*.tsv 2>/dev/null
                                        )
                                ;;
                                all)
                                        # Use all files from influenza_startdate onward.
                                        local startmonth="${influenza_startdate:0:6}"   # YYYYMM
                                        mapfile -t mode_files < <(
                                                ls -1 "${samples_dir}"/samples.*.tsv 2>/dev/null \
                                                | awk -v start="${startmonth}" '
                                                        match($0, /samples\.([0-9]{6})/, m) {
                                                                if (m[1] >= start) print $0
                                                        }
                                                '
                                        )
                                ;;
                        esac

                        # Abort if no matching files were found.
                        if (( ${#mode_files[@]} == 0 )); then
                                echo "ERROR: no matching samples files found in ${samples_dir}" >&2
                                exit 1
                        fi
                }

                # ---- Helper: build subtype lists for one target filename ------------
                # Example target names:
                #   samples.recent.tsv
                #   samples.tsv
                write_subtype_lists() {
                        local target_name="$1"
                        shift

                        local iva_subtype
                        local exclude_var
                        local subtype_exclude

                        for iva_subtype in "${influenza_subtypes_list[@]}"; do
                                exclude_var="exclude_samples_${iva_subtype,,}"          # e.g. IA_H1 -> exclude_samples_ia_h1
                                subtype_exclude="${!exclude_var:-}"                     # read subtype-specific exclusion list

                                build_filtered_samples_file \
                                        "${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/${target_name}" \
                                        "${subtype_exclude}" \
                                        "$@"
                        done
                }

                # ---- Helper: split a subtype list into Aviti vs pre-Aviti ----------
                # Uses the current batch-name length heuristic from the original code.
                split_aviti_lists() {
                        local subtype_list_file="$1"
                        local subtype_workdir="$2"

                        mv "${subtype_workdir}/samples_aviti.tsv" \
                           "${subtype_workdir}/samples_aviti.tsv.old" 2>/dev/null || true

                        : > "${subtype_workdir}/samples_aviti.tsv"                    # fresh Aviti list
                        : > "${subtype_workdir}/samples_pre-aviti.tsv"                # fresh pre-Aviti list

                        while IFS=$'\t' read -r col1 col2 col3 col4; do
                                if [ "${#col2}" -eq 19 ]; then
                                        echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> "${subtype_workdir}/samples_aviti.tsv"
                                else
                                        echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> "${subtype_workdir}/samples_pre-aviti.tsv"
                                fi
                        done < "${subtype_list_file}"
                }

                # ---- Mode-specific sample lists -------------------------------------
                case "$2" in
                        --recent)
                                copy_list_name="samples.recent.tsv"                    # subtype copy list for recent mode
                                echo "syncing recent: ${lastmonth}, ${thismonth}"      # show selected months

                                collect_mode_files recent                              # gather recent source files

                                # Build shared recent list.
                                build_filtered_samples_file \
                                        "${shared_workdir}/samples.recent.tsv" \
                                        "" \
                                        "${mode_files[@]}"

                                # Build subtype recent lists.
                                write_subtype_lists "samples.recent.tsv" "${mode_files[@]}"
                        ;;
                        --year)
                                copy_list_name="samples.recent.tsv"                    # subtype copy list for yearly mode
                                echo "syncing year: ${year}"                           # show selected year

                                collect_mode_files year                                # gather yearly source files

                                # Build shared yearly list.
                                build_filtered_samples_file \
                                        "${shared_workdir}/samples.recent.tsv" \
                                        "" \
                                        "${mode_files[@]}"

                                # Build subtype yearly lists.
                                write_subtype_lists "samples.recent.tsv" "${mode_files[@]}"
                        ;;
                        --all)
                                copy_list_name="samples.recent.tsv"                    # keep copy scope limited to startdate onward
                                echo "syncing all from ${influenza_startdate}"         # show selected start date

                                collect_mode_files all                                 # gather files from influenza_startdate onward

                                # Build the selected-range shared lists.
                                build_filtered_samples_file \
                                        "${shared_workdir}/samples.tsv" \
                                        "" \
                                        "${mode_files[@]}"

                                build_filtered_samples_file \
                                        "${shared_workdir}/samples.recent.tsv" \
                                        "" \
                                        "${mode_files[@]}"

                                # Build subtype selected-range lists.
                                write_subtype_lists "samples.recent.tsv" "${mode_files[@]}"
                        ;;
                        *)
                                echo "Unkown parameter ${2}" > /dev/stderr             # reject unsupported mode
                                exit 2
                        ;;
                esac

                # ---- Canonical full sample lists ------------------------------------
                # These are built from all available samples.*.tsv files, regardless of
                # mode, because other parts of the workflow often expect them.
                mapfile -t all_batch_files < <(
                        ls -1 "${samples_dir}"/samples.*.tsv 2>/dev/null
                )

                if (( ${#all_batch_files[@]} == 0 )); then
                        echo "ERROR: no samples.*.tsv files found in ${samples_dir}" >&2
                        exit 1
                fi

                # Build shared full samples.tsv.
                build_filtered_samples_file \
                        "${shared_workdir}/samples.tsv" \
                        "" \
                        "${all_batch_files[@]}"

                # Build subtype full samples.tsv files.
                write_subtype_lists "samples.tsv" "${all_batch_files[@]}"

                # ---- Prepare subtype output trees -----------------------------------
                for iva_subtype in "${influenza_subtypes_list[@]}"; do
                        subtype_workdir="${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}"   # subtype working directory
                        subtype_output_dir="${clusterdir_old}/${clusterdir}/${iva_subtype}/vpipe_output"   # subtype output root
                        subtype_copy_list="${subtype_workdir}/${copy_list_name}"       # subtype-specific list controlling copy scope

                        mkdir -p --mode=2770 "${subtype_output_dir}"                   # ensure subtype output root exists

                        # Copy/link only the sample directories that survived filtering
                        # for this subtype and for the selected mode.
                        cut -f1 "${subtype_copy_list}" \
                                | xargs -r -P 8 -I {} cp -vrf --link "${samples_dir}/{}" "${subtype_output_dir}/"

                        # Split the subtype list used for copying into Aviti vs pre-Aviti.
                        split_aviti_lists "${subtype_copy_list}" "${subtype_workdir}"
                done
        ;;
        vpipe)
                declare -A job
                list=('seq' 'seqqa' 'snv' 'snvqa' 'hugemem' 'hugememqa')
                shorah=1
                hold=
                tag=
                aviti=0
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
#                                        # TODO switch between full cohort and only recent
#                                         #recent="..."
                                ;;
                                --aviti)
                                        aviti=1
                                        shorah=0
                                ;;
                        esac
                        shift
                done
                # start first job
                cd ${clusterdir_old}/${clusterdir}/${working}/
                if (( aviti )); then
                        echo "Processing Aviti"
			job['seq']="$(sed "s/@TAG@/<${tag}>/g" ${clusterdir_old}/${clusterdir}/${working_vpipe}/vpipe_influenza_aviti_main.sbatch | sbatch --parsable ${hold} --job-name="iva_main_AVITI-vpipe-<${tag}>-cons")"
                else
			job['seq']="$(sed "s/@TAG@/<${tag}>/g" ${clusterdir_old}/${clusterdir}/${working_vpipe}/vpipe_influenza_main.sbatch | sbatch --parsable ${hold} --job-name="iva_main-vpipe-<${tag}>-cons")"
                fi
                if [[ -n "${job['seq']}" ]]; then
                        # schedule a gatherqa in each subvariant no mater what happens
                        influenza_subtypes_list=(IA_H1 IA_H3 IA_N1 IA_N2)
                        
                        for iva_subtype in "${influenza_subtypes_list[@]}"; do
                                cd "${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/"
                                job['seqqa']="$(sbatch --parsable  ${hold} --job-name="iva-qa-<${tag}>" --dependency="afterany:${job['seq']}" ${clusterdir_old}/${clusterdir}/${working_vpipe}/qa-launcher)"
                        done
                        
                        cd ${clusterdir_old}/${clusterdir}/${working}/
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
                find ${clusterdir_old}/${clusterdir}/${working}/cluster_logs/ -type f -mtime +28 -name '*.log' -print0 | xargs -0 rm --
        ;;
        #depreciated function - remove in future
        #scratch)
        #        temp_scratch="${SCRATCH}/pangolin/temp"
        #        olderthan=60
        #        purge=0
        #        loop=0
        #        filter=
        #        while [[ -n $2 ]]; do
        #                case "$2" in
        #                        --minutes-ago)
        #                                if [[ ! "${3}" =~ ^[[:digit:]]+$ ]]; then
        #                                        echo "parameter of ${2} must be a number of minutes (digits only), got <${3}> instead" > /dev/stderr
        #                                        exit 2
        #                                fi
        #                                shift
        #                                olderthan=$2
        #                        ;;
        #                        --loop)
        #                                loop=1
        #                        ;&
        #                        --purge)
        #                                purge=1
        #                        ;;
        #                        *)
        #                                echo "Unkown parameter ${2}" > /dev/stderr
        #                                exit 2
        #                        ;;
        #                esac
        #                shift
        #        done
#
        #        if (( purge )); then
        #                echo "purging in ${temp_scratch}..."
        #        else
        #                echo "listing in ${temp_scratch}..."
        #        fi
#
        #        count_all=0
        #        count_old=0
        #        while read s; do
        #                (( ++count_all ))
        #                if [[ -r "${clusterdir_old}/${clusterdir}/${working}/samples/${s}/upload_prepared.touch" &&  $(find "${clusterdir_old}/${clusterdir}/${working}/samples/${s}/upload_prepared.touch" '!' -newermt "${olderthan} minutes ago") ]]; then
        #                        (( ++count_old ))
        #                        if (( purge )); then
        #                                rm -rvf  "${temp_scratch}/samples/${s}"
        #                        else
        #                                echo "${s}";
        #                        fi
        #                fi;
        #        done < <((cd "${temp_scratch}/" && find samples/ -type f ${filter} ) | grep -oP '(?<=samples/)[^/]+/[^/]+(?=/)' | sort -u) | tee /dev/stderr | wc -l  2>&1
        #        echo "Samples: ${count_old} old / ${count_all} total"
#
        #        if (( loop )); then
        #                echo -e '\n\e[38;5;45;1mYou just keep on trying\e[0m\n\e[38;5;208;1mTill you run out of cake\e[0m'
        #                if sleep "$(( 5 + olderthan))m"; then
        #                        # loop if no breaks
        #                        exec "${0}" scratch --minutes-ago "${olderthan}" --loop
        #                fi
        #                echo "I'm not even angry"
        #        fi
        #;;
        completion)
                if [[ $2 =~ ^([[:digit:]]+)$ ]]; then
                        gawk '$0~/^\[.*\]$/{date=$0};$0~/^[[:digit:]]+ of [[:digit:]]+ steps \([[:digit:].]+%\) done$/{print $0 "\t" date}' "${clusterdir_old}/${clusterdir}/${working}/slurm-${2}.out"
                fi
        ;;
        df)
                #df ${clusterdir_old}/${clusterdir} ${SCRATCH}
                lquota -2 ${clusterdir_old}/${clusterdir}
                lquota -2 ${SCRATCH}
        ;;
	sortsamples)
		cd ${clusterdir_old}/${clusterdir}/
                sortsamples_statusdir=${status}/sortsamples
		mkdir -p $sortsamples_statusdir
		summary=""
		recent=""
		shrtrecent=""
		force="${sort_force}"
		while [[ -n $2 ]]; do
			case "$2" in
				--summary)
					summary='--summary'
				;;
				--force)
					force='--force'
				;;
				--recent)
					recent="--recent=${lastmonth}"
					shrtrecent="-r ${lastmonth}"
				;;
                                --year)
                                        recent="--recent=${year}"
                                        shrtrecent="-r ${year}"
                                ;;
				--all)
                                        recent="--recent=${influenza_startdate}"
                                        shrtrecent="-r ${influenza_startdate}"
                                ;;
                                --custom)
                                        customdate="20250501"
                                        recent="--recent=${customdate}"
                                        shrtrecent="-r ${customdate}"
                                ;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
			shift
		done
		fail=0
		if  (( ${lab[fgcz]} == 1 )); then
                        echo "Start sortsamples $recent"
			. <(grep '^google_sheet_patches=' ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf)
 
			(( google_sheet_patches )) && ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/google_sheet_patches.py
 			#${clusterdir}/sort_samples_bfabric_tsv.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${clusterdir}/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
          		${clusterdir_old}/${clusterdir}/${sourcefiles_location}/sort_samples_bfabric_tsv_aviti.py -c ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${clusterdir}/${working_vpipe}/${protocolyaml}  --libkit-override=${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/movedatafiles.sh || fail=1

		else
			echo "Skipping  fgcz / skipping batman.sh sortsamples as per configuration."
		fi
		(( fail == 0 )) &&  touch ${sortsamples_statusdir}/sortsamples_success || touch ${sortsamples_statusdir}/sortsamples_fail
	;;
        scanmissingsamples)
                sample_list=$2
                # load exclusion lists from fgcz.conf if present
                . <(
                        grep -E '^(exclude_samples|exclude_samples_ia_h1|exclude_samples_ia_h3|exclude_samples_ia_mp|exclude_samples_ia_n1|exclude_samples_ia_n2)=' \
                        "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf" \
                        || true
                )
                # convert comma-separated exclusion variables into bash arrays
                IFS=',' read -r -a excluded_samples <<< "${exclude_samples:-}"
                IFS=',' read -r -a excluded_samples_ia_h1 <<< "${exclude_samples_ia_h1:-}"
                IFS=',' read -r -a excluded_samples_ia_h3 <<< "${exclude_samples_ia_h3:-}"
                IFS=',' read -r -a excluded_samples_ia_mp <<< "${exclude_samples_ia_mp:-}"
                IFS=',' read -r -a excluded_samples_ia_n1 <<< "${exclude_samples_ia_n1:-}"
                IFS=',' read -r -a excluded_samples_ia_n2 <<< "${exclude_samples_ia_n2:-}"
                # helper: check if a sample name exists inside a given list
                sample_in_list() {
                        local sample_name="$1"
                        shift
                        local item
                        for item in "$@"; do
                                item="${item#"${item%%[![:space:]]*}"}"
                                item="${item%"${item##*[![:space:]]}"}"
                                if [[ -n "$item" && "$sample_name" == "$item" ]]; then
                                        return 0
                                fi
                        done
                        return 1
                }
                # iterate over sample list file
                while IFS=$'\t' read -r sample batch other; do
                        [[ $sample =~ $rxsample ]] || continue

                        # global exclude
                        sample_in_list "$sample" "${excluded_samples[@]}" && continue

                        # initialize per-sample variables that may be disabled by subtype exclusion
                        # initialize per-sample subtype checks (1 = required, 0 = ignore)
                        check_h1=1
                        check_h3=1
                        check_mp=1
                        check_n1=1
                        check_n2=1

                        # disable subtype checks if sample is listed in subtype exclusion list
                        sample_in_list "$sample" "${excluded_samples_ia_h1[@]}" && check_h1=0
                        sample_in_list "$sample" "${excluded_samples_ia_h3[@]}" && check_h3=0
                        sample_in_list "$sample" "${excluded_samples_ia_mp[@]}" && check_mp=0
                        sample_in_list "$sample" "${excluded_samples_ia_n1[@]}" && check_n1=0
                        sample_in_list "$sample" "${excluded_samples_ia_n2[@]}" && check_n2=0
                        
                         # skip sample if all subtype checks are disabled/empty
                        if (( !check_h1 && !check_h3 && !check_mp && !check_n1 && !check_n2 )); then
                                continue
                        fi

                        echo -n "${sample}/${batch}" # print sample identifier

                        missing=0 # flag to track missing outputs

                        # check presence of subtype-specific V-pipe outputs
                        if (( check_h1 )) && [[ ! -e ${clusterdir_old}/${clusterdir}/IA_H1/vpipe_output/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
                                echo "${sample} missing in h1"
                                missing=1
                        fi
                        if (( check_h3 )) && [[ ! -e ${clusterdir_old}/${clusterdir}/IA_H3/vpipe_output/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
                                echo "${sample} missing in h3"
                                missing=1
                        fi
                        if (( check_mp )) && [[ ! -e ${clusterdir_old}/${clusterdir}/IA_MP/vpipe_output/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
                                echo "${sample} missing in mp"
                                missing=1
                        fi
                        if (( check_n1 )) && [[ ! -e ${clusterdir_old}/${clusterdir}/IA_N1/vpipe_output/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
                                echo "${sample} missing in n1"
                                missing=1
                        fi
                        if (( check_n2 )) && [[ ! -e ${clusterdir_old}/${clusterdir}/IA_N2/vpipe_output/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
                                echo "${sample} missing in n2"
                                missing=1
                        fi

                        # report result for this sample
                        if (( !missing )); then
                                echo ' -  .' # all required subtype outputs exist
                        else
                                echo -e "\r+${batch/_/:}\t!${sample}\e[K" # report missing sample
                                true
                                exit 0 # stop early if a missing sample is detected
                        fi
                done < "$sample_list"
                exit 1
        ;;
        listsampleset)
                case "$2" in
                        --recent)
                                ls -tr ${clusterdir_old}/${clusterdir}/${sampleset}/samples.20*.tsv | tail -n 12
                        ;;
                        --all)
                                ls ${clusterdir_old}/${clusterdir}/${sampleset}/samples.20*.tsv
                        ;;
                        *)
                                echo "Unkown parameter ${2}" > /dev/stderr
                                exit 2
                        ;;
                esac
        ;;
        list_batch_samples)
                validateBatchName "$2"
                cat ${clusterdir_old}/${clusterdir}/${sampleset}/samples.${2}.tsv
        ;;
        get_vpipe_commit)
                cd ${vpipe_code}
                branch=$(git status | head -n 1 | sed -e 's/# On branch //')
                commit=$(git log -n 1 ${branch} | head -n 1)
                echo "Branch: ${branch}\n${commit}"
        ;;
        get_viloca_commit)
                cd ${remote_viloca_basedir}/${viloca_processing}
                branch=$(git status | head -n 1 | sed -e 's/ On branch //')
                commit=$(git log -n 1 ${branch} | head -n 1)
                echo "Branch: ${branch}\n${commit}"
        ;;
        iva_vpipe_out_to_tsv)
                conda activate influenza_analysis_R
                #since rconfig can not be installed with the conda config.yaml file this is a workaround
                Rscript -e 'if(!requireNamespace("rconfig", quietly=TRUE)) install.packages("rconfig", repos="https://cran.r-project.org")'
                ### create status directory to record the status of the donwstream analysis
                cd ${downstream_analysis_dir}/
                downstream_analysis_statusdir=${status}/downstream_analysis #this will be on euler
                mkdir -p downstream_analysis_statusdir ### does it fail if it already exisist?

                ###  define the relevant folders per fragment and run the scrip per fragment
                fragments=(IA_H1 IA_H3 IA_N1 IA_N2) # excluded IA_MP 
                process_fail=0

                for fra in "${fragments[@]}"; do
                        echo "Processing fragment: $fra"

                        # Ensure status files exist
                        # Case 1: neither exists → create fail file newer than success file → downstream MUST run
                        if [[ ! -e "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_success" && ! -e "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_fail" ]]; then
                            echo "WARNING: Fragment downstream analysis status files don't exist. Will create them now"
                            touch "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_success"
                            sleep 1
                            touch "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_fail"   # fail newer → downstream forced
                        # Case 2: success missing but fail exists
                        elif [[ ! -e "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_success" ]]; then
                            echo "WARNING: Only Fragment_success file does not exist?"
                        # Case 3: fail missing but success exists
                        elif [[ ! -e "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_fail" ]]; then
                            echo "WARNING: Only Fragment_fail file does not exist?"
                        fi


                        # remove IA for the fragment to be used in the name of the config
                        subtype_seg="${fra#IA_}"
                        # 
                        vpipe_dir=${clusterdir_old}/${clusterdir}/$fra/${working}
                        location_dic=${ww_locations}
                        vpipe_config=${clusterdir_old}/${clusterdir}/${working_vpipe}/vpipe_influenza_${subtype_seg}_aviti.yaml

                        ### run the script per fragment and detect the error staus per frament
                        #the command which runs the analysis
                        command_std_err=$(${downstream_analysis_dir}/detect_AAMutations.R -d $vpipe_dir --vpipe_config $vpipe_config -l $location_dic 2>&1)
                        detect_command=$?
                        echo $command_std_err
                        #If the command fails (non-zero exit code), the fail variable is set to 1.
                        #command_output=$($detect_command | tee /dev/stderr) || fail=1  #The tee /dev/stderr ensures the output of your command is printed to standard error (for debugging)
                        # Check the result of the command and create the appropriate status file
                        if  [[ "$detect_command" == "0" ]] ; then
                                #echo "Command succeeded."
                                touch "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_success"

                        else
                                #echo "Command failed."
                                touch "${downstream_analysis_statusdir}/iva_downstream_analysis_${fra}_fail"
                                process_fail=$((process_fail + 1))
                        fi

                done
                # to track the whole process in one file:
                if [[ "$process_fail" == "0" ]]; then
                        #echo "Command succeeded."
                        touch "${downstream_analysis_statusdir}/iva_downstream_analysis_success"

                else
                        #echo "Command failed."
                        touch "${downstream_analysis_statusdir}/iva_downstream_analysis_fail"
                        
                fi

                conda deactivate

        ;;
        *)
                echo "Unkown sub-command ${1}" > /dev/stderr
                exit 2
        ;;
esac
