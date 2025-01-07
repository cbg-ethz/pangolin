#!/bin/bash

# Function to display usage information for the script
usage() { 
    echo "Usage: $0 -s
    -s : singleshot - stops at the first loop if it fails
    -h : this help" 1>&2
    exit $1
}

# Set singleshot mode to 0 by default
singleshot=0

# Parse command line options
while getopts "sh" o; do
    case "${o}" in
        s)  singleshot=1 ;;  # Set singleshot mode to 1 if -s is specified
        h)  usage 0 ;;       # Display usage information if -h is specified
        *)  usage 1 ;;       # Display usage information for any invalid option
    esac
done

# Set the script directory
scriptdir=/app/pangolin_src

# Source the server configuration file
. ${scriptdir}/config/server.conf

# Default timeouts
runtimeout=3600
shorttimeout=300

# Function to execute the carillon process
ring_carillon() {
    # Get the current date in YYYYMMDD format
    now=$(date '+%Y%m%d')

    # Get the runtimeout value from the server configuration file
    newtimeout=$(timeout -k 5 -s INT ${shorttimeout} grep -oP '(?<=^runtimeout=).*$' config/server.conf)
    if [[ -n "${runtimeout}" ]]; then
        runtimeout=${newtimeout}  # Update runtimeout if a new value is found
    fi

    # Test writing to storage by creating a temporary file 'b0rk'
    if timeout -k 5 -s INT ${shorttimeout} touch b0rk && [[ -f b0rk ]]; then
        rm b0rk  # Remove the temporary file if it was successfully created
    else
        echo "Aargh: problem writing on storage !!!"
        # TODO: Use carillon phases for more detailed error handling
        ${scriptdir}/belfry.sh df  # Run the belfry script to check disk space

        # Extract cluster username from the environment variable USER
        cluster_user="${USER%%@*}"
        cluster_user=$(timeout -k 5 -s INT ${shorttimeout} grep -oP '(?<=^cluster_user=).*$' config/server.conf)

        # Set up SSH command to access remote server
        remote_batman="ssh -o StrictHostKeyChecking=no -ni ${HOME}/.ssh/id_ed25519_batman -l ${cluster_user} euler.ethz.ch --"
        timeout -k 5 -s INT $shorttimeout ${remote_batman} df  # Check disk space on remote server
        date -R  # Print the current date in RFC 2822 format
        return 1  # Return with an error status
    fi

    # Run the carillon script for the specified runtimeout duration
    echo "Starting loop for: $runtimeout sec"
    timeout -k 5 -s INT $runtimeout ${scriptdir}/carillon.sh | tee -a ${statusdir}/carillon/carillon_${now}.log
    local retval=$?  # Capture the return value of the carillon script

    # Create a file to indicate the loop has completed
    timeout -k 5 -s INT $shorttimeout touch ${statusdir}/loop_done

    # Report NFS status (commented out by default)
    # dmesg -LTk | grep -P 'nfs:.*server \S* (OK|not responding)' --colour=always | tail -n 1

    return $retval  # Return the captured return value
}

# Define the stop file path
stopfile="${statusdir}/stop"

# Remove any previous stop file if it exists
if [[ -e "${stopfile}" ]]; then
    echo "(removing previous stop file)"
    rm "${stopfile}"
fi

# Run the carillon script for the first time
echo 'First run...'
ring_carillon || (( singleshot == 0 )) || exit 1  # Exit if singleshot mode is enabled and the first run fails

# Main loop to continuously run the carillon script every 1200 seconds (20 minutes)
while sleep 1200; do 
    # Re-enter the script directory (in case an NFS crash has rendered the previous working directory handle stale)
    workpath=$(dirname $(which $0))
    cd ~
    cd "${workpath}"

    echo 'loop...'
    # Renew Kerberos ticket (commented out by default)
    ####### /usr/bin/kinit -l 1h -k -t $HOME/$USER.keytab ${USER%@*}@D.ETHZ.CH;

    # Run the carillon script
    ring_carillon

    # Check if the stop file exists, and exit if it does
    if [[ -e "${stopfile}" ]]; then
        rm "${stopfile}"
        exit 0
    fi

    # Print the current date in RFC 2822 format
    date -R

done