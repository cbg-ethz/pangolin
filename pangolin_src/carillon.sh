#!/bin/bash

scriptdir=/app/pangolin_src

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
mkdir ${mode:+--mode=${mode}} -p ${viloca_statusdir}
mkdir ${mode:+--mode=${mode}} -p ${uploader_statusdir}

touch ${statusdir}/oh_hai_im_looping

source /home/bs-pangolin/.ssh/${cluster_user}@${cluster}
remote_batman="ssh -o StrictHostKeyChecking=no -ni ${privkey} ${cluster_user}@${cluster} --"

#
# Phase 1: periodic data sync
#

echo '========='
echo 'Data sync'
echo '========='

set -e

[[ -n $skipsync ]] && echo "${skipsync} will be skipped."

[[ $skipsync != fgcz ]] && ${remote_batman} sync_fgcz --recent
${scriptdir}/belfry.sh pull_sync_status
if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then
    echo "\e[31;1Pulling sync status files failed\e[0m"
    echo "The automation will not be aware of any new deliveries"
else
    if [ $backup_fgcz_raw -eq "1" ]; then
        ${scriptdir}/belfry.sh pull_fgcz_data
    if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then
            echo "\e[31;1Backup of fgcz raw data failed\e[0m"
            echo "The system will retry next loop"
        fi
    else
        echo "\e[33;1mBackup of FGCZ raw data DISABLED\e[0m"
    fi
fi
${remote_batman} sortsamples --recent $([[ ${statusdir}/syncopenbis_last -nt ${statusdir}/syncopenbis_new ]] && echo '--summary')
${scriptdir}/belfry.sh pull_sortsamples_status
if [[ ( -e ${statusdir}/pull_sortsamples_status_fail ) && ( ${statusdir}/pull_sortsamples_status_fail -nt ${statusdir}/pull_sortsamples_status_success ) ]]; then
    echo "\e[31;1Pulling sortsamples status files failed\e[0m"
    echo "The automation will not be aware of any new deliveries"
fi


#
# Phase 2: update status of current run and trigger backups
#

echo "================="
echo "Check current run"
echo "================="

if [[ ( -e ${statusdir}/vpipe_started ) && ( ( ! -e ${statusdir}/vpipe_ended ) || ( ${statusdir}/vpipe_started -nt ${statusdir}/vpipe_ended ) ) ]]; then
    stillrunning=0
    echo "CHECK"
    while read j id; do
        echo $j $id
        # skip missing
        if [[ -z "${id}" ]]; then
            echo "$j : (not started)"
            continue
        fi

        # skip already finished
        if [[ ( -e ${statusdir}/vpipe_${j}_ended ) && ( ${statusdir}/vpipe_${j}_ended -nt ${statusdir}/vpipe_started ) ]]; then
            old="$(<${statusdir}/vpipe_${j}_ended)"
            if [[ "${id}" == "${old}" ]]; then
                echo "$j : $id already finished"
            else
                echo "$j : mismatch $id vs $old"
            fi
            continue
        fi

        # cluster status
        stat=$(${remote_batman} job "${id}" || echo "(no answer)")
	# HACK leaky abstraction ; keep in sync with profiles/smk-simple-slurm/status-sacct.sh
        if [[ ( -n "${stat}" ) && ( "${stat}" =~ ^(RUNNING|PENDING|COMPLETING|CONFIGURING|SUSPENDED|\(no answer \)).* ) ]]; then
            # running
            echo -n "$j : $id : $stat"
            (( ++stillrunning ))
            if [[ "${stat}" =~ ^RUN && ( ! "$j" =~ qa$ ) ]]; then
                echo -ne '\t'
                ${remote_batman} completion "${id}" | tail -n 1
            else
                echo ''
            fi
            sleep 1
            continue
        fi

        # not running
        echo "$j : $id finishing"

        case "$j" in
            seqqa)
                if [ $backup_vpipe -eq "1" ]; then
                    ${scriptdir}/belfry.sh pullsamples_noshorah --recent
                    if [[ ( -e ${statusdir}/pullsamples_noshorah_fail ) && ( ${statusdir}/pullsamples_noshorah_fail -nt ${statusdir}/pullsamples_noshorah_success ) ]]; then
                        echo "\e[31;1mpulling data failed\e[0m"
                        (( ++stillrunning ))
                        continue
                    fi
                else
                    echo "\e[33;1mBackup of V-PIPE data DISABLED\e[0m"
                fi
            ;;
        esac

        echo "${id}" > ${statusdir}/vpipe_${j}_ended
    done < ${statusdir}/vpipe_started
    echo done

    if (( stillrunning == 0 )); then
        if [ $backup_vpipe -eq "1" ]; then
            ${scriptdir}/belfry.sh pullsamples_noshorah --recent
            if [[ ( ! -e ${statusdir}/pullsamples_noshorah_success ) || ( ${statusdir}/pullsamples_noshorah_success -nt ${statusdir}/pullsamples_noshorah_fail ) ]]; then
                echo "Pulling data success!"
            else
                echo "\e[31;1mpulling data failed\e[0m"
            fi
        else
            echo "\e[33;1mBackup of VPIPE data DISABLED\e[0m"
        fi
        echo "$(basename $(realpath ${statusdir}/vpipe_started))" > ${statusdir}/vpipe_ended
        vpipe_lastfile=$(cat ${statusdir}/vpipe_ended)
        vpipe_enddate=${vpipe_lastfile##*.}
        lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | awk '{print $1}')
        # queue the samples for upload. This will be handled in a dedicated section
        ${remote_batman} queue_upload ${lastbatch_vpipe}
    fi
