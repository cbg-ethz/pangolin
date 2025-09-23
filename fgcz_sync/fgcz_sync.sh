#!/bin/bash

scriptdir=/app/fgcz_sync

set -e

. ${scriptdir}/config/server.conf

: ${run_shorah:=0}
: ${staging:=1}

if [[ $(realpath $scriptdir) != $(realpath $basedir) ]]; then
    echo "The scripts are in $scriptdir"
    echo "The base working directory for the automation is $basedir"
fi

if [[ ! $mode =~ ^[0-7]{,4}$ ]]; then
    echo "Invalid characters <${mode//[0-7]/}> in <${mode}>"
    echo 'mode should be an octal chmod value, see `mkdir --help` for informations'
    mode=
fi

umask 0002

now=$(date '+%Y%m%d')

mkdir ${mode:+--mode=${mode}} -p ${statusdir}

touch ${statusdir}/oh_hai_im_looping

source /home/bs-pangolin/.ssh/${cluster_user}@${cluster}
source /home/bs-pangolin/.ssh/${bck_user}@${bckhost}
remote_batman="ssh -o StrictHostKeyChecking=no -ni ${privkey} ${cluster_user}@${cluster} --"
remote_backup="ssh -o StrictHostKeyChecking=no -ni ${bck_privkey} ${bck_user}@${bckhost} --"

echo "The current automation run is based on: "
${scriptdir}/belfry.sh get_pangolin_commit

#
# Phase 1: periodic data sync
#

echo '========='
echo 'Data sync'
echo '========='

set -e

if [[ -n $skipsync ]]; then
    echo "${skipsync} will be skipped."
fi

if [[ "${skipsync}" != "fgcz" ]]; then
    ${remote_batman} sync_fgcz --ftp --recent
    ${scriptdir}/belfry.sh pull_sync_status
    if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then
        echo "\e[31;1Pulling sync status files failed\e[0m"
        echo "The automation will not be aware of any new deliveries"
    else
        if [ $backup_fgcz_raw -eq "1" ]; then
            ${remote_backup} pull_fgcz_data --recent
            if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then #check the correct files
                echo "\e[31;1Backup of fgcz raw data failed\e[0m"
                echo "The system will retry next loop"
            fi
        else
            echo "\e[33;1mBackup of FGCZ raw data DISABLED\e[0m"
        fi
    fi
fi
