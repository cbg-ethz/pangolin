#!/usr/bin/env bash

scriptdir=/links/shared/covid19-pangolin/backup/rsv_backups/pangolin

if [[ $(uname) == Darwin ]]; then
    date=gdate
else
    date=date
fi


declare -A lab
. ${scriptdir}/server.conf

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

timeoutforeground=
#--foreground
#

now=$($date '+%Y%m%d')
lastmonth=$($date '+%Y%m' --date='-1 month')
thismonth=$($date '+%Y%m')
twoweeksago=$($date '+%Y%m%d' --date='-2 weeks')
oneweekago=$($date '+%Y%m%d' --date='-1 weeks')

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

callpullrsync() {
        scriptdir=/links/shared/covid19-pangolin/backup/rsv_backups/pangolin
        . ${scriptdir}/server.conf

        local arglist=( )
        if (( ${#@} )); then
                arglist=( "${@/#/belfry@euler.ethz.ch::${working_rsv}/samples/}" )
        else
                #arglist=( "belfry@euler.ethz.ch::${working}/samples/" )
                echo "rsync job didn't receive list"
                exit 1;
        fi
        exec    timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync   --timeout=${iotimeout}  \
                --password-file ${HOME}/rsync.pass.euler      \
                -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user}  -oConnectTimeout=${contimeout}"   \
                -izrltH --fuzzy --fuzzy --inplace       \
                --link-dest=${basedir}/${sampleset}/    \
                "${arglist[@]}" \
                --exclude='uploads/*'   \
                --exclude='raw_uploads/*.tmp.*' \
                --exclude='raw_data/*_R[12].fastq.gz'   \
                --exclude='extracted_data/R[12]_fastqc.html'    \
                --exclude='variants/SNVs/REGION_*/reads.fas'    \
                --exclude='variants/SNVs/REGION_*/w-*.reads.fas'        \
                --exclude='variants/SNVs/REGION_*/raw_reads/w-*.reads.fas.gz'   \
                --exclude='*.out.log'   \
                --exclude='*.err.log'   \
                --exclude='*.benchmark' \
                ${basedir}/${working}/samples/
}
export -f callpullrsync

callpullrsync_noshorah() {
         scriptdir=/links/shared/covid19-pangolin/backup/rsv_backups/pangolin
        . ${scriptdir}/server.conf

        local arglist=( )
        if (( ${#@} )); then
                arglist=( "${@/#/belfry@euler.ethz.ch::${working_rsv}/samples/}" )
        else
                #arglist=( "belfry@euler.ethz.ch::${working_rsv}/samples/" )
                echo "rsync job didn't receive list"
                exit 1;
        fi
        exec    timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync   --timeout=${iotimeout}  \
                --password-file ${HOME}/rsync.pass.euler      \
                -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user}  -oConnectTimeout=${contimeout}"   \
                -izrltH --fuzzy --fuzzy --inplace       \
                --link-dest=${basedir}/${sampleset}/    \
                "${arglist[@]}" \
                --exclude='uploads/*'   \
                --exclude='raw_uploads/*.tmp.*' \
                --exclude='raw_data/*_R[12].fastq.gz'   \
                --exclude='extracted_data/R[12]_fastqc.html'    \
                --exclude='variants/'   \
                --exclude='visualization/'      \
                --exclude='*.out.log'   \
                --exclude='*.err.log'   \
                --exclude='*.benchmark' \
                ${basedir}/${working}/samples/
}
export -f callpullrsync_noshorah

callpullrsync_viloca() {
        scriptdir=/links/shared/covid19-pangolin/backup/rsv_backups/pangolin
        . ${scriptdir}/server.conf
       
        local arglist=( )
        if (( ${#@} )); then
         arglist=( "${@/#/belfry@euler.ethz.ch::${work_viloca_rsv}/${viloca_results}}" )
        else
         #arglist=( "belfry@euler.ethz.ch::${working}/samples/" )
         echo "rsync job didn't receive list"
         exit 1;
        fi
        exec timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
         rsync --timeout=${iotimeout} \
         --password-file ${HOME}/rsync.pass.euler \
         -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user}  -oConnectTimeout=${contimeout}" \
         -izrltH --fuzzy --fuzzy --inplace \
         --link-dest=${$basedir}/${viloca_backup_subdir}/ \
         "${arglist[@]}" \
         ${basedir}/${viloca_backup_subdir}
}
export -f callpullrsync_viloca


set -e

echo automation_backups.sh $1

#
# main handler
#
case "$1" in
    test)
        echo "This is a connection test for the forced commands. If you can read this, you can correctly send commands to automation_backups.sh"
    ;;
    pull_fgcz_data)
        echo "backup of the FGCZ raw data"
        thismonth=$(date '+%m')
        lastmonth=$(date '+%m' --date='-1 month')
        thismonthyear=$(date '+%Y')
        lastmonthyear=$(date '+%Y' --date='-1 month')
        err=0
        if [[ "${2}" = "--recent" ]]; then
            dirs=$(rsync --timeout=${iotimeout} \
             --password-file ~/rsync.pass.euler \
             -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} -oConnectTimeout=${contimeout}" \
             --list-only \
             belfry@euler.ethz.ch::${bfabric_downloads_rsv}/${bfabric_project}/ |\
              awk '{print $3,$5}' | grep -E "((${thismonthyear}/${thismonth})|(${lastmonthyear}/${lastmonth}))" | awk '{print $2}' | tail -n +2)
            timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync --timeout=${iotimeout}  \
                     --password-file ~/rsync.pass.euler \
                     -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} -oConnectTimeout=${contimeout}" \
                     -izrltH --fuzzy --fuzzy --inplace \
                     -p --chmod=Dg+s,ug+rw,o-rwx \
                     -g --chown=:"${storgrp}" \
                     --files-from=<( printf "%s\n" "${dirs[@]}" ) \
                     belfry@euler.ethz.ch::${bfabric_downloads_rsv}/${bfabric_project} \
                     ${basedir}/${bfabric_downloads}/${bfabric_project} || (( ++err ))
        else
            timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync --timeout=${iotimeout}  \
                        --password-file ~/rsync.pass.euler      \
                        -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} -oConnectTimeout=${contimeout}"    \
                        -izrltH --fuzzy --fuzzy --inplace       \
                        -p --chmod=Dg+s,ug+rw,o-rwx     \
                        -g --chown=:"${storgrp}"        \
                        belfry@euler.ethz.ch::${bfabric_downloads_rsv}/ \
                        ${basedir}/${bfabric_downloads}/ || (( ++err ))
        fi
        if (( err )); then
            echo "FAILED" | tee ${backup_statusdir}/pull_fgcz_status_${now}
        else
            echo "SUCCESS" | tee ${backup_statusdir}/pull_fgcz_status_${now}
        fi
    ;;
    pullresults_viloca)
        echo "backup of the VILOCA results"
        err=0
        rsync \
            --password-file ~/rsync.pass.euler \
            -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} " \
            -izrltH --fuzzy --fuzzy --inplace \
            -p --chmod=Dg+s,ug+rw,o-rwx \
            -g --chown=:"${storgrp}" \
            belfry@euler.ethz.ch::${work_viloca_rsv}/ \
            ${basedir}/${viloca_backup_subdir}/ || (( ++err ))
        if (( err )); then
             echo "FAILED" | tee ${backup_statusdir}/pullresults_viloca_status_${now}
        else
           echo "SUCCESS" | tee ${backup_statusdir}/pullresults_viloca_status_${now}
        fi
    ;;
    pullresults_amplicon_cov)
        echo "backup of the AMPLICON COVERAGE results"
        err=0
        rsync   \
                --password-file ~/rsync.pass.euler   \
                -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} "  \
                -izrltH --fuzzy --fuzzy --inplace       \
                -p --chmod=Dg+s,ug+rw,o-rwx     \
                -g --chown=:"${storgrp}"        \
                belfry@euler.ethz.ch::${work_amplicon_cov_rsv}/ \
                ${basedir}/${amplicon_cov_backup_subdir}/ || (( ++err ))
        if (( err )); then
                echo "FAILED" | tee ${backup_statusdir}/pullresults_amplicon_cov_status_${now}
        else
                echo "SUCCESS" | tee ${backup_statusdir}/pullresults_amplicon_cov_status_${now}
        fi
    ;;
    pullsamples_uploader)
        echo "backup of the UPLOADER results"
        err=0
        rsync   \
                -izrltH --fuzzy --fuzzy --inplace       \
		${vm_user}@${vmaddress}:${uploader_archive} \
                ${basedir}/${uploader_backup_subdir}/ || (( ++err ))
        if (( err )); then
                echo "FAILED" | tee ${backup_statusdir}/pullresults_uploader_status_${now}
        else
                echo "SUCCESS" | tee ${backup_statusdir}/pullresults_uploader_status_${now}
        fi
    ;;
    pullsamples_noshorah)
        # fetch remote sheets
        mkdir -p ${basedir}/tmp/belfrysheets/
        if [[ "${2}" = "--recent" ]]; then
            for f in /path/to/your/files*; do
            ## Check if the glob gets expanded to existing files.
            ## If not, f here will be exactly the pattern above
            ## and the exists test will evaluate to false.
              [ -e "$f" ] && sheets=( "belfry@euler.ethz.ch::${sampleset_rsv}/samples.${lastmonth}*.tsv" "belfry@euler.ethz.ch::${sampleset_rsv}/samples.${thismonth}*.tsv" ) || sheets=( "belfry@euler.ethz.ch::${sampleset_rsv}/samples.${lastmonth}*.tsv" )
            ## This is all we needed to know, so we can break after the first iteration
            break
            done
            #sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.${lastmonth}*.tsv" "belfry@euler.ethz.ch::${sampleset}/samples.${thismonth}*.tsv" )
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "belfry@euler.ethz.ch::${sampleset_rsv}/samples.${3}.tsv"  )
        else
            sheets=( "belfry@euler.ethz.ch::${sampleset_rsv}/samples.2*.tsv" )
        fi
        rsync \
            --password-file ${HOME}/rsync.pass.euler \
            -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} " \
            -izrltH --fuzzy --fuzzy --inplace \
            -p --chmod=Dg+s,ug+rw,o-rwx \
            -g --chown=:"${storgrp}" \
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
        err=0
        timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
            rsync --timeout=${iotimeout} \
                --password-file ${HOME}/rsync.pass.euler \
                -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user}  -oConnectTimeout=${contimeout}" \
                -izrlt --fuzzy --fuzzy --inplace \
                --exclude='*.out.log' \
                --exclude='*.err.log' \
                --exclude='*.benchmark' \
                belfry@euler.ethz.ch::${working_rsv}/{qa.csv,variants} \
                ${basedir}/${working}/ || (( ++err ))
        echo "samples:"
        cut -s --fields=1 "${sheets[@]}"|sort -u| \
            gawk -v P=$(( parallelpull * 4 )) '{i=(NR-1);b=i%P;o[b]=(o[b] " \"" $1 "\"")};END{for(i=0;i<P;i++){printf("%s\0",o[i])}}'| \
            xargs -0 -P $parallelpull -I '{@LIST@}' -- \
            bash -c "callpullrsync_noshorah {@LIST@} " || (( ++err ))
        if (( err )); then
            echo "FAILED" | tee ${backup_statusdir}/pullsamples_noshorah_${now}
        elif [[ "${2}" = "--catchup" ]]; then
            echo -e '\n\e[38;5;45;1mFor the good of all of us\e[0m\n\e[38;5;208;1mExcept the ones who are dead\e[0m'
        else
            echo "SUCCESS" | tee ${backup_statusdir}/pullsamples_noshorah_${now}
        fi
    ;;
   *)
        echo "Unkown sub-command ${1}" > /dev/stderr
        exit 2
        ;;
esac