else
    echo 'No current run.'
fi

#
# Phase 4: restart runs if new data
#

echo "============="
echo "Start new run"
echo "============="

# TODO support a yaml with regex
rxsample='([[:digit:]]{2}_20[[:digit:]]{2}_[01]?[[:digit:]]_[0-3]?[[:digit:]])'

# like "$*" but with a different field separator than default.
join_by() { local IFS="$1"; shift; echo "$*"; }

if [[ ( ( ! -e ${statusdir}/vpipe_ended ) && ( ! -e ${statusdir}/vpipe_started ) ) || ( ${statusdir}/vpipe_ended -nt ${statusdir}/vpipe_started ) ]]; then
    echo check missing samples
    clearline=0
    runreason=( )
    declare -A flowcell
    # if test -e ${statusdir}/vpipe_started; then
    ref=$(date --reference="${statusdir}/vpipe_started" '+%Y%m%d')
    limit=$(date --date='2 weeks ago' '+%Y%m%d')
    echo "Check batch against ${ref}:"
    #for t in ${cluster_mount}/${sampleset}/samples.20*.tsv; do
    for t in $(${remote_batman} listsampleset --all)
    do
        if [[ ! $t =~ samples.([[:digit:]]{8})_([[:alnum:]]{5,}(-[[:digit:]]+)?).tsv$ ]]; then
            echo "oops: Can't parse <${t}> ?!" > /dev/stderr
        fi

        # check Duplicates
        b="${BASH_REMATCH[1]}"
        f="${BASH_REMATCH[2]}"

        if [[ -n "${flowcell[$f]}" ]]; then
            echo "error: Duplicate flowcell $f : ${flowcell[$f]} vs $b" > /dev/stderr
            exit 2
        else
            flowcell[$f]=$b
        fi

        # check dates
        if (( clearline )) && [[ "$limit" < "$b"  ]]; then
            echo -ne "\n"
            clearline=0
        fi
        if [[ "$ref" < "$b" || "$ref" == "$b" ]]; then
            echo "!$b:$f"
            (( ++mustrun ))
            runreason+=( "${b}_${f}" )
        elif [[ "$limit" < "$b"  ]]; then
            if ${remote_batman} scanmissingsamples $t; then
                (( ++mustrun ))
                runreason+=( "${b}_${f}" )
            fi
        else
            if  [[ "$limit" < "$b"  ]]; then
                echo -e "\r($b:$f)\e[K"
            else
                echo -ne "($b:$f)\t"
                clearline=1
            fi
        fi
        # sanity check
        if [[ "$now" < "$b" ]]; then
            echo "oops: in the future $b vs $now"
        fi
    done
    
    # are we allowed to submit jobs ?
    if (( donotsubmit )); then
        echo -e '\e[35;1mWill NOT submit jobs\e[0m...' > /dev/stderr
        if (( mustrun )); then
            echo 'submit blocked' > ${statusdir}/submit_fail
            echo -e '...\e[33;1mbut there are new jobs that should be started !!!\e[0m' > /dev/stderr
        else
            echo '...and there is nothing to run anyway' > /dev/stderr
        fi
    # start jobs ?
    elif (( mustrun )); then
        echo 'Will start new job'

        # Sanity check
        if [[ ( -e ${statusdir}/sortsamples_fail ) && ( ${statusdir}/sortsamples_fail -nt  ${statusdir}/sortsamples_success ) ]]; then
            if (( staging )); then
                echo -e '\e[33;1mwarning: sampleset data not successfully fetched yet, using staging\e[0m' > /dev/stderr
            else
                echo 'data fetch error' > ${statusdir}/submit_fail
                echo -e '\e[31;1merror: sampleset data not successfully fetched yet\e[0m' > /dev/stderr
                exit 1
            fi
        fi
        if [[ ( ! -e ${statusdir}/syncopenbis_new ) || ( ( -e ${statusdir}/vpipe_started ) && ( ${statusdir}/vpipe_started -nt ${statusdir}/syncopenbis_new ) ) ]]; then
            echo 'oops: something fishy: no downloaded data newer than last run ?' > /dev/stderr
        fi
        # point of comparison for dates:
        if [[ -e ${statusdir}/vpipe_ended ]]; then
            lastrun=${statusdir}/vpipe_ended
        else
            # find the most recent 'new' sync status
            lastsync=( $(ls -t ${statusdir}/sync*_new) )
            if [[ -e "${lastsync[0]}" ]]; then
                lastrun="${lastsync[0]}"
            else
                # last fall back: sort success
                lastrun=${statusdir}/sortsamples_success
            fi
        fi

        # must run
        echo 'starting jobs'
        if (( run_shorah )); then
            shorah=""
        else
            shorah="--no-shorah"
        fi
        ${remote_batman} addsamples --recent && \
        ${remote_batman} vpipe ${shorah} --recent --tag "$(join_by ';' "${runreason[@]}")" > ${statusdir}/vpipe.${now} &&  \
        if [[ -s ${statusdir}/vpipe.${now} ]]; then
            ln -sf ${statusdir}/vpipe.${now} ${statusdir}/vpipe_started
            cat ${statusdir}/vpipe_started
            printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${statusdir}/vpipe_new.${now}
            if [[ -n "${mailto[*]}" ]]; then
                (
                    echo '(Possibly new) samples not having consensus sequences yet found in batches:'
                    printf ' - %s\n' "${runreason[@]}"
                    echo -e '\nStarting V-pipe on Euler:'
                    cat ${statusdir}/vpipe_started
                ) | mail -s '[Automation-carillon] Starting V-pipe on Euler' "${mailto[@]}"
                # -r "${mailfrom}"
            fi
        fi
    else
        echo 'No new jobs to start'
    fi
