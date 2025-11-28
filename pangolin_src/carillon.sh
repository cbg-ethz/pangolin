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
mkdir ${mode:+--mode=${mode}} -p ${amplicon_coverage_statusdir}
mkdir ${mode:+--mode=${mode}} -p ${downstream_analysis_statusdir}

touch ${statusdir}/oh_hai_im_looping

source /home/bs-pangolin/.ssh/${cluster_user}@${cluster}
source /home/bs-pangolin/.ssh/${bck_user}@${bckhost}
remote_batman="ssh -o StrictHostKeyChecking=no -ni ${privkey} ${cluster_user}@${cluster} --"
remote_backup="ssh -o StrictHostKeyChecking=no -ni ${bck_privkey} ${bck_user}@${bckhost} --"

echo "The current automation run is based on: "
${scriptdir}/belfry.sh get_pangolin_commit

#
# Phase 0: General information
#
echo '========='
echo 'This is the Influenza automation'
echo '========='

echo "Sorting samples"
${remote_batman} sortsamples --recent

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
                    ${remote_backup} pullsamples_noshorah --recent || echo "ERROR: failed to backup vpipe results"
                    if [[ ( -e ${statusdir}/pullsamples_noshorah_fail ) && ( ${statusdir}/pullsamples_noshorah_fail -nt ${statusdir}/pullsamples_noshorah_success ) ]]; then
                        echo "\e[31;1mpulling data for database failed\e[0m"
                        (( ++stillrunning ))
                        continue
                    fi
                else
                    echo "\e[33;1mBackup of V-PIPE data DISABLED\e[0m"
                fi
                #${scriptdir}/belfry.sh pullsamples_for_db --recent
                #if [[ ( -e ${statusdir}/pullsamples_for_db_fail ) && ( ${statusdir}/pullsamples_for_db_fail -nt ${statusdir}/pullsamples_for_db_success ) ]]; then
                #    echo "\e[31;1mpulling data for database failed\e[0m"
                #    (( ++stillrunning ))
                #    continue
                #fi
            ;;
        esac

        echo "${id}" > ${statusdir}/vpipe_${j}_ended
    done < ${statusdir}/vpipe_started
    echo done

    if (( stillrunning == 0 )); then
        if [ $backup_vpipe -eq "1" ]; then
            ${remote_backup} pullsamples_noshorah --recent || echo "ERROR: failed to backup vpipe results"
            if [[ ( ! -e ${statusdir}/pullsamples_noshorah_success ) || ( ${statusdir}/pullsamples_noshorah_success -nt ${statusdir}/pullsamples_noshorah_fail ) ]]; then
                echo "Pulling data success!"
            else
                echo "\e[31;1mpulling data failed\e[0m"
            fi
        else
            echo "\e[33;1mBackup of VPIPE data DISABLED\e[0m"
        fi
        #${scriptdir}/belfry.sh pullsamples_for_db --recent
        #if [[ ( ! -e ${statusdir}/pullsamples_for_db_success ) || ( ${statusdir}/pullsamples_for_db_success -nt ${statusdir}/pullsamples_for_db_fail ) ]]; then
        #    echo "Pulling data for database and uploads success!"
        #else
        #    echo "\e[31;1mpulling data for database and uploads failed\e[0m"
        #fi
        
        echo "$(basename $(realpath ${statusdir}/vpipe_started))" > ${statusdir}/vpipe_ended
        vpipe_lastfile=$(cat ${statusdir}/vpipe_ended)
        vpipe_enddate=${vpipe_lastfile##*.}
        lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | head -n 1 | awk '{print $1}')
        if [ $run_uploader -eq "1" ]; then
            # queue the samples for upload. This will be handled in a dedicated section
            echo Queueing last vpipe batch ${lastbatch_vpipe} for upload
            ${scriptdir}/belfry.sh queue_upload ${lastbatch_vpipe}
        fi
    fi
else
    echo 'No current run.'
fi

#
# Phase 3: restart runs if new data
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
    #ref=$(date --reference="${statusdir}/vpipe_started" '+%Y%m%d') # this thakes the TIMESTAMP of vpipe.started file
    # to make vpipe run on other batches read the ref date from vpipe ended file
    ref=$(grep -oE '[0-9]{8}' "${statusdir}/vpipe_ended")

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
        if [[ ( -e ${statusdir}/remote_sortsamples/sortsamples_fail ) && ( ${statusdir}/remote_sortsamples/sortsamples_fail -nt  ${statusdir}/remote_sortsamples/sortsamples_success ) ]]; then
            if (( staging )); then
                echo -e '\e[33;1mwarning: sampleset data not successfully fetched yet, using staging\e[0m' > /dev/stderr
            else
                echo 'data fetch error' > ${statusdir}/submit_fail
                echo -e '\e[31;1merror: sampleset data not successfully fetched yet\e[0m' > /dev/stderr
                exit 1
            fi
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
                lastrun=${statusdir}/remote_sortsamples/sortsamples_success
            fi
        fi

        # must run
        echo 'starting jobs'
        if (( run_shorah )); then
            shorah=""
        else
            shorah="--no-shorah"
        fi
        if (( skipaviti )); then
            aviti=""
        elif [ ${now} -ge ${aviti_date} ]; then
            aviti="--aviti"
        else
            aviti=""
        fi
        ${remote_batman} addsamples --recent && \
        ${remote_batman} vpipe ${shorah} ${aviti} --tag "$(join_by ';' "${runreason[@]}")" > ${statusdir}/vpipe.${now} &&  \
        if [[ -s ${statusdir}/vpipe.${now} ]]; then
            ln -sf ${statusdir}/vpipe.${now} ${statusdir}/vpipe_started
            cat ${statusdir}/vpipe_started
            printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${statusdir}/vpipe_new.${now} |
            #${remote_batman} get_vpipe_commit | 
                tee -a ${statusdir}/vpipe_new.${now}
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
# Phase 4: postprocessing of vpipe output to tsv file for genspectrum upload
#

