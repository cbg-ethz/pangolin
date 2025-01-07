#!/bin/bash

# Define the directory containing the Pangolin source scripts
scriptdir=/app/pangolin_src

# Exit immediately if a command exits with a non-zero status
set -e

# Source the server configuration file
. ${scriptdir}/config/server.conf

# Set default values for variables if not already defined
: ${run_shorah:=0}       # Default to 0 if not defined
: ${staging:=1}         # Default to 1 if not defined

# Ensure script directory matches the base directory, otherwise print a message
if [[ $(realpath $scriptdir) != $(realpath $basedir) ]]; then
    echo "The scripts are in $scriptdir"
    echo "The base working directory for the automation is $basedir"
fi

# Validate the "mode" variable to ensure it is an octal chmod value (0-7)
if [[ ! $mode =~ ^[0-7]{,4}$ ]]; then
    echo "Invalid characters <${mode//[0-7]/}> in <${mode}>"
    echo 'mode should be an octal chmod value, see `mkdir --help` for information'
    mode=
fi

# Set default file creation permissions to allow group write access
umask 0002

# Get the current date in YYYYMMDD format
now=$(date '+%Y%m%d')

# Create necessary directories with the specified mode, if set
mkdir ${mode:+--mode=${mode}} -p ${statusdir}
mkdir ${mode:+--mode=${mode}} -p ${viloca_statusdir}
mkdir ${mode:+--mode=${mode}} -p ${uploader_statusdir}
mkdir ${mode:+--mode=${mode}} -p ${amplicon_coverage_statusdir}

# Create a marker file to indicate the loop is running
touch ${statusdir}/oh_hai_im_looping

# Source SSH keys for cluster and backup servers
source /home/bs-pangolin/.ssh/${cluster_user}@${cluster}
source /home/bs-pangolin/.ssh/${bck_user}@${bckhost}

# Define remote command execution shortcuts
remote_batman="ssh -o StrictHostKeyChecking=no -ni ${privkey} ${cluster_user}@${cluster} --"
remote_backup="ssh -o StrictHostKeyChecking=no -ni ${bck_privkey} ${bck_user}@${bckhost} --"

# Display the current Pangolin commit used for this automation run
echo "The current automation run is based on: "
${scriptdir}/belfry.sh get_pangolin_commit

# Phase 1: Periodic data synchronization
echo '========='
echo 'Data sync'
echo '========='

# Exit immediately if a command exits with a non-zero status
set -e

# Check if data sync should be skipped
if [[ -n $skipsync ]]; then
    echo "${skipsync} will be skipped."
fi

# Synchronize data from FGCZ if not explicitly skipped
if [[ "${skipsync}" != "fgcz" ]]; then
    ${remote_batman} sync_fgcz
    ${scriptdir}/belfry.sh pull_sync_status

    # Check for sync status failure
    if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then
        echo -e "\e[31;1mPulling sync status files failed\e[0m"
        echo "The automation will not be aware of any new deliveries"
    else
        # Backup raw data from FGCZ if enabled
        if [ $backup_fgcz_raw -eq "1" ]; then
            ${remote_backup} pull_fgcz_data --recent
            if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then
                echo -e "\e[31;1mBackup of FGCZ raw data failed\e[0m"
                echo "The system will retry next loop"
            fi
        else
            echo -e "\e[33;1mBackup of FGCZ raw data DISABLED\e[0m"
        fi
    fi
fi

# Sort samples based on recent updates
${remote_batman} sortsamples --recent $([[ ${statusdir}/syncopenbis_last -nt ${statusdir}/syncopenbis_new ]] && echo '--summary')
${scriptdir}/belfry.sh pull_sortsamples_status

# Check for sortsamples status failure
if [[ ( -e ${statusdir}/pull_sortsamples_status_fail ) && ( ${statusdir}/pull_sortsamples_status_fail -nt ${statusdir}/pull_sortsamples_status_success ) ]]; then
    echo -e "\e[31;1mPulling sortsamples status files failed\e[0m"
    echo "The automation will not be aware of any new deliveries"
fi


#
# Phase 2: Update status of the current run and trigger backups
#

echo "================="
echo "Check current run"
echo "================="

