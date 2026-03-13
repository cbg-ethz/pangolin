#!/bin/bash

scriptdir=/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src
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
                aviti=0                                                       # legacy flag kept for compatibility
        
                echo "Separating RSV A and B in their respective directories"  # log current action
        
                # ---- Exclusion settings ---------------------------------------------
                # Load global and subtype-specific sample exclusions from fgcz.conf.
                . <(
                        grep -E '^(exclude_samples|exclude_samples_rsva|exclude_samples_rsvb)=' \
                        "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf" \
                        || true
                )
        
                rsv_subtypes_list=(RSVA RSVB)                                  # RSV subtype directories to prepare
        
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
                                        # Use files from last and current month.
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
                                        # Use all files from rsv_startdate onward.
                                        local startmonth="${rsv_startdate:0:6}"        # YYYYMM
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
        
                        local rsv_subtype
                        local exclude_var
                        local subtype_exclude
        
                        for rsv_subtype in "${rsv_subtypes_list[@]}"; do
                                exclude_var="exclude_samples_${rsv_subtype,,}"         # e.g. RSVA -> exclude_samples_rsva
                                subtype_exclude="${!exclude_var:-}"                    # read subtype-specific exclusion list
        
                                build_filtered_samples_file \
                                        "${clusterdir_old}/${clusterdir}/${rsv_subtype}/${working}/${target_name}" \
                                        "${subtype_exclude}" \
                                        "$@"
                        done
                }
        
                # ---- Mode-specific sample lists -------------------------------------
                case "$2" in
                        --recent)
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
                                echo "syncing all from ${rsv_startdate}"               # show selected start date
        
                                collect_mode_files all                                 # gather files from rsv_startdate onward
        
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
                                echo "Unknown parameter ${2}" > /dev/stderr           # reject unsupported mode
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
			job['seq']="$(sed "s/@TAG@/<${tag}>/g" ${clusterdir_old}/${clusterdir}/${working_vpipe}/vpipe_rsv_aviti_main.sbatch | sbatch --parsable ${hold} --job-name="rsv_main_AVITI-vpipe-<${tag}>-cons")"
                else
                        job['seq']="$(sed "s/@TAG@/<${tag}>/g" ${clusterdir_old}/${clusterdir}/${working_vpipe}/vpipe_rsv_main.sbatch | sbatch --parsable ${hold} --job-name="rsv_main-vpipe-<${tag}>-cons")"
                fi
                if [[ -n "${job['seq']}" ]]; then
                        # schedule a gatherqa in each subvariant no mater what happens
                        cd ${clusterdir_old}/${clusterdir}/RSVA/${working}/
                        job['seqqa']="$(sbatch --parsable  ${hold} --job-name="rsv-qa-<${tag}>" --dependency="afterany:${job['seq']}" ${clusterdir_old}/${clusterdir}/${working_vpipe}/qa-launcher)"
                        cd ${clusterdir_old}/${clusterdir}/RSVB/${working}/
                        job['seqqa']="$(sbatch --parsable  ${hold} --job-name="rsv-qa-<${tag}>" --dependency="afterany:${job['seq']}" ${clusterdir_old}/${clusterdir}/${working_vpipe}/qa-launcher)"
                        cd ${clusterdir_old}/${clusterdir}/${working}/
                        # if no fail schedule a full job with snv
                        #depreciated - will be removes in future
                        #if (( shorah )); then
                        #        job['snv']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']}" --kill-on-invalid-dep=yes ${clusterdir_old}/${clusterdir}/${working_vpipe}/vpipe.sbatch)"
                        #        if [[ -n "${job['snv']}" ]]; then
                        #                # schedule a gatherqa no matter what happens to snv
                        #                job['snvqa']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']},afterany:${job['snv']}" --kill-on-invalid-dep=yes ${clusterdir_old}/${clusterdir}/${working_vpipe}/qa-launcher)"
                        #                # schedule a hugemem job if snvjob failed
                        #                job['hugemem']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']},afternotok:${job['snv']}" --kill-on-invalid-dep=yes ${clusterdir_old}/${clusterdir}/${working_vpipe}/vpipe-hugemem.sbatch)"
                        #                # schedule a qa afterward
                        #                [[ -n "${job['hugemem']}" ]]    && \
                        #                        job['hugememqa']="$(sbatch --parsable ${hold} --dependency="afterok:${job['seq']},afternotok:${job['snv']},afterany:${job['hugemem']}" --kill-on-invalid-dep=yes ${clusterdir_old}/${clusterdir}/${working_vpipe}/qa-launcher)"
                        #        fi
                        #fi      
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
        #                if [[ -r "${clusterdir_old}/${clusterdir}/vpipe_output/${s}/upload_prepared.touch" &&  $(find "${clusterdir_old}/${clusterdir}/vpipe_output/${s}/upload_prepared.touch" '!' -newermt "${olderthan} minutes ago") ]]; then
        #                        (( ++count_old ))
        #                        if (( purge )); then
        #                                rm -rvf  "${temp_scratch}/vpipe_output/samples/${s}"
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
		#conda activate pybis
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
					recent="--recent=${rsv_startdate}"
					shrtrecent="-r ${rsv_startdate}"
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
                        echo "Start sortsamples"
			. <(grep '^google_sheet_patches=' ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf)
 
			(( google_sheet_patches )) && ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/google_sheet_patches.py
 			#${clusterdir}/sort_samples_bfabric_tsv.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${clusterdir}/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
          		${clusterdir_old}/${clusterdir}/${sourcefiles_location}/sort_samples_bfabric_tsv_aviti.py -c ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${clusterdir}/${working_vpipe}/${protocolyaml}  --libkit-override=${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/movedatafiles.sh || fail=1
                        #${clusterdir_old}/${clusterdir_old}/${clusterdir}/${sourcefiles_location}/sort_samples_bfabric_tsv_aviti.py -c ${clusterdir_old}/${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${clusterdir_old}/${clusterdir}/pangolin/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir_old}/${clusterdir_old}/${clusterdir}/pangolin/movedatafiles.sh || fail=1
		else
			echo "Skipping  fgcz / skipping batman.sh sortsamples as per configuration."
		fi
		(( fail == 0 )) &&  touch ${sortsamples_statusdir}/sortsamples_success || touch ${sortsamples_statusdir}/sortsamples_fail
		#conda deactivate
	;;
        scanmissingsamples)
                sample_list=$2
                # load exclusion lists from fgcz.conf if present
                . <(
                        grep -E '^(exclude_samples|exclude_samples_rsva|exclude_samples_rsvb)=' \
                        "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf" \
                        || true
                )
                # convert comma-separated exclusion variables into bash arrays
                IFS=',' read -r -a excluded_samples <<< "${exclude_samples:-}"
                IFS=',' read -r -a excluded_samples_rsva <<< "${exclude_samples_rsva:-}"
                IFS=',' read -r -a excluded_samples_rsvb <<< "${exclude_samples_rsvb:-}"
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
                        check_rsva=1
                        check_rsvb=1

                        # disable subtype checks if sample is listed in subtype exclusion list
                        sample_in_list "$sample" "${excluded_samples_rsva[@]}" && check_rsva=0
                        sample_in_list "$sample" "${excluded_samples_rsvb[@]}" && check_rsvb=0

                        # skip sample if all subtype checks are disabled/ampty
                        if (( !check_rsva && !check_rsvb )); then
                                continue
                        fi

                        # print sample identifier
                        echo -n "${sample}/${batch}"

                        missing=0 # flag to track missing outputs

                        # check presence of subtype-specific V-pipe outputs
                        if (( check_rsva )) && [[ ! -e ${clusterdir_old}/${clusterdir}/RSVA/vpipe_output/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
                                echo "${sample} missing in RSVA"
                                missing=1
                        fi

                        if (( check_rsvb )) && [[ ! -e ${clusterdir_old}/${clusterdir}/RSVB/vpipe_output/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
                                echo "${sample} missing in RSVB"
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
                branch=$(git status | head -n 1 | sed -e 's/ On branch //')
                commit=$(git log -n 1 ${branch} | head -n 1)
                echo "Branch: ${branch}\n${commit}"
        ;;
        rsv_vpipe_out_to_tsv)
                conda activate rsv_downstream_analysis

                cd ${downstream_analysis_dir}/
                remote_downstream_analysis_statusdir=${status}/downstream_analysis #this will be on euler
                mkdir -p ${remote_downstream_analysis_statusdir} 

                ### 3. define the relevant folders per fragment and run the scrip per fragment
                v_subtype=(RSVA RSVB) 
                process_fail=0  
                for vir in "${v_subtype[@]}"; do
                        echo "Processing Virus: $vir"

                        vpipe_dir=${clusterdir_old}/${clusterdir}/$vir/${working} 
                        ### Creating the input strings necessary for the downstream analysis
                        path_to_vcf="${clusterdir_old}/${clusterdir}/$vir/vpipe_output/*/*/variants/SNVs/snvs.vcf"        # input path example string: samples/sample_name*/batch*/variants/SNVs/snvs.vcf
                        path_to_annotated_vcf="${clusterdir_old}/${clusterdir}/$vir/vpipe_output/*/*/variants/SNVs/snvs_annotated.vcf"
                        path_to_coverage="${clusterdir_old}/${clusterdir}/$vir/vpipe_output/*/*/alignments/coverage.tsv.gz"       #/cluster/project/pangolin/rsv_pipeline/working/samples/*/*/alignments/coverage.tsv.gz
                        path_to_samples_tsv="${clusterdir_old}/${clusterdir}/$vir/${working}/samples.recent.tsv"
                        path_to_output="${clusterdir_old}/${clusterdir}/$vir/${working}"        # output from timeline.py will be input for downstream analysis --timeline_tsv
                        path_to_config="${clusterdir_old}/${clusterdir}/${working_vpipe}/${configfile}"
        
	        	if [[ $vir == "RSVA" ]]; then
	        		reference="EPI_ISL_412866"
	        		virus_strings=${rsva_match}
                                fname_genbank_file=${rsva_genbank_file}
	        	else
	        		reference="EPI_ISL_1653999"
	        		virus_strings=${rsvb_match}
                                fname_genbank_file=${rsvb_genbank_file}
	        	fi

                        ### run the timeline.py each time when there are newsamples
                        detect_command=$(${rsv_git_repo_folder}/timeline.py --path_to_samples_tsv "$path_to_samples_tsv" --path_to_output "$path_to_output" 2>/dev/null)
                        exit_code=$?
	        	echo "Timeline creation. Exit code: $exit_code"

                        ####### Annotate the vcf files
                        ### run the annotate_vcf.py with the genbank reference (path defined in server.conf)
                        detect_command_ann=$(${rsv_git_repo_folder}/annotate_vcf.py --input_dir "$path_to_vcf" --fname_genbank_file "$fname_genbank_file" --chrom_name "$reference" 2>/dev/null)
                        exit_code_ann=$?
	        	echo "Annotated vcf files. Exit code: $exit_code_ann"

                        # Check the result of the command and create the appropriate status file
                        if [[ $exit_code -ne 0 ]] ; then
                                #echo "Command failed."
	        		echo "detect_command: $detect_command"
                                touch "${remote_downstream_analysis_statusdir}/timeline_tsv_${vir}_fail"
                                echo "Could not create timeline.tsv file, will skip downstream processing"
                                process_fail=$((process_fail + 1))
                                continue 
                        elif [[ $exit_code_ann -ne 0 ]] ; then
                                #echo "Command failed."
	                        echo "detect_command: $detect_command_ann"
                                touch "${remote_downstream_analysis_statusdir}/annotate_vcf_${vir}_fail"
                                echo "Could not annotate vcf files, will skip downstream processing"
                                process_fail=$((process_fail + 1))
                                continue 
                        else
                                echo "Successfully  annotated vcf files and created timeline.tsv. Proceeding with .tsv file creation."
                                touch "${remote_downstream_analysis_statusdir}/timeline_tsv_${vir}_success"
                                touch "${remote_downstream_analysis_statusdir}/annotate_vcf_${vir}_success"

                                ### 4. continue with downstream only if timeline is produced
                                path_to_timeline=$path_to_output/timeline.tsv
                                #the command which runs the analysis: the input of the command is a specific path with wildcard so it take all the files with the speicifc path strucutre
                                detect_command=$(${rsv_git_repo_folder}/make_mutation_tsv_annotated.py --vpipe_dir $vpipe_dir --path_to_vcf "$path_to_annotated_vcf" --timeline_tsv "$path_to_timeline" --path_to_coverage "$path_to_coverage" --reference $reference --config $path_to_config --virus_string "$virus_strings" 2>/dev/null)
	        		exit_code=$?
                                echo "Downstream analysis:"
	        		echo "Exit code: $exit_code"
        
                                # Check the result of the command and create the appropriate status file
                                if [[ $exit_code -eq 0 ]]; then
                                        echo "Downstream analysis succeeded. .tsv file has been created."
                                        touch "${remote_downstream_analysis_statusdir}/rsv_downstream_analysis_${vir}_success"
                                else
                                        echo "Downstream analysis for a variant failed."
                                        touch "${remote_downstream_analysis_statusdir}/rsv_downstream_analysis_${vir}_fail"
                                        process_fail=$((process_fail + 1))
                                fi
                        fi      
                done
                # to track the whole process in one file:
                if [[ "$process_fail" == "0" ]] ; then
                        echo "Downstream analysis succeeded."
                        touch "${remote_downstream_analysis_statusdir}/rsv_downstream_analysis_success"            
                else
                        echo "Downstream analysis failed."
	        	touch "${remote_downstream_analysis_statusdir}/rsv_downstream_analysis_fail"
                fi             
        ;;
        *)
                echo "Unkown sub-command ${1}" > /dev/stderr
                exit 2
        ;;
esac
