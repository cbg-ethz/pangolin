#!/usr/bin/env bash

scriptdir=/app/pangolin_src

if [[ $(uname) == Darwin ]]; then
    date=gdate
else
    date=date
fi
now=$($date '+%Y%m%d')
lastmonth=$($date '+%Y%m' --date='-1 month')
thismonth=$($date '+%Y%m')
twoweeksago=$($date '+%Y%m%d' --date='-2 weeks')
oneweekago=$($date '+%Y%m%d' --date='-1 weeks')


declare -A lab
. ${scriptdir}/config/server.conf

: ${basedir:=$(pwd)}
: ${download:?}
: ${sampleset:=sampleset}
: ${working:=working}
: ${storgrp:?}
: ${parallel:=16}
: ${parallelpull:=${parallel}}
: ${contimeout:=300}
: ${retries:=10}
: ${iotimeout:=300}
: ${protocolyaml:=/references/primers.yaml}
: ${viloca_basedir:?}
: ${viloca_samples:?}
: ${viloca_results:?}

if [[ $(realpath $scriptdir) != $(realpath $basedir) ]]; then
    echo "$scriptdir vs $basedir"
fi

if [[ ! $mode =~ ^[0-7]{,4}$ ]]; then
    echo "Invalid characters <${mode//[0-7]/}> in <${mode}>"
    echo 'mode should be an octal chmod value, see `mkdir --help` for informations'
    mode=
fi

set -e

# cd ${basedir}

umask 0002

mkdir ${mode:+--mode=${mode}} -p ${statusdir}
mkdir ${mode:+--mode=${mode}} -p ${viloca_statusdir}
mkdir ${mode:+--mode=${mode}} -p ${uploader_statusdir}

timeoutforeground=
#--foreground
#