# Check if a V-Pipe run has started but not yet ended
if [[ ( -e ${statusdir}/vpipe_started ) && ( ( ! -e ${statusdir}/vpipe_ended ) || ( ${statusdir}/vpipe_started -nt ${statusdir}/vpipe_ended ) ) ]]; then
    stillrunning=0  # Initialize a counter to track running jobs
    echo "CHECK"
    while read j id; do
        echo $j $id
        # Skip if job ID is missing
        if [[ -z "${id}" ]]; then
            echo "$j : (not started)"
            continue
        fi

        # Skip if the job has already finished
        if [[ ( -e ${statusdir}/vpipe_${j}_ended ) && ( ${statusdir}/vpipe_${j}_ended -nt ${statusdir}/vpipe_started ) ]]; then
            old="$(<${statusdir}/vpipe_${j}_ended)"  # Retrieve the old job ID
            if [[ "${id}" == "${old}" ]]; then
                echo "$j : $id already finished"
            else
                echo "$j : mismatch $id vs $old"  # Job ID mismatch warning
            fi
            continue
        fi

        # Check the status of the job on the cluster
        stat=$(${remote_batman} job "${id}" || echo "(no answer)")
        # Handle various cluster statuses
        if [[ ( -n "${stat}" ) && ( "${stat}" =~ ^(RUNNING|PENDING|COMPLETING|CONFIGURING|SUSPENDED|\(no answer \)).* ) ]]; then
            # If the job is running or in a pending state
            echo -n "$j : $id : $stat"
            (( ++stillrunning ))  # Increment the counter for running jobs
            if [[ "${stat}" =~ ^RUN && ( ! "$j" =~ qa$ ) ]]; then
                echo -ne '\t'
                ${remote_batman} completion "${id}" | tail -n 1  # Check job completion status
            else
                echo ''
            fi
            sleep 1
            continue
        fi

        # If the job is no longer running
        echo "$j : $id finishing"

        case "$j" in
            seqqa)
                if [ $backup_vpipe -eq "1" ]; then
                    # Perform backup of processed samples
                    ${remote_backup} pullsamples_noshorah --recent
                    if [[ ( -e ${statusdir}/pullsamples_noshorah_fail ) && ( ${statusdir}/pullsamples_noshorah_fail -nt ${statusdir}/pullsamples_noshorah_success ) ]]; then
                        echo "\e[31;1mpulling data for database failed\e[0m"
                        (( ++stillrunning ))  # Increment counter if backup fails
                        continue
                    fi
                else
                    echo "\e[33;1mBackup of V-PIPE data DISABLED\e[0m"
                fi
                # Additional database pulling can be uncommented if required
                # ${scriptdir}/belfry.sh pullsamples_for_db --recent
                # if [[ ( -e ${statusdir}/pullsamples_for_db_fail ) && ( ${statusdir}/pullsamples_for_db_fail -nt ${statusdir}/pullsamples_for_db_success ) ]]; then
                #     echo "\e[31;1mpulling data for database failed\e[0m"
                #     (( ++stillrunning ))
                #     continue
                # fi
            ;;
        esac

        # Mark the job as ended by writing the job ID
        echo "${id}" > ${statusdir}/vpipe_${j}_ended
    done < ${statusdir}/vpipe_started
    echo done

    # If all jobs have completed
    if (( stillrunning == 0 )); then
        if [ $backup_vpipe -eq "1" ]; then
            # Perform final backup of processed samples
            ${remote_backup} pullsamples_noshorah --recent
            if [[ ( ! -e ${statusdir}/pullsamples_noshorah_success ) || ( ${statusdir}/pullsamples_noshorah_success -nt ${statusdir}/pullsamples_noshorah_fail ) ]]; then
                echo "Pulling data success!"
            else
                echo "\e[31;1mpulling data failed\e[0m"
            fi
        else
            echo "\e[33;1mBackup of VPIPE data DISABLED\e[0m"
        fi
        # Additional database pulling can be uncommented if required
        # ${scriptdir}/belfry.sh pullsamples_for_db --recent
        # if [[ ( ! -e ${statusdir}/pullsamples_for_db_success ) || ( ${statusdir}/pullsamples_for_db_success -nt ${statusdir}/pullsamples_for_db_fail ) ]]; then
        #     echo "Pulling data for database and uploads success!"
        # else
        #     echo "\e[31;1mpulling data for database and uploads failed\e[0m"
        # fi

        # Mark the current V-Pipe run as ended
        echo "$(basename $(realpath ${statusdir}/vpipe_started))" > ${statusdir}/vpipe_ended
        vpipe_lastfile=$(cat ${statusdir}/vpipe_ended)  # Read the last V-Pipe file
        vpipe_enddate=${vpipe_lastfile##*.}  # Extract the end date from the file
        lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | head -n 1 | awk '{print $1}')
        if [ $run_uploader -eq "1" ]; then
            # Queue the samples for upload to be handled in a dedicated section
            echo Queueing last vpipe batch ${lastbatch_vpipe} for upload
            ${scriptdir}/belfry.sh queue_upload ${lastbatch_vpipe}
        fi
    fi
