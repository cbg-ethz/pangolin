#!/bin/bash

scriptdir=/cluster/project/pangolin/test_automation/pangolin/pangolin_src
. ${scriptdir}/config/server.conf

status=${clusterdir_old}/status
vilocadir=${remote_viloca_basedir}/${viloca_processing}
uploaderdir=${remote_uploader_workdir}

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
                lst="${clusterdir_old}/${working}/samples.tsv"
                case "$2" in
                        --recent)
                                lst="${clusterdir_old}/${working}/samples.recent.tsv"
                                echo "syncing recent: ${lastmonth}, ${thismonth}"
                        ;;
                        *)
                                echo "Unkown parameter ${2}" > /dev/stderr
                                exit 2
                        ;;
                esac
                mkdir -p --mode=2770 "${clusterdir_old}/${working}/samples/"
                #cp -vrf --link ${clusterdir}/${sampleset}/*/ ${clusterdir}/${working}/samples/   ## failure: "no rule to create {SAMPLE}/extract/R1.fastq"
                cat ${clusterdir_old}/${sampleset}/samples.{${lastmonth},${thismonth}}*.tsv | sort -u > "${clusterdir_old}/${working}/samples.recent.tsv"
                sort -u ${clusterdir_old}/${sampleset}/samples.*.tsv > "${clusterdir_old}/${working}/samples.tsv"
                cut -f1 "${lst}" | xargs -P 8 -i cp -vrf --link "${clusterdir_old}/${sampleset}/{}/" "${clusterdir_old}/${working}/samples/"
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
#                                        # TODO switch between full cohort and only recent
#                                         #recent="..."
                                 ;;
                                *)
                                        echo "Unkown parameter ${2}" > /dev/stderr
                                        exit 2
                                ;;
                        esac
                        shift
                done
                # start first job
                cd ${clusterdir_old}/${working}/
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
		for v in "${list[@]}"; do
			printf "%s\t%s\n" "${v}" "${job[$v]}"
		done
                conda deactivate
	;;
	unlock_viloca)
		cd ${clusterdir_old}/${vilocadir}/
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
		bfabricdir=${clusterdir_old}/bfabric-downloads
		cd ${bfabricdir}
		sync_fgcz_statusdir=${status}/sync
		mkdir -p $sync_fgcz_statusdir
		fgcz_config=${clusterdir}/config/fgcz.conf

		echo "Sync FGCZ - bfabric"
		conda activate sync
		. <(grep '^projlist=' ${fgcz_config})
		if [[ "${2}" = "--recent" ]]; then
			limitlast='3 weeks ago'
			${clusterdir}/exclude_list_bfabric.py -c ${fgcz_config} -r "${twoweeksago}" -o ${sync_fgcz_statusdir}/fgcz.exclude.lst
			param=( '-e' "${sync_fgcz_statusdir}/fgcz.exclude.lst" "${projlist[@]}" )
			echo -ne "syncing recent: ${limitlast}\texcluding: "
			wc -l ${sync_fgcz_statusdir}/fgcz.exclude.lst
		else
			param=( "${projlist[@]}" )
		fi
                fail=0
		syncoutput="$(${clusterdir}/sync_sftp.sh -c ${fgcz_config} ${limitlast:+ -N "${limitlast}"} "${param[@]}"|tee /dev/stderr)" || fail=1
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
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
			shift
		done
		fail=0
		if  (( ${lab[gfb]} == 1 )); then
			${clusterdir}/sort_samples_pybis.py -c ${clusterdir}/config/gfb.conf --protocols=${clusterdir_old}/${working}/${protocolyaml} --assume-same-protocol ${force} ${summary} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
		else
			echo "Skipping gfb"
		fi
		if  (( ${lab[fgcz]} == 1 )); then
			. <(grep '^google_sheet_patches=' ${clusterdir}/config/fgcz.conf)
 
			(( google_sheet_patches )) && ${clusterdir}/google_sheet_patches.py
 			${clusterdir}/sort_samples_bfabric_tsv.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir_old}/${working}/${protocolyaml}  --libkit-override=${clusterdir_old}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
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
        queue_upload)
                echo "Creating on remote the list of new samples to upload"
        	    validateBatchName "$2"
                cd ${uploaderdir}
        	    # Add the new batch on top of the list. This ensures that the most recent batches are uploaded first, in case of retrospective uploads
                cat ${clusterdir_old}/${sampleset}/samples.${2}.tsv | awk '{print $1,$2}' | sed -e 's/ /\t/' | cat - ${uploaderdir}/${uploaderlist} > ${uploaderdir}/${uploaderlist}_temp.txt && \
        	    mv ${uploaderdir}/${uploaderlist}_temp.txt ${uploaderdir}/${uploaderlist}
        	    # Remove possible duplicates after updating the upload list
                cat -n ${uploaderdir}/${uploaderlist} | sort -uk2 | sort -n | cut -f2- > ${uploaderdir}/.working_${uploaderlist}
                mv ${uploaderdir}/.working_${uploaderlist} ${uploaderdir}/${uploaderlist}
        ;;
        upload)
                echo "uploading ${uploader_sample_number} samples from the list of samples to upload"
                conda activate sendcrypt
                cd ${uploaderdir}
                . ${clusterdir}/uploader/next_upload.sh -N ${uploader_sample_number} -a ${uploader_archive} -c ${scriptdir}/config/server.conf
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
                                grep v532 ${clusterdir_old}/${working}/samples.wastewateronly.tsv > ${remote_amplicon_coverage_tempdir}/samples.${3}.tsv
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
                        -o ${amplicon_coverage_outdir}} \
                        -f ${clusterdir_old}/${working}/samples || rmdir ${amplicon_coverage_outdir}
                else
                        echo "ERROR: the amplicon coverage output directory ${amplicon_coverage_outdir} already exists. SKIPPING"
                        exit 5
                fi
        ;;
        *)
                echo "Unkown sub-command ${1}" > /dev/stderr
                exit 2
        ;;
esac
