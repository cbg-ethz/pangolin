#!/usr/bin/env bash

usage() { echo "Usage: $0 [-c <configfile>] [ -N <sample_number> ] [-b <blacklist>]" 1>&2; exit $1; }


while getopts "c:N:b:h" o; do
    case "${o}" in
        c)  configfile=${OPTARG}
            if [[ ! -r ${configfile} ]]; then
                echo "Cannot read ${configfile}" 1>&2
                usage 1
            fi
            ;;
        N)  sample_number="${OPTARG}"   ;;
        b)  blacklist="${OPTARG}"   ;;
        h)  usage 0 ;;
        *)  usage 1 ;;
    esac
done
shift $((OPTIND-1))

set -eu

. ${configfile}

if [ -f ${uploader_tempdir}/to_upload.txt ]
then
        rm "${uploader_tempdir}/to_upload.txt"
fi
echo "Preparing the list of files to upload for this batch"

# Remove any lines that appear in the uploader_uploaded or blacklist files,
# then select the top sample_number lines and save them to the output file.
grep -F -x -v -f "${uploader_uploaded}" "${uploader_workdir}/${uploaderlist}" | \
	grep -F -v -f "${blacklist}" | \
	head -n "${sample_number}" > "${uploader_tempdir}/to_upload.txt"