else
    echo 'No current run.'
fi

#
# Phase 3: Restart runs if new data
#

echo "============="
echo "Start new run"
echo "============="

# Define a regex pattern to match sample names in the format YY_YYYY_MM_DD
rxsample='([[:digit:]]{2}_20[[:digit:]]{2}_[01]?[[:digit:]]_[0-3]?[[:digit:]])'

# Function to join array elements with a specified separator
join_by() {
    local IFS="$1"; shift; echo "$*"
}

# Check if there is no current V-Pipe run or the last run has ended
if [[ ( ( ! -e ${statusdir}/vpipe_ended ) && ( ! -e ${statusdir}/vpipe_started ) ) || ( ${statusdir}/vpipe_ended -nt ${statusdir}/vpipe_started ) ]]; then
    echo "Checking missing samples"
    clearline=0  # Variable to manage terminal output
    runreason=( )  # Array to store reasons for new runs
    declare -A flowcell  # Associative array to track flowcell IDs

    # Set reference and limit dates for processing
    ref=$(date --reference="${statusdir}/vpipe_started" '+%Y%m%d')
    limit=$(date --date='2 weeks ago' '+%Y%m%d')
    echo "Checking batch against reference date: ${ref}"

    # Loop through all available sample sets on the remote system (Euler)
    for t in $(${remote_batman} listsampleset --all); do
        # Validate file format against the expected pattern
        if [[ ! $t =~ samples.([[:digit:]]{8})_([[:alnum:]]{5,}(-[[:digit:]]+)?).tsv$ ]]; then
            echo "Error: Unable to parse <${t}>" > /dev/stderr
            continue
        fi

        # Extract batch and flowcell IDs from the matched regex
        b="${BASH_REMATCH[1]}"  # Batch date
        f="${BASH_REMATCH[2]}"  # Flowcell ID

        # Check for duplicate flowcells
        if [[ -n "${flowcell[$f]}" ]]; then
            echo "Error: Duplicate flowcell $f : ${flowcell[$f]} vs $b" > /dev/stderr
            exit 2
        else
            flowcell[$f]=$b
        fi

        # Check if the batch date is within the allowed range
        if (( clearline )) && [[ "$limit" < "$b" ]]; then
            echo -ne "\n"
            clearline=0
        fi

        if [[ "$ref" < "$b" || "$ref" == "$b" ]]; then
            echo "New batch found: !$b:$f"
            (( ++mustrun ))  # Increment the must-run counter
            runreason+=( "${b}_${f}" )
        elif [[ "$limit" < "$b" ]]; then
            # Scan for missing samples in recent batches
            if ${remote_batman} scanmissingsamples $t; then
                (( ++mustrun ))
                runreason+=( "${b}_${f}" )
            fi
        else
            # Display progress for older batches
            if [[ "$limit" < "$b" ]]; then
                echo -e "\r($b:$f)\e[K"
            else
                echo -ne "($b:$f)\t"
                clearline=1
            fi
        fi

        # Sanity check to ensure no future-dated batches
        if [[ "$now" < "$b" ]]; then
            echo "Error: Batch date $b is in the future compared to $now"
        fi
    done

    # Check if jobs are allowed to be submitted
    if (( donotsubmit )); then
        echo -e '\e[35;1mJob submission is disabled\e[0m' > /dev/stderr
        if (( mustrun )); then
            echo 'Job submission blocked' > ${statusdir}/submit_fail
            echo -e '...\e[33;1mHowever, there are new jobs that should be started!\e[0m' > /dev/stderr
        else
            echo '...and there are no new jobs to run' > /dev/stderr
        fi
    elif (( mustrun )); then
        echo 'Starting a new job...'

        # Validate the availability of required data
        if [[ ( -e ${statusdir}/remote_sortsamples/sortsamples_fail ) && ( ${statusdir}/remote_sortsamples/sortsamples_fail -nt ${statusdir}/remote_sortsamples/sortsamples_success ) ]]; then
            if (( staging )); then
                echo -e '\e[33;1mWarning: Using staging data due to incomplete fetch\e[0m' > /dev/stderr
            else
                echo 'Data fetch error' > ${statusdir}/submit_fail
                echo -e '\e[31;1mError: Required sampleset data not successfully fetched\e[0m' > /dev/stderr
                exit 1
            fi
        fi

        if [[ ( ! -e ${statusdir}/syncopenbis_new ) || ( ( -e ${statusdir}/vpipe_started ) && ( ${statusdir}/vpipe_started -nt ${statusdir}/syncopenbis_new ) ) ]]; then
            echo 'Warning: No new downloaded data since the last run' > /dev/stderr
        fi

        # Determine the most recent sync or sort status
        if [[ -e ${statusdir}/vpipe_ended ]]; then
            lastrun=${statusdir}/vpipe_ended
        else
            lastsync=( $(ls -t ${statusdir}/sync*_new) )
            if [[ -e "${lastsync[0]}" ]]; then
                lastrun="${lastsync[0]}"
            else
                lastrun=${statusdir}/remote_sortsamples/sortsamples_success
            fi
        fi

        # Start new jobs
        echo 'Starting new job...'
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
            printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${statusdir}/vpipe_new.${now}
            ${remote_batman} get_vpipe_commit | tee -a ${statusdir}/vpipe_new.${now}

            # Notify users if email recipients are specified
            if [[ -n "${mailto[*]}" ]]; then
                (
                    echo '(Possibly new) samples without consensus sequences found in batches:'
                    printf ' - %s\n' "${runreason[@]}"
                    echo -e '\nStarting V-pipe on Euler:'
                    cat ${statusdir}/vpipe_started
                ) | mail -s '[Automation-carillon] Starting V-pipe on Euler' "${mailto[@]}"
            fi
        fi
    else
        echo 'No new jobs to start'
    fi
