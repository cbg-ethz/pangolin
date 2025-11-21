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
                lst="${clusterdir_old}/${clusterdir}/${working}/samples.tsv"
                aviti=0
                case "$2" in
                        --recent)
                                lst="${clusterdir_old}/${clusterdir}/${working}/samples.recent.tsv"
                                echo "syncing recent: ${lastmonth}, ${thismonth}"
                                cat ${clusterdir_old}/${clusterdir}/${sampleset}/samples.{${lastmonth},${thismonth}}*.tsv | sort -u > "${clusterdir_old}/${clusterdir}/${working}/samples.recent.tsv"
                        ;;
                        --year)
                                lst="${clusterdir_old}/${clusterdir}/${working}/samples.recent.tsv"
                                echo "syncing year: ${year}"
                                cat ${clusterdir_old}/${clusterdir}/${sampleset}/samples.${year}*.tsv | sort -u > "${clusterdir_old}/${clusterdir}/${working}/samples.recent.tsv"
                        ;;
			--all)
                                lst="${clusterdir_old}/${clusterdir}/${working}/samples.tsv"
                                echo "syncing all from $influenza_startdate"
                                cat ${clusterdir_old}/${clusterdir}/${sampleset}/samples.*.tsv | sort -u > "${clusterdir_old}/${clusterdir}/${working}/samples.recent.tsv"
                                cat ${clusterdir_old}/${clusterdir}/${sampleset}/samples.*.tsv | sort -u > "${clusterdir_old}/${clusterdir}/${working}/samples.tsv"
                        ;;
                        *)
                                echo "Unkown parameter ${2}" > /dev/stderr
                                exit 2
                        ;;

                esac
                
                #cp -vrf --link ${clusterdir}/${sampleset}/*/ ${clusterdir}/${working}/samples/   ## failure: "no rule to create {SAMPLE}/extract/R1.fastq"
                sort -u ${clusterdir_old}/${clusterdir}/${sampleset}/samples.*.tsv > "${clusterdir_old}/${clusterdir}/${working}/samples.tsv"
                ################ LOOP ################
                influenza_subtypes_list=(IA_H1 IA_H3 IA_MP IA_N1 IA_N2)
                #create a copy of the sample.tsv file in each subdirectroy --> in the future these could be adapted if needed
                for iva_subtype in "${influenza_subtypes_list[@]}"; do
                        cp ${clusterdir_old}/${clusterdir}/${working}/samples.tsv ${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/samples.tsv
                done

                for iva_subtype in "${influenza_subtypes_list[@]}"; do
                        mkdir -p --mode=2770 "${clusterdir_old}/${clusterdir}/${iva_subtype}/vpipe_output/"
		        
                        # copy/link vpipe_input samples to vpipe_output directory to create the output directory
		        cut -f1 "${lst}" | xargs -P 8 -i cp -vrf --link "${clusterdir_old}/${clusterdir}/${sampleset}/{}/" "${clusterdir_old}/${clusterdir}/${iva_subtype}/vpipe_output/"
                        # Add abstractions and generalized to allow for new sequencing methods
		        mv ${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/samples_aviti.tsv ${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/samples_aviti.tsv.old
                        touch ${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/samples_aviti.tsv
                        # copy enties from samples.tsv to samples_aviti.tsv
                        # TODO: outdated form to recognize the aviti based on string lenght --> to be corrected in the future!
                        while IFS=$'\t' read -r col1 col2 col3 col4; do
                                if [ "${#col2}" -eq 19 ]; then 
                                        echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> ${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/samples_aviti.tsv
                                else
                                        echo -e "${col1}\t${col2}\t${col3}\t${col4}" >> ${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/samples_pre-aviti.tsv
                                fi
                        done < ${clusterdir_old}/${clusterdir}/${iva_subtype}/${working}/samples.tsv
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
                if (( aviti )); then
                        echo "Processing Aviti"
                        cd ${clusterdir_old}/${clusterdir}/working/
			job['seq']="$(sed "s/@TAG@/<${tag}>/g" vpipe_influenza_aviti_main.sbatch | sbatch --parsable ${hold} --job-name="FLU-AVITI-vpipe-<${tag}>-cons")"
                else
                        cd ${clusterdir_old}/${clusterdir}/working/
			job['seq']="$(sed "s/@TAG@/<${tag}>/g" vpipe_influenza_main.sbatch | sbatch --parsable ${hold} --job-name="FLU-ILLUMINA-vpipe-<${tag}>-cons")"
                fi
                if [[ -n "${job['seq']}" ]]; then
                        # schedule a gatherqa no mater what happens
                        job['seqqa']="$(sbatch --parsable  ${hold} --job-name="COVID-qa-<${tag}>" --dependency="afterany:${job['seq']}" qa-launcher)"
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
                        if [[ -r "${clusterdir_old}/${clusterdir}/${working}/samples/${s}/upload_prepared.touch" &&  $(find "${clusterdir_old}/${clusterdir}/${working}/samples/${s}/upload_prepared.touch" '!' -newermt "${olderthan} minutes ago") ]]; then
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
                        gawk '$0~/^\[.*\]$/{date=$0};$0~/^[[:digit:]]+ of [[:digit:]]+ steps \([[:digit:].]+%\) done$/{print $0 "\t" date}' "${clusterdir_old}/${clusterdir}/${working}/slurm-${2}.out"
                fi
        ;;
        df)
                #df ${clusterdir_old}/${clusterdir} ${SCRATCH}
                lquota -2 ${clusterdir_old}/${clusterdir}
                lquota -2 ${SCRATCH}
        ;;
        garbage)
                validateBatchName "$2"
                cd ${clusterdir_old}/${clusterdir}

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
                cat ${clusterdir_old}/${clusterdir}/${sampleset}/samples.${2}.tsv | awk '{print $1,$2}' | tr " " "," | sed 's/^/,/' >> ${remote_viloca_basedir}/${viloca_staging}
        ;;
        finalize_staging_viloca)
                mv ${remote_viloca_basedir}/${viloca_staging} ${remote_viloca_basedir}/${viloca_samples}
        ;;
        scanmissingsamples_viloca)
                validateBatchName "$2"
                for i in $(cat ${clusterdir_old}/${clusterdir}/${sampleset}/samples.${2}.tsv | awk '{print $1}')
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
		bfabricdir=${clusterdir_old}/${clusterdir}/bfabric-downloads
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
                                        recent="--recent=${influenza_startdate}"
                                        shrtrecent="-r ${influenza_startdate}"
                                ;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
			shift
		done
		fail=0
		if  (( ${lab[gfb]} == 1 )); then
			${clusterdir}/sort_samples_pybis.py -c ${clusterdir}/config/gfb.conf --protocols=${clusterdir_old}/${clusterdir}/${working}/${protocolyaml} --assume-same-protocol ${force} ${summary} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
		else
			echo "Skipping gfb"
		fi
		if  (( ${lab[fgcz]} == 1 )); then
			. <(grep '^google_sheet_patches=' ${clusterdir}/config/fgcz.conf)
 
			(( google_sheet_patches )) && ${clusterdir}/google_sheet_patches.py
 			#${clusterdir}/sort_samples_bfabric_tsv.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${clusterdir}/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
          		${clusterdir}/sort_samples_bfabric_tsv_aviti.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${clusterdir}/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1

		else
			echo "Skipping fgcz"
		fi
		if  (( ${lab[h2030]} == 1 )) && [[ -e ${clusterdir}/synch2030_ended && -e ${clusterdir}/synch2030_started && ${clusterdir}/synch2030_ended -nt ${clusterdir}/synch2030_started ]]; then
			# NOTE always recent/based on last sync), no support for --force, move done immediately/no separate movedatafiles.sh
			# TODO support for protocols
			${clusterdir}/sort_h2030 -c ${clusterdir}/config/h2030.conf $(< ${clusterdir}/synch2030_started ) || fail=1
		else
			echo "Skipping h2030"
		fi
		if  (( ${lab[viollier]} == 1 )); then
			# NOTE always --force, short options only
			# HACK hardcoded paths due to multiple directories
			${clusterdir}/sort_viollier -c ${clusterdir}/config/viollier.conf -4 ${clusterdir}/${working}/${protocolyaml} ${shrtrecent} sftp-viollier/raw_sequences/*/ && bash ${clusterdir}/$movedatafiles.sh || fail=1
		else
			echo "Skipping viollier"
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
                        #ls ${clusterdir_old}/${clusterdir}/${working}/samples/${sample}/${batch}
                        if [[ -e ${clusterdir_old}/${clusterdir}/IA_H1/${working}/results/${sample}/${batch}/variants/SNVs/snvs.vcf && -e ${clusterdir_old}/${clusterdir}/IA_H3/${working}/results/${sample}/${batch}/variants/SNVs/snvs.vcf && -e ${clusterdir_old}/${clusterdir}/IA_MP/${working}/results/${sample}/${batch}/variants/SNVs/snvs.vcf && -e ${clusterdir_old}/${clusterdir}/IA_N1/${working}/results/${sample}/${batch}/variants/SNVs/snvs.vcf && -e ${clusterdir_old}/${clusterdir}/IA_N2/${working}/results/${sample}/${batch}/variants/SNVs/snvs.vcf ]]; then
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
        amplicon_coverage)
                case "$2" in
                        --batch)
                                validateBatchName "$3"
                                echo "Running amplicon coverage on batch $3"
                                amplicon_coverage_sample_list=${clusterdir_old}/${clusterdir}/${sampleset}/samples.${3}.tsv
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
                                alldates=$(cat ${clusterdir_old}/${clusterdir}/${working}/samples.tsv | awk '{print $2}' |  awk -F'_' '{print $1}' | awk -v var=$enddate 'NR==1 { print } NR != 1 && $1 <= var { print }' | awk -v var=$startdate 'NR==1 { print } NR != 1 && $1 >= var { print }' | sort | uniq)
                                for i in $alldates; do
                                        grep ${i} ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv >> ${amplicon_coverage_sample_list}
                                done
                                amplicon_coverage_outdir=${remote_amplicon_coverage_workdir}/manual_${3}
                        ;;
                        --libkit)
                                echo "Running amplicon coverage for any sample with library kit $3"
                                grep ${3} ${clusterdir_old}/${clusterdir}/${working}/samples.wastewateronly.tsv > ${remote_amplicon_coverage_tempdir}/samples.${3}.tsv
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
                        -f ${clusterdir_old}/${clusterdir}/${working}/samples || rmdir ${amplicon_coverage_outdir}
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
        vpipe_out_to_tsv)
                conda activate influenza_analysis_R

                ### create status directory to record the status of the donwstream analysis
                cd ${downstream_analysis_dir}/
                downstream_analysis_statusdir=${status}/downstream_analysis #this will be on euler
                mkdir -p downstream_analysis_statusdir ### does it fail if it already exisist?

                ###  define the relevant folders per fragment and run the scrip per fragment
                fragments=(IA_H1 IA_H3 IA_N1 IA_N2) # excluded IA_MP 
                process_fail=0

                for fra in "${fragments[@]}"; do
                        echo "Processing fragment: $fra"
                        # 
                        vpipe_dir=${clusterdir_old}/${clusterdir}/$fra/${working} #can this be generalized better?
                        location_dic=${ww_locations}

                        ### run the script per fragment and detect the error staus per frament
                        #the command which runs the analysis
                        command_std_err=$(${downstream_analysis_dir}/detect_AAMutations.R -d $vpipe_dir -l $location_dic | tee /dev/stderr)
                        detect_command=$?
                       
                        #If the command fails (non-zero exit code), the fail variable is set to 1.
                        #command_output=$($detect_command | tee /dev/stderr) || fail=1  #The tee /dev/stderr ensures the output of your command is printed to standard error (for debugging)
                        # Check the result of the command and create the appropriate status file
                        if  [[ "$detect_command" == "0" ]] ; then
                                #echo "Command succeeded."
                                touch "${downstream_analysis_statusdir}/detect_AAMutations_${fra}_success"

                        else
                                #echo "Command failed."
                                touch "${downstream_analysis_statusdir}/detect_AAMutations_${fra}_fail"
                                process_fail=$((process_fail + 1))
                        fi

                done
                # to track the whole process in one file:
                if [[ "$process_fail" == "0" ]]; then
                        #echo "Command succeeded."
                        touch "${downstream_analysis_statusdir}/detect_AAMutations_success"

                else
                        #echo "Command failed."
                        touch "${downstream_analysis_statusdir}/detect_AAMutations_fail"
                        
                fi

                conda deactivate

        ;;
        *)
                echo "Unkown sub-command ${1}" > /dev/stderr
                exit 2
        ;;
esac
