#!/bin/bash

scriptdir=/cluster/project/pangolin/fgcz_sync_automation/pangolin/fgcz_sync
. ${scriptdir}/config/server.conf

status=${clusterdir_old}/status

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

custom_date=$(date '+%Y%m%d' --date='-6 months')

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
        sync_fgcz)
        # Loop through all the parameters passed after the first one
        if [[ -n $2 ]]; then
            case "$2" in
                --https)
		    echo "Running in HTTPS mode"
                    # Set the transfer type to HTTPS if --https is specified
                    type='https'
                ;;
                --ftp)
		    echo "Running in FTP mode"
                    # Set the transfer type to FTP if --ftp is specified
                    type='ftp'
                ;;
                *)
                    # Print an error message for unknown parameters and exit with code 2
                    echo "Unknown parameter ${2}" > /dev/stderr
                    exit 2
                ;;
            esac
	else
		echo "The first flag is required and must define the connection protocol. Please choose either --https or --ftp"
		exit 2
	fi
        # Set the directory where bfabric downloads are stored
        bfabricdir=${download}  # CHANGED TO FOLDER ON EULER - fgcz_download_folder (server.conf) or download defined in fgcz.conf
        cd ${bfabricdir}
        
        # Define the directory to store sync status
        sync_fgcz_statusdir=${status}/sync
        mkdir -p $sync_fgcz_statusdir  # Create the status directory if it doesn't exist
        
        # Load the FGCZ configuration file
        fgcz_config=${clusterdir}/config/fgcz.conf

        echo "Sync FGCZ - bfabric"

        echo "Syncing from node $(hostname)"  # Print the hostname of the current node
        
        # Activate the sync environment using conda
        conda activate sync
        
        # Load the project list from the FGCZ config
        . <(grep '^projlist=' ${fgcz_config})

        # Check if the "--recent" parameter is passed
        if [[ "${3}" = "--recent" ]]; then
            limitlast=$custom_date  # Set the time limit 
            # Generate an exclude list for recent projects
            ${clusterdir}/exclude_list_bfabric.py -c ${fgcz_config} -r "${limitlast}" -o ${sync_fgcz_statusdir}/fgcz.exclude.lst
            param=( '-e' "${sync_fgcz_statusdir}/fgcz.exclude.lst" "${projlist[@]}" )
            echo -ne "syncing recent: ${limitlast}\texcluding: "
            wc -l ${sync_fgcz_statusdir}/fgcz.exclude.lst  # Print the number of excluded projects
        else
            param=( "${projlist[@]}" )  # Use the entire project list if "--recent" is not specified
        fi
        
        fail=0  # Initialize fail flag to 0 (success)
        if [[ "${type}" = "https" ]]; then
            # Run the sync command for HTTPS and store the output, set fail flag if the command fails
            syncoutput="$(${clusterdir}/sync_sftp.sh -c ${fgcz_config} ${limitlast:+ -N "${limitlast}"} -H "${param[@]}"|tee /dev/stderr)" || fail=1
        else
            # Run the sync command for default type and store the output, set fail flag if the command fails
            syncoutput="$(${clusterdir}/sync_sftp.sh -c ${fgcz_config} ${limitlast:+ -N "${limitlast}"} "${param[@]}"|tee /dev/stderr)" || fail=1
        fi
        
        # Check the sync output for any issues
        checksyncoutput "fgcz" "$syncoutput"
        
        # Create a success or fail marker file based on the sync result
        (( fail == 0 )) && touch ${sync_fgcz_statusdir}/sync_fgcz_success || touch ${sync_fgcz_statusdir}/sync_fgcz_fail
        
        # Deactivate the conda environment
        conda deactivate
        ;;
        get_vpipe_commit)
                cd ${vpipe_code}
                branch=$(git status | head -n 1 | sed -e 's/# On branch //')
                commit=$(git log -n 1 ${branch} | head -n 1)
                echo "Branch: ${branch}\n${commit}"
        ;;
        *)
                echo "Unkown sub-command ${1}" > /dev/stderr
                exit 2
        ;;
esac