else
    echo 'There is already a vpipe run going on'
fi

#
# Phase 5: run viloca on new samples if no viloca instance is running
#
if [ "$run_viloca" -eq "1" ]; then

    echo "========================"
    echo "Check current VILOCA run"
    echo "========================"


    if [[ ( -e ${viloca_statusdir}/viloca_started ) && ( ( ! -e ${viloca_statusdir}/viloca_ended ) || ( ${viloca_statusdir}/viloca_started -nt ${viloca_statusdir}/viloca_ended ) ) ]]; then
        stillrunning=0
        # skip missing
        if [[ -z "${id}" ]]; then
            echo "VILOCA - $id : (not started)"
        fi
        # skip already finished
        if [[ ( -e ${viloca_statusdir}/viloca_${j}_ended ) && ( ${viloca_statusdir}/viloca_${j}_ended -nt ${viloca_statusdir}/viloca_started ) ]]; then
            old="$(<${viloca_statusdir}/viloca_${j}_ended)"
            if [[ "${id}" == "${old}" ]]; then
                echo "VILOCA : $id already finished"
                stillrunning=0
            else
                echo "VILOCA : mismatch $id vs $old"
            fi
        fi
        # cluster status
        stat=$(${remote_batman} job "${id}" || echo "(no answer)")
        if [[ ( -n "${stat}" ) && ( ! "${stat}" =~ (EXIT|DONE) ) ]]; then
            # running
            echo -n "VILOCA : $id : $stat\n"
            echo "VILOCA : $id still running"
            (( ++stillrunning ))
        fi

        if (( stillrunning == 0 )); then
            echo "No VILOCA running. Checking if the run was successful or if it ended prematurely due to the time limit"
            if grep -rq snake.err -e "JOB.*CANCELLED.*DUE TO TIME LIMIT"; then
                echo "Previous VILOCA run cancelled due to time limit. Restarting it"
                ${remote_batman} unlock_viloca && \
                ${remote_batman} viloca > ${viloca_statusdir}/viloca.${now}    &&    \
                if [[ -s ${viloca_statusdir}/viloca.${now} ]]; then
                    cat viloca.${now} > ${viloca_statusdir}/viloca_started
                    cat ${viloca_statusdir}/viloca_started
                    printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${viloca_statusdir}/viloca_new.${now}
                    if [[ -n "${mailto[*]}" ]]; then
                        (
                            echo '(Possibly new) samples not having VILOCA results yet found:'
                            printf ' - %s\n' "${runreason[@]}"
                            echo -e '\nStarting VILOCA on Euler:'
                            cat ${viloca_statusdir}/viloca_started
                        ) | mail -s '[Automation-carillon] Starting VILOCA on Euler' "${mailto[@]}"
                        # -r "${mailfrom}"
                    fi
                fi
            else
                lastbatch_viloca=$(cat $(ls -Art ${viloca_statusdir}/viloca_new* | tail -n 1) | head -n 1)
                echo "Archiving the VILOCA run on batch ${lastbatch_viloca} to make space in the results directory for a new run"
                ${remote_batman} archive_viloca_run ${lastbatch_viloca} || echo -e '...\e[33;1mFAILED TO ARCHIVE THE VILOCA RUN on batch ${lastbatch_viloca}\e[0m'
                echo "${id}" > ${viloca_statusdir}/viloca_${j}_ended
                echo "$(basename $(realpath ${viloca_statusdir}/viloca_started))" > ${viloca_statusdir}/viloca_ended
            fi
        else
            echo VILOCA still running
        fi
        lastbatch_viloca=$(cat $(ls -Art ${viloca_statusdir}/viloca_new* | tail -n 1) | head -n 1)
        #if [ $backup_viloca -eq "1" ]; then
        #    ${scriptdir}/belfry pullresults_viloca --batch ${lastbatch_viloca}
        #    if [[ ( ! -e ${viloca_statusdir}/pullsamples_viloca_fail ) || ( ${viloca_statusdir}/pullsamples_viloca_success -nt ${viloca_statusdir}/pullsamples_viloca_fail ) ]]; then
        #        echo "Pulling VILOCA data success!"
        #    else
        #        echo "\e[31;1mpulling VILOCA data failed\e[0m"
        #    fi
        #else
        #    echo "\e[33;1mBackup of VILOCA data DISABLED\e[0m"
        #fi
    else
        echo 'No current VILOCA run.'
    fi

    #
    # Phase 6: restart VILOCA runs if new data
    #

    echo "===================="
    echo "Start new VILOCA run"
    echo "===================="
    mustrun_viloca=0
    if [[ ( ( ! -e ${viloca_statusdir}/viloca_ended ) && ( ! -e ${viloca_statusdir}/viloca_started ) ) || ( ${viloca_statusdir}/viloca_ended -nt ${viloca_statusdir}/viloca_started ) ]]; then
        lastbatch_viloca=$(cat $(ls -Art ${viloca_statusdir}/viloca_new* | tail -n 1) | head -n 1)
        echo "Last batch analysed by VILOCA is ${lastbatch_viloca}"
        vpipe_enddate=$(cat ${statusdir}/vpipe_ended)
        vpipe_enddate=${vpipe_enddate#*.}
        lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | awk '{print $1}' | tail -n 1)
        echo "The most recent completed V-Pipe run is on batch ${lastbatch_vpipe}"
        if [[ $lastbatch_viloca != $lastbatch_vpipe ]]; then
            echo "There is a new most recent batch that VILOCA can run on"
            t=$(${remote_batman} listsampleset --all | grep samples.${lastbatch_vpipe}.tsv)
            if [[ ! $t =~ samples.([[:digit:]]{8})_([[:alnum:]]{5,}(-[[:digit:]]+)?).tsv$ ]]; then
                            echo "oops: Can't parse <${t}> ?!" > /dev/stderr
            fi
            ${remote_batman} create_sample_list_viloca ${lastbatch_vpipe}
            (( ++mustrun_viloca ))
        else
            echo "No new batch to run VILOCA on"
            echo "Checking if the previous batch was successful"
            not_processed=($(${remote_batman} scanmissingsamples_viloca $lastbatch_viloca))
            if [ "${not_processed}" -gt "0"]; then
                echo "Not all samples have been successfully completed. Repeating the run"
                (( ++mustrun_viloca ))
            else
                echo "Previous batch appears successful"
                echo "Nothing to do for VILOCA"
            fi
        fi

		# are we allowed to submit jobs ?
        if (( donotsubmit_viloca == 1 )); then
            echo -e '\e[35;1mWill NOT submit VILOCA jobs\e[0m...' > /dev/stderr
            if (( mustrun_viloca > 0 )); then
                echo 'VILOCA submit blocked' > ${viloca_statusdir}/viloca_submit_fail
                echo -e '...\e[33;1mbut there are new VILOCA jobs that should be started !!!\e[0m' > /dev/stderr
            else
                echo '...and there is nothing VILOCA-related to run anyway' > /dev/stderr
            fi
        # start jobs ?
        elif (( mustrun_viloca > 0 )); then
            echo 'New VILOCA job waiting. Checking if Viloca is already running...'
            if [[ ( -e ${viloca_statusdir}/viloca_started ) && ( ( ! -e ${viloca_statusdir}/viloca_ended ) || ( ${viloca_statusdir}/viloca_started -nt ${viloca_statusdir}/viloca_ended ) ) ]]; then
                echo "BUT there is already a VILOCA instance running! Retrying during the next loop"
            else
                echo 'starting VILOCA jobs'
				# we keep the staging file until the actual run so that, if anything goes wrong and VILOCA
				# does not start for a while, the staging will be constantly updated with the latest batch
				# and VILOCA will run only on the latest once it restarts
				${remote_batman} finalize_staging_viloca
                # must run
                ${remote_batman} viloca  => ${viloca_statusdir}/viloca.${now}    &&    \
                    if [[ -s ${viloca_statusdir}/viloca.${now} ]]; then
                        cat viloca.${now} | tee ${viloca_statusdir}/viloca_started
                        echo ${lastbatch_vpipe} > ${viloca_statusdir}/viloca_new.${now}
                        printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${viloca_statusdir}/viloca_new.${now}
                        if [[ -n "${mailto[*]}" ]]; then
                            (
                                echo '(Possibly new) samples not having VILOCA results yet found:'
                                printf ' - %s\n' "${lastbatch_vpipe}"
                                echo -e '\nStarting VILOCA on Euler:'
                                cat ${viloca_statusdir}/viloca_started
                            ) | mail -s '[Automation-carillon] Starting VILOCA on Euler' "${mailto[@]}"
                            # -r "${mailfrom}"
                        fi
                    fi
            fi
        else
            echo 'No new VILOCA run to submit'
        fi
    else
        echo 'There is already A VILOCA run going on'
    fi