else
    echo 'A V-pipe run is already in progress'
fi


#
# Phase 4: run viloca on new samples if no viloca instance is running
#
if [ "$run_viloca" -eq "1" ]; then

    echo "========================"
    echo "Check current VILOCA run"
    echo "========================"


    if [[ ( -e ${viloca_statusdir}/viloca_started ) && ( ( ! -e ${viloca_statusdir}/viloca_ended ) || ( ${viloca_statusdir}/viloca_started -nt ${viloca_statusdir}/viloca_ended ) ) ]]; then
        stillrunning=0
        timelimit_reached=0
        # skip missing
        id=$(cat ${viloca_statusdir}/viloca_started)
        id=${id#"Submitted batch job "}
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
        if [[ ( -n "${stat}" ) && ( "${stat}" =~ ^(RUNNING|PENDING|COMPLETING|CONFIGURING|SUSPENDED|\(no answer \)).* ) ]]; then            # running
            echo -n "VILOCA : $id : $stat"
            echo "VILOCA : $id still running"
            (( ++stillrunning ))
        fi
        if [[ ( -n "${stat}" ) && ( "${stat}" =~ ^( TIMEOUT ) ) ]]; then
            echo -n "VILOCA : $id : $stat\n"
            echo "VILOCA : $id reached time limit"
            (( ++timelimit_reached ))
        fi
        if (( stillrunning == 0 )); then
            if (( timelimit_reached > 0)); then
                echo "Previous VILOCA run cancelled due to time limit. Restarting it"
                ${remote_batman} unlock_viloca && \
                ${remote_batman} viloca > ${viloca_statusdir}/viloca.${now}    &&    \
                if [[ -s ${viloca_statusdir}/viloca.${now} ]]; then
                    cat ${viloca_statusdir}/viloca.${now} > ${viloca_statusdir}/viloca_started
                    cat ${viloca_statusdir}/viloca_started
                    printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${viloca_statusdir}/viloca_new.${now}
                    ${remote_batman} get_viloca_commit | tee -a ${viloca_statusdir}/viloca_new.${now}
                fi
            else
                lastbatch_viloca=$(cat $(ls -Art ${viloca_statusdir}/viloca_new* | tail -n 1) | head -n 1)
                echo "Archiving the VILOCA run on batch ${lastbatch_viloca} to make space in the results directory for a new run"
                ${remote_batman} archive_viloca_run ${lastbatch_viloca} || echo -e '...\e[33;1mFAILED TO ARCHIVE THE VILOCA RUN on batch ${lastbatch_viloca}\e[0m'
                echo "${id}" > ${viloca_statusdir}/viloca_${j}_ended
                echo "$(basename $(realpath ${viloca_statusdir}/viloca_started))" > ${viloca_statusdir}/viloca_ended
                if [ $backup_viloca -eq "1" ]; then
                    ${remote_backup} pullresults_viloca --batch ${lastbatch_viloca} > ${viloca_statusdir}/backup_viloca_status_${now}
                    if [[ ( ! -e ${viloca_statusdir}/backup_viloca_status_${now} ) || $(cat ${viloca_statusdir}/backup_viloca_status_${now}) -eq "SUCCESS" ]]; then
                        echo "Backup of VILOCA results on bs-bewi08 success!"
                    else
                        echo "\e[31;1mBackup of VILOCA results on bs-bewi08 failed\e[0m"
                    fi
                else
                    echo "\e[33;1mBackup of VILOCA results on bs-bewi08 DISABLED\e[0m"
                fi
            fi
        else
            echo VILOCA still running
        fi
    else
        echo 'No current VILOCA run.'
    fi

    #
    # Phase 5: restart VILOCA runs if new data
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
        lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | head -n 1 | awk '{print $1}' | tail -n 1)
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
            if [ "${not_processed}" -gt "0" ]; then
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
                ${remote_batman} viloca > ${viloca_statusdir}/viloca.${now}    &&    \
                    if [[ -s ${viloca_statusdir}/viloca.${now} ]]; then
                        cat ${viloca_statusdir}/viloca.${now} | tee ${viloca_statusdir}/viloca_started
                        echo ${lastbatch_vpipe} > ${viloca_statusdir}/viloca_new.${now}
                        printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${viloca_statusdir}/viloca_new.${now}
                        ${remote_batman} get_viloca_commit | tee -a ${viloca_statusdir}/viloca_new.${now}
                        if [[ -n "${mailto[*]}" ]]; then
                            (
                                echo '(Possibly new) samples not having VILOCA results yet found:'
                                printf ' - %s\n' "${lastbatch_vpipe}"
                                echo -e '\nStarting VILOCA on Euler:'
                                cat ${viloca_statusdir}/viloca_started
                            ) | mail -s '[Automation-carillon] Starting VILOCA on Euler' "${mailto[@]}"
                            # -r "${mailfrom}"
                        fi
                    else
                        echo "ERROR: could not create ${viloca_statusdir}/viloca.${now}"
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
# Phase 6: Run uploader on new chunk
#