#
# Input validator
#
validateBatchDate() {
    if [[ "$1" =~ ^(20[0-9][0-9][0-1][0-9][0-3][0-9])$ ]]; then
        return;
    else
        echo "bad batchdate ${1}"
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


#
# rsync parallel helpers
#
callpushrsync() {
        scriptdir=/app/pangolin_src
        . ${scriptdir}/config/server.conf

        local arglist=( )
        if (( ${#@} )); then
                arglist=( "${@/#/${basedir}/${sampleset}/}" )
        else
                #arglist=( "${basedir}/${sampleset}/" )
                echo "rsync job didn't receive list"
                exit 1;
        fi
        exec    timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync   --timeout=${iotimeout}  \
                --password-file ${rsync_pass}      \
                -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user}  -oConnectTimeout=${contimeout}"   \
                -izrltH --fuzzy --fuzzy --inplace       \
                -p --chmod=Dg+s,ug+rw,o-rwx,Fa-x        \
                -g --chown=:'bsse-covid19-pangolin-euler'       \
                "${arglist[@]}" \
                belfry@euler.ethz.ch::${sampleset}/
}
export -f callpushrsync


callpullrsync_fordb() {
        scriptdir=/app/pangolin_src
        . ${scriptdir}/config/server.conf

        local arglist=( )
        if (( ${#@} )); then
                arglist=( "${@/#/belfry@euler.ethz.ch::${working}/samples/}" )
        else
                #arglist=( "belfry@euler.ethz.ch::${working}/samples/" )
                echo "rsync job didn't receive list"
                exit 1;
        fi
        exec    timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync   --timeout=${iotimeout}  \
                --password-file ${rsync_pass}      \
                -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user}  -oConnectTimeout=${contimeout}"   \
                -izrltHLK --fuzzy --fuzzy --inplace       \
                --link-dest=${local_dataset}/${working}/samples    \
                --exclude='alignments/'    \
                --exclude='extracted_data/'    \
                --exclude='preprocessed_data/'    \
                --exclude='raw_data/'   \
                --exclude='raw_uploads/'    \
                --exclude='references/'    \
                --exclude='variants/'   \
                --exclude='visualization/'      \
                --exclude='*.out.log'   \
                --exclude='*.err.log'   \
                --exclude='*.benchmark' \
                --exclude='*fastq.gz' \
                "${arglist[@]}" \
                ${local_dataset}/${working}/samples/
}
export -f callpullrsync_fordb

callpullrsync_viloca() {
    scriptdir=/app/pangolin_src
	. ${scriptdir}/config/server.conf

	local arglist=( )
	if (( ${#@} )); then
		arglist=( "${@/#/belfry@euler.ethz.ch::${work_viloca}/${viloca_results}}" )
	else
		#arglist=( "belfry@euler.ethz.ch::${working}/samples/" )
		echo "rsync job didn't receive list"
		exit 1;
	fi
	exec	timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5))	\
		rsync	--timeout=${iotimeout}	\
		--password-file ${rsync_pass}	\
		-e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user}  -oConnectTimeout=${contimeout}"	\
		-izrltH --fuzzy --fuzzy --inplace	\
		--link-dest=${$backupdir}/${viloca_backup_subdir}/	\
		"${arglist[@]}"	\
		${backupdir}/${viloca_backup_subdir}
}
export -f callpullrsync_viloca

callpullrsync_rsync() {
    scriptdir=/app/pangolin_src
	. ${scriptdir}/config/server.conf

	local arglist=( )
	if (( ${#@} )); then
		arglist=( "${@/#/belfry@euler.ethz.ch::${bfabric_downloads}}" )
	else
		#arglist=( "belfry@euler.ethz.ch::${working}/samples/" )
		echo "rsync job didn't receive list"
		exit 1;
	fi
	exec	timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5))	\
		rsync	--timeout=${iotimeout}	\
		--password-file ${rsync_pass}	\
		-e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user}  -oConnectTimeout=${contimeout}"	\
		-izrltH --fuzzy --fuzzy --inplace	\
		--link-dest=${backupdir}/${sync_backup_subdir}	\
		"${arglist[@]}"	\
		${backupdir}/${sync_backup_subdir}
}
export -f callpullrsync_rsync

#
# sync helper
#
checksyncoutput() {
    local new="${statusdir}/sync${1}_new"
    local last="${statusdir}/sync${1}_last"

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


set -e

echo belfry.sh $1

#
# main handler
#
case "$1" in
    qa_report)
        . $baseconda/mambaforge/bin/activate qa_report
        cd ${basedir}/${working}/
        if python qa_report.py; then
		echo qa report succeeded
	      	touch ${statusdir}/qa_report_success;
        else 
		echo qa report failed
		touch ${statusdir}/qa_report_fail
	fi
        mamba deactivate
    ;;
    pushseq)
        . $baseconda/mambaforge/bin/activate "wastewater"
        ./upload_viollier && touch ${statusdir}/pushseq_success || touch ${statusdir}/pushseq_fail
        mamba deactivate
    ;;
    gitaddseq)
        . $baseconda/mambaforge/bin/activate "wastewater"
        cd ${releasedir}
        git add qa*
        find samples -name '*.fasta' -type f -print0 | xargs -0 git add
        mamba deactivate
    ;;
    df)
        df -h ${basedir}
	echo
        df -h --inode ${basedir}
    ;;
    garbage)
        validateBatchName "$2"

        for f in ${sampleset}/*/${2}; do
            garbage=$(dirname "${f//${sampleset}/garbage}")
            mkdir ${mode:+--mode=${mode}} -p "${garbage}"
            mv -v "${f%/}" "${garbage}/"
        done
        for f in ${working}/samples/*/${2}/; do
            garbage="${f//${working}\/samples/garbage}"
            mkdir ${mode:+--mode=${mode}} -p "${garbage%/}/"{raw_data,extracted_data}/
            mv -vf "${f%/}/raw_data/"* "${garbage%/}/raw_data/"
            rm "${f%/}/raw_data/"*.fa*
            rmdir "${f%/}/raw_data/"
            #mv -vf "${f%/}/extracted_data/"* "${garbage%/}/extracted_data/"
            #rm "${f%/}/extracted_data/"*_fastqc.html
            #rmdir "${f%/}/extracted_data/"
            mv -vf "${f%/}/"* "${garbage%/}/"
            rmdir "${f%/}"
        done
        mv "${sampleset}/batch.${2}.yaml" "${sampleset}/samples.${2}.tsv" "${sampleset}/missing.${2}.txt" "${sampleset}/projects.${2}.tsv" garbage/
    ;;
    pull_sync_status)
        echo "Pulling the updated status of the raw data sync"
        err=0
		rsync	\
			--password-file ${rsync_pass}	\
			-e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user} "	\
			-izrltH --fuzzy --fuzzy --inplace	\
			-p --chmod=Dg+s,ug+rw,o-rwx	\
			-g --chown=:"${storgrp}"	\
			belfry@euler.ethz.ch::${remote_status}/sync/ \
			${statusdir}/remote_sync || (( ++err ))
		if (( err )); then
			echo "Error: ${err} rsync job(s) failed"
			touch ${statusdir}/pull_sync_status_fail
		else
			touch ${statusdir}/pull_sync_status_success
		fi
    ;;
    pull_sortsamples_status)
        echo "Pulling the updated status of the sortsamples procedure"
        err=0
		rsync	\
			--password-file ${rsync_pass}	\
			-e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user} "	\
			-izrltH --fuzzy --fuzzy --inplace	\
			-p --chmod=Dg+s,ug+rw,o-rwx	\
			-g --chown=:"${storgrp}"	\
			belfry@euler.ethz.ch::${remote_status}/sortsamples/* \
			${statusdir}/remote_sortsamples || (( ++err ))
		if (( err )); then
			echo "Error: ${err} rsync job(s) failed"
			touch ${statusdir}/pull_sortsamples_status_fail
		else
			touch ${statusdir}/pull_sortsamples_status_success
		fi
    ;;
	pushsamplelist_viloca)
        echo "Pushing the VILOCA sample list to the remote"
		err=0
		rsync	\
			--password-file ${rsync_pass}	\
			-e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user} "	\
			-izrltH --fuzzy --fuzzy --inplace	\
			-p --chmod=Dg+s,ug+rw,o-rwx	\
			-g --chown=:"${storgrp}"	\
			${viloca_basedir}/${viloca_samples} \
			belfry@euler.ethz.ch::${viloca_processing}/ || (( ++err ))
		if (( err )); then
			echo "Error: ${err} rsync job(s) failed"
			touch ${viloca_statusdir}/pushsamplelist_viloca_fail
		else
			touch ${viloca_statusdir}/pushsamplelist_viloca_success
		fi
	;;
    queue_upload)
        echo "Adding new samples to the upload list"
        validateBatchName "$2"
        cd ${uploader_workdir}
        sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.${2}.tsv"  )
        rsync \
            --password-file ${HOME}/.ssh/rsync.pass.euler \
            -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user} " \
            -izrltHLK --fuzzy --fuzzy --inplace \
            "${sheets[@]}" \
            ${basedir}/tmp/belfrysheets/
        if [ -f ${uploader_sampleset}/samples.${2}.tsv ]; then
            # Add the new batch on top of the list. This ensures that the most recent batches are uploaded first, in case of retrospective uploads
            cat ${uploader_sampleset}/samples.${2}.tsv | awk '{print $1,$2}' | sed -e 's/ /\t/' | cat - ${uploader_workdir}/${uploaderlist} > ${uploader_workdir}/${uploaderlist}_temp.txt && \
            mv ${uploader_workdir}/${uploaderlist}_temp.txt ${uploader_workdir}/${uploaderlist} && \
            # Remove possible duplicates after updating the upload list
            cat -n ${uploader_workdir}/${uploaderlist} | sort -uk2 | sort -n | cut -f2- > ${uploader_workdir}/.working_${uploaderlist} && \
            mv ${uploader_workdir}/.working_${uploaderlist} ${uploader_workdir}/${uploaderlist}
        else
            echo "WARNING: the sampleset for the selected batch has not been synced yet.\nPossible causes: the sample is not complete; errors in the sync process; the name is incorrect."
        fi
    ;;
    upload)
        ${scriptdir}/config/server.conf
        echo "uploading ${uploader_sample_number} samples from the list of samples to upload"
        source ${baseconda}/etc/profile.d/conda.sh
        conda activate sendcrypt
        cd ${uploader_workdir}
        . ${uploader_code}/prepare.sh -N ${uploader_sample_number} -c ${scriptdir}/config/server.conf
        if [ -f ${uploader_tempdir}/cram_to_download.txt ]; then
            rm ${uploader_tempdir}/cram_to_download.txt
        fi
        while IFS= read -r line; do
            line2=$(echo ${line} | sed 's/ /\//g')
            echo "${line2}/uploads/dehuman.cram" >> ${uploader_tempdir}/cram_to_download.txt
        done < "${uploader_tempdir}/to_upload.txt"
        echo "Downloading from Euler the necessary cram files"
        rsync   \
            --password-file ${rsync_pass}	\
            -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user}  -oConnectTimeout=${contimeout}"   \
            -izrltHLK --fuzzy --fuzzy --inplace       \
            --files-from=${uploader_tempdir}/cram_to_download.txt \
            --link-dest=${local_dataset}/${working}    \
            --exclude='alignments/'    \
            --exclude='extracted_data/'    \
            --exclude='preprocessed_data/'    \
            --exclude='raw_data/'   \
            --exclude='raw_uploads/'    \
            --exclude='references/'    \
            --exclude='variants/'   \
            --exclude='visualization/'      \
            --exclude='*.out.log'   \
            --exclude='*.err.log'   \
            --exclude='*.benchmark' \
            --exclude='*fastq.gz' \
            belfry@euler.ethz.ch::${working}/samples \
            ${local_dataset}/${working}/samples/
        rsync \
            --password-file ${rsync_pass}	\
            -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user}  -oConnectTimeout=${contimeout}"   \
            -izrltHLK --fuzzy --fuzzy --inplace       \
            belfry@euler.ethz.ch::lollipop/variants/timeline.tsv \
            ${local_dataset}/${working}
        rsync \
            --password-file ${rsync_pass}	\
            -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user}  -oConnectTimeout=${contimeout}"   \
            -izrltHLK --fuzzy --fuzzy --inplace       \
            belfry@euler.ethz.ch::${working}/qa.csv \
            ${local_dataset}/${working}
            archive_now="${uploader_archive}/$(date +"%Y-%m-%d"-%H-%M-%S)"
            mkdir -p $archive_now
        ( ${uploader_code}/upload.sh ${archive_now} && \
            echo "Running sendCrypt" && \
            ${sendcrypt_exec} update && \
            ${sendcrypt_exec} version | tee ${archive_now}/sencrypt_version_used.txt && \
            ${sendcrypt_exec} send ${uploader_target} | tee ${archive_now}/sencrypt.log) || \
            (echo "ERROR: the upload failed" | tee ${archive_now}/sendcrypt_failed && \
            exit 1)
        cat ${archive_now}/uploaded_run.txt >> ${uploader_uploaded} && \
            cp ${uploader_target}/meta_data.tsv ${archive_now}
        for i in $(find ${local_dataset}/${working} -iname *cram)
        do
            rm $i
        done
    ;;
    clean_sendcrypt_temp)
        echo "Clearning the sendcrypt temporary directories in ${uploader_tempdir}"
        dir=$(ls -d ${uploader_tempdir}/*)
        for i in $(find ${uploader_tempdir} -iname sendcrypt.*); do
            if [ -d ${i} ]; then
                echo "deleting ${i}"
                rm -r ${i}
            fi
        rm -r ${uploader_tempdir}/target/*
        done
    ;;
    pullsamples_for_db)
        shopt -s globstar
        # fetch remote sheets
        mkdir -p ${basedir}/tmp/belfrysheets/
        if [[ "${2}" = "--recent" ]]; then
            sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.${lastmonth}*.tsv" "belfry@euler.ethz.ch::${sampleset}/samples.${thismonth}*.tsv" )
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.${3}.tsv"  )
        else
            sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.2*.tsv" )
        fi
        rsync \
            --password-file ${HOME}/.ssh/rsync.pass.euler \
            -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb -l ${cluster_user} " \
            -izrltHLK --fuzzy --fuzzy --inplace \
            "${sheets[@]}" \
            ${basedir}/tmp/belfrysheets/
        if [[ "${2}" = "--recent" ]]; then
            sheets=( ${basedir}/tmp/belfrysheets/samples.${lastmonth}*.tsv ${basedir}/tmp/belfrysheets/samples.${thismonth}*.tsv )
            # BUG: will generate non-globed pattern if months are missing
            echo "pulling recent: ${param[*]##/}"
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "${basedir}/tmp/belfrysheets/samples.${3}.tsv"  )
        elif [[ "${2}" = "--catchup" ]]; then
            sheets=( "${basedir}/tmp/belfrysheets/samples.catchup.tsv"  )
        else
            sheets=( ${basedir}/tmp/belfrysheets/samples.2*.tsv )
        fi
        echo "pulling: ${sheets[*]##/}"
        err=0
        echo "samples:"
        cut -s --fields=1 "${sheets[@]}"|sort -u| \
            gawk -v P=$(( parallelpull * 4 )) '{i=(NR-1);b=i%P;o[b]=(o[b] " \"" $1 "\"")};END{for(i=0;i<P;i++){printf("%s\0",o[i])}}'| \
            xargs -0 -P $parallelpull -I '{@LIST@}' -- \
            bash -c "callpullrsync_fordb {@LIST@} " || (( ++err ))
        if (( err )); then
            echo "FAILED" | tee ${statusdir}/pullsamples_for_db_${now}
        else
            echo "SUCCESS" | tee ${statusdir}/pullsamples_for_db_${now}
        fi
    ;;
    backup_uploader)
        echo "Backup of uploader archives to bs-bewi08"
        err=0
        rsync	\
            -e "ssh -i ${HOME}/.ssh/id_ed25519_wisedb" \
            -izrltH --fuzzy --fuzzy --inplace	\
            ${uploader_archive}    \
            bs-pangolin@d@bs-bewi08.ethz.ch:${remote_uploader_backup_dir} || (( ++err ))
        if (( err )); then
			echo "Error: ${err} rsync of uploader archive to bs-bewi08 failed"
			touch ${statusdir}/push_archive_uploader_fail
		else
			touch ${statusdir}/push_archive_uploader_success
		fi
    ;;
    get_pangolin_commit)
        cd ${scriptdir}
        branch=$(git status | head -n 1 | sed -e 's/# On branch //')
        commit=$(git log -n 1 ${branch} | head -n 1)
        echo "Branch: ${branch}\n${commit}"
    ;;
    *)
        echo "Unkown sub-command ${1}" > /dev/stderr
        exit 2
    ;;
esac