else
    echo 'Skipping VILOCA as per configuration'
fi



#
# Phase 7: run uploader on new chunk if no chunks are running
#
if [ $run_uploader -eq "1" ]; then

    echo "========================"
    echo "Check current UPLOADER run"
    echo "========================"


    if [[ ( -e ${uploader_statusdir}/uploader_started ) && ( ( ! -e ${uploader_statusdir}/uploader_ended ) || ( ${uploader_statusdir}/uploader_started -nt ${uploader_statusdir}/uploader_ended ) ) ]]; then
        stillrunning=0
        while read j k l id; do
            # skip missing
            if [[ -z "${id}" ]]; then
                echo "UPLOADER - $id : (not started)"
                continue
            fi

            # skip already finished
            if [[ ( -e ${uploader_statusdir}/uploader_${j}_ended ) && ( ${uploader_statusdir}/viloca_${j}_ended -nt ${uploader_statusdir}/uploader_started ) ]]; then
                old="$(<${uploader_statusdir}/uploader_${j}_ended)"
                if [[ "${id}" == "${old}" ]]; then
                    echo "UPLOADER : $id already finished"
                else
                    echo "UPLOADER : mismatch $id vs $old"
                fi
                continue
            fi

            # cluster status
            stat=$(${remote_batman} job "${id}" || echo "(no answer)")
            if [[ ( -n "${stat}" ) && ( ! "${stat}" =~ (EXIT|DONE) ) ]]; then
                # running
                echo -n "UPLOADER : $id : $stat"
                (( ++stillrunning ))
                sleep 1
                continue
            fi

            # not running
            echo "UPLOADER : $id finishing"

            echo "${id}" > ${uploader_statusdir}/uploader_${id}_ended
        done < ${uploader_statusdir}/uploader_started

        if [ $backup_uploader -eq "1" ]; then
            ${scriptdir}/belfry pulldata_uploader --recent
            if [[ ( ! -e ${uploader_statusdir}/pulldata_uploader_fail ) || ( ${uploader_statusdir}/pulldata_uploader_success -nt ${uploader_statusdir}/pulldata_uploader_fail ) ]]; then
                echo "$(basename $(realpath ${uploader_statusdir}/uploader_started))" > ${uploader_statusdir}/uploader_ended
            else
                echo "\e[31;1mpulling UPLOADER data failed\e[0m"
            fi
        else
            echo "\e[33;1mBackup of uploader data DISABLED\e[0m"
        fi
    else
        echo 'No current UPLOADER run.'
    fi

    #
    # Phase 8: Start an UPLOADER chunk if new samples
    #

    echo "===================="
    echo "Start new UPLOADER run"
    echo "===================="
    mustrun_uploader=0
    if [[ ( ( ! -e ${uploader_statusdir}/uploader_ended ) && ( ! -e ${uploader_statusdir}/uploader_started ) ) || ( ${uploader_statusdir}/uploader_ended -nt ${uploader_statusdir}/uploader_started ) ]]; then
        # are we allowed to submit jobs ?
        if (( donotsubmit_uploader )); then
            echo -e '\e[35;1mWill NOT submit UPLOADER jobs\e[0m...' > /dev/stderr
            if (( mustrun_uploader )); then
                echo 'UPLOADER submit blocked' > ${uploader_statusdir}/uploader_submit_fail
                echo -e '...\e[33;1mbut there are new UPLOADER jobs that should be started !!!\e[0m' > /dev/stderr
            else
                echo '...and there is nothing UPLOADER-related to run anyway' > /dev/stderr
            fi
        # start jobs ?
        elif (( mustrun_uploader )); then
            echo "Checking the upload quotas:"
            echo "----"
            if [[ ! -f ${uploader_number_status}.${now} ]]; then
                echo "No status file with the amount of samples uploaded found. Assuming first run of the day"
                echo 0 > ${uploader_number_status}.${now}
            fi
            uploaded_number=$(cat ${uploader_number_status}.${now})
            echo "Daily sample number: ${uploaded_number}/${upload_number_quota}"
            echo "Daily size: $((${uploaded_number} * ${upload_avg_size}))/${upload_size_quota} MB"
            echo "----"
            next_number=$((${uploaded_number} + ${uploader_sample_number}))
            if [ "${next_number}" -gt "${upload_number_quota}" ] || [ "$((${next_number} * ${upload_avg_size}))" -gt "${upload_size_quota}" ]; then
                echo "We reached the daily submission quota imposed by SPSP for UPLOADS. Resuming tomorrow"
                touch ${uploader_statusdir}/uploader_quota_hit.${now}
            else
                echo 'New UPLOADER job waiting. Checking if Uploader is already running...'
                if [[ ( -e ${uploader_statusdir}/uploader_started ) && ( ( ! -e ${uploader_statusdir}/uploader_ended ) || ( ${uploader_statusdir}/uploader_started -nt ${uploader_statusdir}/uploader_ended ) ) ]]; then
                    echo "BUT there is already an UPLOADER instance running! Retrying during the next loop"
                else
                    echo 'starting UPLOADER job'
                    ${remote_batman} upload  > ${uploader_statusdir}/uploader.${now}    &&    \
                        if [[ -s ${uploader_statusdir}/uploader.${now} ]]; then
                            cat uploader.${now} | tee ${uploader_statusdir}/uploader_started
                            printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${uploader_statusdir}/uploader_new.${now}
                            echo $(( $(cat ${uploaded_number}) + ${uploader_sample_number} )) > ${uploader_number_status}.${now}
                            if [[ -n "${mailto[*]}" ]]; then
                                (
                                    echo -e '\nStarting UPLOADER on Euler:'
                                    cat ${uploader_statusdir}/uploader_started
                                ) | mail -s '[Automation-carillon] Starting UPLOADER on Euler' "${mailto[@]}"
                                # -r "${mailfrom}"
                            fi
                        fi
                fi
            fi
        else
            echo 'No new UPLOADER jobs to start'
        fi
    else
        echo 'There is already an UPLOADER run going on'
    fi
else
    echo "Skipping UPLOADER as per configuration"
fi


#
# Closing words
#

${scriptdir}/belfry.sh  df
${remote_batman} df
date -R