# Check if uploader submissions are allowed
if [ ${donotsubmit_uploader} -eq "0" ]; then

    echo "===================="
    echo "Start new UPLOADER run"
    echo "===================="

    # Display current upload quotas
    echo "Checking the upload quotas:"
    echo "----"

    # Check if there is a status file for uploaded samples; create one if missing
    if [[ ! -f ${uploader_number_status}.${now} ]]; then
        echo "No status file with the amount of samples uploaded found. Assuming first run of the day"
        echo 0 > ${uploader_number_status}.${now}  # Initialize the status file
    fi

    # Read the number of samples uploaded today
    uploaded_number=$(cat ${uploader_number_status}.${now})

    # Display daily upload statistics
    echo "Daily sample number: ${uploaded_number}/${upload_number_quota}"
    echo "Daily size: $((${uploaded_number} * ${upload_avg_size}))/${upload_size_quota} MB"
    echo "----"

    # Calculate the number of samples after the current upload request
    next_number=$((${uploaded_number} + ${uploader_sample_number}))

    # Display details of the upload request
    echo "Asked to upload ${uploader_sample_number} new samples, consisting of about $((${uploader_sample_number} * ${upload_avg_size})) MB"

    # Check if the upload exceeds daily quotas
    if [ "${next_number}" -gt "${upload_number_quota}" ] || [ "$((${next_number} * ${upload_avg_size}))" -gt "${upload_size_quota}" ]; then
        echo "We reached the daily submission quota imposed by SPSP for UPLOADS. Resuming tomorrow"
        touch ${uploader_statusdir}/uploader_quota_hit.${now}  # Mark the quota as reached
    else
        # Start the uploader job if within quotas
        echo 'Starting UPLOADER job'
        ${scriptdir}/belfry.sh upload && \
        echo $(( ${uploaded_number} + ${uploader_sample_number} )) > ${uploader_number_status}.${now}  # Update the status file

        # Clean temporary folders if configured
        if [ ${clean_sendcrypt_temp} -eq "1" ]; then
            echo "Cleaning the temporary folders generated by SendCrypt"
            ${scriptdir}/belfry.sh clean_sendcrypt_temp
        fi
    fi

    # Perform a backup of uploader results if enabled
    if [ $backup_uploader -eq "1" ]; then
        ${scriptdir}/belfry.sh backup_uploader > ${uploader_statusdir}/backup_uploader_status_${now}

        # Check the success of the backup operation
        if [[ ( ! -e ${uploader_statusdir}/backup_uploader_status_${now} ) || $(cat ${uploader_statusdir}/backup_uploader_status_${now}) -eq "SUCCESS" ]]; then
            echo "Backup of UPLOADER results on bs-bewi08 success!"
        else
            echo "\e[31;1mBackup of UPLOADER results on bs-bewi08 failed\e[0m"
        fi
    else
        # Inform the user if backups are disabled
        echo "\e[33;1mBackup of UPLOADER results on bs-bewi08 DISABLED\e[0m"
    fi 
