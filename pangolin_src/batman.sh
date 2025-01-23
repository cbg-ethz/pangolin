#!/bin/bash

scriptdir=/cluster/project/pangolin/rsv_pipeline/pangolin/pangolin_src
. ${scriptdir}/config/server.conf

status=${clusterdir_old}/status
vilocadir=${remote_viloca_basedir}/${viloca_processing}


eval "$(/cluster/project/pangolin/test_automation/miniconda3/bin/conda shell.bash hook)"

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
		echo "Separating RSV A and B in their respective directories"
                lst="${clusterdir_old}/${working}/samples.tsv"
                aviti=0
                case "$2" in
                        --recent)
                                lst="${clusterdir_old}/${working}/samples.recent.tsv"
                                echo "syncing recent: ${lastmonth}, ${thismonth}"
                                cat ${clusterdir_old}/${sampleset}/samples.{${lastmonth},${thismonth}}*.tsv | sort -u > "${clusterdir_old}/${working}/samples.recent.tsv"
                        ;;
                        --year)
                                lst="${clusterdir_old}/${working}/samples.recent.tsv"
                                echo "syncing year: ${year}"
                                cat ${clusterdir_old}/${sampleset}/samples.${year}*.tsv | sort -u > "${clusterdir_old}/${working}/samples.recent.tsv"
			;;
			--all)
				lst="${clusterdir_old}/${working}/samples.tsv"
				echo "syncing all from $rsv_startdate"
				cat ${clusterdir_old}/${sampleset}/samples.*.tsv | sort -u > "${clusterdir_old}/${working}/samples.recent.tsv"
				cat ${clusterdir_old}/${sampleset}/samples.*.tsv | sort -u > "${clusterdir_old}/${working}/samples.tsv"
                        ;;
                        *)
                                echo "Unkown parameter ${2}" > /dev/stderr
                                exit 2
                        ;;

                esac
                mkdir -p --mode=2770 "${clusterdir_old}/${working}/samples/"
                #cp -vrf --link ${clusterdir}/${sampleset}/*/ ${clusterdir}/${working}/samples/   ## failure: "no rule to create {SAMPLE}/extract/R1.fastq"
                sort -u ${clusterdir_old}/${sampleset}/samples.*.tsv > "${clusterdir_old}/${working}/samples.tsv"
		#RSVA
		awk -F'\t' -v match_strings="$rsva_match" '$4 ~ match_strings' ${clusterdir_old}/${working}/samples.tsv > ${clusterdir_old}/RSVA/${working}/samples.tsv
		cut -f1 "${lst}" | xargs -P 8 -i cp -vrf --link "${clusterdir_old}/${sampleset}/{}/" "${clusterdir_old}/RSVA/${working}/samples/"
                lst_rsva="${clusterdir_old}/RSVA/${working}/samples.tsv"
                # Add abstractions and generalized to allow for new sequencing methods
                mv ${clusterdir_old}/RSVA/${working}/samples_aviti.tsv ${clusterdir_old}/RSVA/${working}/samples_aviti.tsv.old
                touch ${clusterdir_old}/RSVA/${working}/samples_aviti.tsv 
                #mv ${clusterdir_old}/RSVA/${working}/samples.tsv ${clusterdir_old}/RSVA/${working}/samples.tsv_old
                while IFS=$'\t' read -r col1 col2 col3 col4; do
                        if [ "${#col2}" -eq 19 ]; then 
                                echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> ${clusterdir_old}/RSVA/${working}/samples_aviti.tsv
                        else
                                echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> ${clusterdir_old}/RSVA/${working}/samples_pre-aviti.tsv
                        fi
                done < ${clusterdir_old}/RSVA/${working}/samples.tsv
		#RSVB
		awk -F'\t' -v match_strings="$rsvb_match" '$4 ~ match_strings' ${clusterdir_old}/${working}/samples.tsv > ${clusterdir_old}/RSVB/${working}/samples.tsv
                cut -f1 "${lst}" | xargs -P 8 -i cp -vrf --link "${clusterdir_old}/${sampleset}/{}/" "${clusterdir_old}/RSVB/${working}/samples/"
                lst_rsvb="${clusterdir_old}/RSVB/${working}/samples.tsv"
                # Add abstractions and generalized to allow for new sequencing methods
                mv ${clusterdir_old}/RSVB/${working}/samples_aviti.tsv ${clusterdir_old}/RSVB/${working}/samples_aviti.tsv.old
                touch ${clusterdir_old}/RSVB/${working}/samples_aviti.tsv 
                #mv ${clusterdir_old}/RSVB/${working}/samples.tsv ${clusterdir_old}/RSVB/${working}/samples.tsv_old
                while IFS=$'\t' read -r col1 col2 col3 col4; do
                        if [ "${#col2}" -eq 19 ]; then 
                                echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> ${clusterdir_old}/RSVB/${working}/samples_aviti.tsv
                        else
                                echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> ${clusterdir_old}/RSVB/${working}/samples_pre-aviti.tsv
                        fi
                done < ${clusterdir_old}/RSVB/${working}/samples.tsv
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
                cd ${clusterdir_old}/${working}/
                if (( aviti )); then
                        echo "Processing Aviti"
			job['seq']="$(sed "s/@TAG@/<${tag}>/g" vpipe_rsv_aviti_main.sbatch | sbatch --parsable ${hold} --job-name="COVID-AVITI-vpipe-<${tag}>-cons")"
                else
                        job['seq']="$(sed "s/@TAG@/<${tag}>/g" vpipe_rsv_main.sbatch | sbatch --parsable ${hold} --job-name="COVID-vpipe-<${tag}>-cons")"
                fi
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
                                        [[ -n "${job['hugemem']}" ]]    && \
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
                find ${clusterdir_old}/${working}/cluster_logs/ -type f -mtime +28 -name '*.log' -print0 | xargs -0 rm --
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
                        if [[ -r "${clusterdir_old}/${working}/samples/${s}/upload_prepared.touch" &&  $(find "${clusterdir_old}/${working}/samples/${s}/upload_prepared.touch" '!' -newermt "${olderthan} minutes ago") ]]; then
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
                        gawk '$0~/^\[.*\]$/{date=$0};$0~/^[[:digit:]]+ of [[:digit:]]+ steps \([[:digit:].]+%\) done$/{print $0 "\t" date}' "${clusterdir_old}/${working}/slurm-${2}.out"
                fi
        ;;
        df)
                #df ${clusterdir_old} ${SCRATCH}
                lquota -2 ${clusterdir_old}
                lquota -2 ${SCRATCH}
        ;;
        garbage)
                validateBatchName "$2"
                cd ${clusterdir_old}

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
		cd ${vilocadir}/
                conda activate 'viloca'
		. run_workflow.sh
		# write job chain list
		#for v in "${list[@]}"; do
		#	printf "%s\t%s\n" "${v}" "${job[$v]}"
		#done
                conda deactivate
	;;
        check_viloca)
                cd ${vilocadir}/
                grep -rq snake.err -e "JOB.*CANCELLED.*DUE TO TIME LIMIT"
        ;;
	unlock_viloca)
		cd ${vilocadir}/
		conda activate 'viloca'
		snakemake --unlock
                conda deactivate
	;;
	archive_viloca_run)
		validateBatchName $2
		cd ${remote_viloca_basedir}
		if [ ! -d results_archive ]; then
			mkdir results_archive
		fi
		mkdir "results_archive/${2}"
		mv "${vilocadir}/results/*" "results_archive/${2}"
	;;
        create_sample_list_viloca)
                validateBatchName $2
                echo ",sample,batch" > ${remote_viloca_basedir}/${viloca_staging}
                cat ${clusterdir_old}/${sampleset}/samples.${2}.tsv | awk '{print $1,$2}' | tr " " "," | sed 's/^/,/' >> ${remote_viloca_basedir}/${viloca_staging}
        ;;
        finalize_staging_viloca)
                mv ${remote_viloca_basedir}/${viloca_staging} ${remote_viloca_basedir}/${viloca_samples}
        ;;
        scanmissingsamples_viloca)
                validateBatchName "$2"
                for i in $(cat ${clusterdir_old}/${sampleset}/samples.${2}.tsv | awk '{print $1}')
                do
                        if [ ! -d ${remote_viloca_basedir}/results_archive/${2}/${i} ]
                        then
                                echo ${i}
                        fi
                done
	;;
	sync_fgcz)
        	while [[ -n $2 ]]; do
			case "$2" in
				--https)
					type='https'
				;;
				--ftp)
					type='ftp'
				;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
			shift
		done
		bfabricdir=${clusterdir_old}/../bfabric-downloads
		cd ${bfabricdir}
		sync_fgcz_statusdir=${status}/sync
		mkdir -p $sync_fgcz_statusdir
		fgcz_config=${clusterdir}/config/fgcz.conf

		echo "Sync FGCZ - bfabric"

                echo "Syncing from node $(hostname)"
		conda activate sync
		. <(grep '^projlist=' ${fgcz_config})
		if [[ "${3}" = "--recent" ]]; then
			limitlast='3 weeks ago'
			${clusterdir}/exclude_list_bfabric.py -c ${fgcz_config} -r "${twoweeksago}" -o ${sync_fgcz_statusdir}/fgcz.exclude.lst
			param=( '-e' "${sync_fgcz_statusdir}/fgcz.exclude.lst" "${projlist[@]}" )
			echo -ne "syncing recent: ${limitlast}\texcluding: "
			wc -l ${sync_fgcz_statusdir}/fgcz.exclude.lst
		else
			param=( "${projlist[@]}" )
		fi
                fail=0
                if [[ "${type}" = "https" ]]; then
                        syncoutput="$(${clusterdir}/sync_sftp.sh -c ${fgcz_config} ${limitlast:+ -N "${limitlast}"} -H "${param[@]}"|tee /dev/stderr)" || fail=1
                else
		        syncoutput="$(${clusterdir}/sync_sftp.sh -c ${fgcz_config} ${limitlast:+ -N "${limitlast}"} "${param[@]}"|tee /dev/stderr)" || fail=1
                fi
		checksyncoutput "fgcz" "$syncoutput"
                (( fail == 0 )) &&  touch ${sync_fgcz_statusdir}/sync_fgcz_success || touch ${sync_fgcz_statusdir}/sync_fgcz_fail
		conda deactivate
	;;
	sortsamples)
		conda activate pybis
		cd ${clusterdir}
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
			. <(grep '^google_sheet_patches=' ${clusterdir}/config/fgcz.conf)
 
			(( google_sheet_patches )) && ${clusterdir}/google_sheet_patches.py
 			#${clusterdir}/sort_samples_bfabric_tsv.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
          		${clusterdir}/sort_samples_bfabric_tsv_aviti.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1

		else
			echo "Skipping fgcz"
		fi
		(( fail == 0 )) &&  touch ${sortsamples_statusdir}/sortsamples_success || touch ${sortsamples_statusdir}/sortsamples_fail
		conda deactivate
	;;
        scanmissingsamples)
                sample_list=$2
                while read sample batch other; do
                        # look for only guaranteed samples
                        [[ $sample =~ $rxsample ]] || continue
                        # check the presence of fasta on each sample
                        echo -n ${sample}/${batch}
                        #ls ${clusterdir_old}/${working}/samples/${sample}/${batch}
                        if [[ -e ${clusterdir_old}/${working}/samples/${sample}/${batch}/upload_prepared.touch ]]; then
                            # this will check for:
                            #  - references/ref_majority.fasta
                            #  - references/consensus.bcftools.fasta & .chain
                            #  - references/frameshift_deletions_check.tsv
                            #  etc.
                            #  see V-pipe's rule 'prepare_upload' in publish.smk
                            echo ' -  .'
                        else
                            echo -e "\r+${batch/_/:}\t!${sample}\e[K"
                            true
                            exit 0
                        fi
                done < $sample_list
                exit 1
        ;;
        listsampleset)
                case "$2" in
                        --recent)
                                ls -tr ${clusterdir_old}/${sampleset}/samples.20*.tsv | tail -n 12
                        ;;
                        --all)
                                ls ${clusterdir_old}/${sampleset}/samples.20*.tsv
                        ;;
                        *)
                                echo "Unkown parameter ${2}" > /dev/stderr
                                exit 2
                        ;;
                esac
        ;;
        list_batch_samples)
                validateBatchName "$2"
                cat ${clusterdir_old}/${sampleset}/samples.${2}.tsv
        ;;
        amplicon_coverage)
                case "$2" in
                        --batch)
                                validateBatchName "$3"
                                echo "Running amplicon coverage on batch $3"
                                amplicon_coverage_sample_list=${clusterdir_old}/${sampleset}/samples.${3}.tsv
                                amplicon_coverage_outdir=${remote_amplicon_coverage_workdir}/${3}
                        ;;
                        --timeframe)
                                echo "Running amplicon coverage for any sample within the timeframe $3"
                                startdate=${3%%-*}
                                enddate=${3##*-}
                                amplicon_coverage_sample_list=${remote_amplicon_coverage_tempdir}/samples.${3}.tsv
                                if [ -f ${amplicon_coverage_sample_list} ]; then
                                        rm "${amplicon_coverage_sample_list}"
                                fi
                                alldates=$(cat ${clusterdir_old}/${working}/samples.tsv | awk '{print $2}' |  awk -F'_' '{print $1}' | awk -v var=$enddate 'NR==1 { print } NR != 1 && $1 <= var { print }' | awk -v var=$startdate 'NR==1 { print } NR != 1 && $1 >= var { print }' | sort | uniq)
                                for i in $alldates; do
                                        grep ${i} ${clusterdir_old}/${working}/samples.wastewateronly.tsv >> ${amplicon_coverage_sample_list}
                                done
                                amplicon_coverage_outdir=${remote_amplicon_coverage_workdir}/manual_${3}
                        ;;
                        --libkit)
                                echo "Running amplicon coverage for any sample with library kit $3"
                                grep ${3} ${clusterdir_old}/${working}/samples.wastewateronly.tsv > ${remote_amplicon_coverage_tempdir}/samples.${3}.tsv
                                amplicon_coverage_sample_list=${remote_amplicon_coverage_tempdir}/samples.${3}.tsv
                                amplicon_coverage_outdir=${remote_amplicon_coverage_workdir}/manual_${3}
                        ;;
                esac
                conda activate amplicon_coverage
                cd ${remote_amplicon_coverage_workdir}
                if [ ! -d ${amplicon_coverage_outdir} ]; then
                        mkdir ${amplicon_coverage_outdir}
                        python ${remote_amplicon_coverage_code}/amplicon_covs.py \
                        -pv \
                        -s ${amplicon_coverage_sample_list} \
                        -r ${remote_primers_bed} \
                        -o ${amplicon_coverage_outdir} \
                        -f ${clusterdir_old}/${working}/samples || rmdir ${amplicon_coverage_outdir}
                else
                        echo "ERROR: the amplicon coverage output directory ${amplicon_coverage_outdir} already exists. SKIPPING"
                        exit 5
                fi
        ;;
        get_vpipe_commit)
                cd ${vpipe_code}
                branch=$(git status | head -n 1 | sed -e 's/# On branch //')
                commit=$(git log -n 1 ${branch} | head -n 1)
                echo "Branch: ${branch}\n${commit}"
        ;;
        get_viloca_commit)
                cd ${remote_viloca_basedir}/${viloca_processing}
                branch=$(git status | head -n 1 | sed -e 's/# On branch //')
                commit=$(git log -n 1 ${branch} | head -n 1)
                echo "Branch: ${branch}\n${commit}"
        ;;
        rsv_vpipe_out_to_tsv)
        conda activate test_downstream #rsv_downstream_analysis

        cd ${downstream_analysis_dir}/
        downstream_analysis_statusdir=${status}/downstream_analysis #this will be on euler
        mkdir -p downstream_analysis_statusdir 

        ### 3. define the relevant folders per fragment and run the scrip per fragment
        v_subtype=(RSVA RSVB)
        process_fail=0  
        for vir in "${v_subtype[@]}"; do
                echo "Processing Virus: $vir"

                vpipe_dir=${clusterdir_old}/$vir/${working} 
                ### Creating the input strings necessary for the downstream analysis
                path_to_vcf=${clusterdir_old}/$vir/${working}/samples/*/*/variants/SNVs/snvs.vcf   # input path example string: samples/sample_name*/batch*/variants/SNVs/snvs.vcf
                path_to_coverage=${clusterdir_old}/$vir/${working}/samples/*/*/alignments/coverage.tsv.gz   #/cluster/project/pangolin/rsv_pipeline/working/samples/*/*/alignments/coverage.tsv.gz
                path_to_samples_tsv=${clusterdir_old}/$vir/${working}/samples.tsv # Folder: RSV*/working/samples.tsv 
                path_to_output=${clusterdir_old}/$vir/${working}    # output from timeline.py will be input for downstream analysis --timeline_tsv
                path_to_config=${clusterdir_old}/$vir/${working}/${configfile}

                ### run the timeline.py each time when there are newsamples
                detect_command=$(${downstream_analysis_dir}/timeline.py --path_to_samples_tsv $path_to_samples_tsv --path_to_output $path_to_output | tee /dev/tty)
                

                #fail=0
                #If the command fails (non-zero exit code), the fail variable is set to 1.
                #command_output=$($detect_command | tee /dev/stderr) || fail=1  #The tee /dev/stderr ensures the output of your command is printed to standard error (for debugging)
                # Check the result of the command and create the appropriate status file
                if [[ "$detect_command" == "0" ]] ; then
                        #echo "Command succeeded."
                        touch "${downstream_analysis_statusdir}/timeline_tsv_${vir}_success"

                else
                        #echo "Command failed."
                        touch "${downstream_analysis_statusdir}/timeline_tsv_${vir}_fail"
                        continue 
                fi

                ### 4.
                path_to_timeline=${clusterdir_old}/$vir/${working}/timeline.tsv
                #the command which runs the analysis: the input of the command is a specific path with wildcard so it take all the files with the speicifc path strucutre
                detect_command=$(${downstream_analysis_dir}/rsv_downstream_analysis.py --vpipe_dir $vpipe_dir --path_to_vcf $path_to_vcf --timeline_tsv $path_to_timeline --path_to_coverage $path_to_coverage --config $path_to_config | tee /dev/stderr)

                #fail=0
                #If the command fails (non-zero exit code), the fail variable is set to 1.
                #command_output=$($detect_command | tee /dev/stderr) || fail=1  #The tee /dev/stderr ensures the output of your command is printed to standard error (for debugging)
                # Check the result of the command and create the appropriate status file
                if [[ "$detect_command" == "0" ]]; then
                        #echo "Command succeeded."
                        touch "${downstream_analysis_statusdir}/rsv_downstream_analysis_${vir}_success"

                else
                        #echo "Command failed."
                        touch "${downstream_analysis_statusdir}/rsv_downstream_analysis_${vir}_fail"
                        process_fail=$((process_fail + 1))
                fi

        done

        # to track the whole process in one file:
        if [[ "$process_fail" == "0" ]] ; then
                #echo "Command succeeded."
                touch "${downstream_analysis_statusdir}/rsv_downstream_analysis_success"            
        else
                #echo "Command failed."
                touch "${downstream_analysis_statusdir}/rsv_downstream_analysis_fail"
                
        fi             
        
        conda deactivate
        ;;
        *)
                echo "Unkown sub-command ${1}" > /dev/stderr
                exit 2
        ;;
esac