echo "=============================================================================="
echo "Postprocessing of vpipe output to tsv file for genspectrum upload"
echo "=============================================================================="

if [ "$run_downstream" -eq "1" ]; then
    # 1. check if there is a current vpipe run: if not start the downstream processing of the results
    if [[ ${statusdir}/vpipe_ended -nt ${statusdir}/vpipe_started ]]; then
        check_file_exists=$(ls -Art ${downstream_analysis_statusdir}/downstream_new* | wc -l)
        if [[ "$check_file_exists" == "0" ]]; then
            touch ${downstream_analysis_statusdir}/downstream_new
        fi
        #load the status of the last downstream analyisis:
        ds_success="${downstream_analysis_statusdir}/iva_downstream_analysis_success"
        ds_fail="${downstream_analysis_statusdir}/iva_downstream_analysis_fail"

        # Ensure status files exist
        # Case 1: neither exists → create fail file newer than success file → downstream MUST run
        if [[ ! -e "$ds_success" && ! -e "$ds_fail" ]]; then
            echo "WARNING: downstream analysis status files don't exist. Will create them now"
            touch "$ds_success"
            sleep 1
            touch "$ds_fail"   # fail newer → downstream forced
        # Case 2: success missing but fail exists
        elif [[ ! -e "$ds_success" ]]; then
            echo "WARNING: Only iva_downstream_analysis_success file does not exist?"
        # Case 3: fail missing but success exists
        elif [[ ! -e "$ds_fail" ]]; then
            echo "WARNING: Only iva_downstream_analysis_fail file does not exist?"
        fi

        # check if downstream already ran on the latest batch:
        lastbatch_downs=$(cat $(ls -Art ${downstream_analysis_statusdir}/downstream_new* | tail -n 1))
        echo "Last batch analysed by downstream analysis is ${lastbatch_downs}"
        vpipe_enddate=$(cat ${statusdir}/vpipe_ended)
        vpipe_enddate=${vpipe_enddate#*.} #take only the date form the string stored in vpipe_ended
        lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | head -n 1 | awk '{print $1}' | tail -n 1)
        echo "The most recent completed V-Pipe run is on batch ${lastbatch_vpipe}"
        #### check the latest vpipe batch with the latest downstream analysis batch and the success of the brevious downstream analysis:
        # run case 1: $ds_success newer than $ds_fail  AND  lastbatch_downs != lastbatch_vpipe
        # run case 2: $ds_fail newer than $ds_success
        if [[ "$lastbatch_downs" != "$lastbatch_vpipe" ]] || [[ "$ds_fail" -nt "$ds_success" ]]; then
            echo "There is a new most recent batch that the downstream analyisis can run on"
            echo "starting postprocessing of vpipe output to tsv"
            #### RUN Downstream Analysis
            ${remote_batman} iva_vpipe_out_to_tsv
            ${scriptdir}/belfry.sh pull_downstream_status 
            if [[ -e ${downstream_analysis_statusdir}/pull_sync_downstream_analysis_fail ]] && [[ ${downstream_analysis_statusdir}/pull_sync_downstream_analysis_fail -nt ${downstream_analysis_statusdir}/pull_sync_downstream_analysis_success ]]; then
                echo -e "\e[31;1mPulling sync status of downstream_analysis script failed\e[0m"
                echo "The automation will not be aware of postprocessing of vpipe output status"
            else
                # check the status of the downstream processing
                if [[ ( -e ${downstream_analysis_statusdir}/iva_downstream_analysis_fail ) && ( ${downstream_analysis_statusdir}/iva_downstream_analysis_fail -nt ${downstream_analysis_statusdir}/iva_downstream_analysis_success ) ]]; then #check the correct files
                        echo "\e[31;1Downstream_analysis detect_AAMutations.R script failed\e[0m"
                else
                    echo "\e[31;1Downstream_analysis detect_AAMutations.R script success\e[0m"
                    #create status file to store the latest batch in
                    echo $lastbatch_vpipe > ${downstream_analysis_statusdir}/downstream_new.${now}
                fi
            fi
        else
            echo "No new batch to run the downstream analysis on"
        fi
    else
        echo "There is already a vpipe run going on. Can't run downstream_analysis."
    fi
else
    echo "skipping downstream analysis"
fi


#
# Closing words
#

${scriptdir}/belfry.sh  df
${remote_batman} df
date -R