else
    # Skip uploader phase if configured
    echo "Skipping UPLOADER as per configuration"
fi


#
# Phase 7: run amplicon coverage on new batch
#
if [ $run_amplicon_coverage -eq "1" ]; then
    echo "===================="
    echo "Start new AMPLICON COVERAGE run"
    echo "===================="
    lastbatch_amplicon_coverage=$(cat $(ls -Art ${amplicon_coverage_statusdir}/amplicon_coverage_new* | tail -n 1) | head -n 1)
    echo "Last batch analysed by AMPLICON COVERAGE is ${lastbatch_amplicon_coverage}"
    vpipe_enddate=$(cat ${statusdir}/vpipe_ended)
    vpipe_enddate=${vpipe_enddate#*.}
    lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | head -n 1 | awk '{print $1}' | tail -n 1)
    echo "The most recent completed V-Pipe run is on batch ${lastbatch_vpipe}"
    if [[ $lastbatch_amplicon_coverage != $lastbatch_vpipe ]]; then
        echo "There is a new most recent batch that AMPLICON COVERAGE can run on"
        ${remote_batman} amplicon_coverage --batch ${lastbatch_vpipe} && echo ${lastbatch_vpipe} > ${amplicon_coverage_statusdir}/amplicon_coverage_new.${now}
    else
        echo "No new batch to run AMPLICON COVERAGE on"
    fi
    if [ ${backup_amplicon_cov} -eq "1" ]; then
        ${remote_backup} pullresults_amplicon_cov > ${amplicon_coverage_statusdir}/backup_ampliconcov_status_${now}
        if [[ ( ! -e ${amplicon_coverage_statusdir}/backup_ampliconcov_status_${now} ) || $(cat ${amplicon_coverage_statusdir}/backup_ampliconcov_status_${now} | tail -n 1) -eq "SUCCESS" ]]; then
            echo "Backup of AMPLICON COVERAGE results on bs-bewi08 success!"
        else
            echo "\e[31;1mBackup of AMPLICON COVERAGE results on bs-bewi08 failed\e[0m"
        fi
    else
        echo "\e[33;1mBackup of AMPLICON COVERAGE results on bs-bewi08 DISABLED\e[0m"
    fi 
else
    echo "Skipping AMPLICON COVERAGE as per configuration"
fi


#
# Closing words
#

${scriptdir}/belfry.sh  df #disk space usage on VM (wiseDB)
${remote_batman} df #disk space usage on Euler
date -R # current date
