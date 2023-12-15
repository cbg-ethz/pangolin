#!/usr/bin/env bash

usage() { echo "Usage: $0 [-c <configfile>] [ -N <sample_number> ]" 1>&2; exit $1; }


while getopts "c:N:a:h" o; do
    case "${o}" in
        c)  configfile=${OPTARG}
            if [[ ! -r ${configfile} ]]; then
                echo "Cannot read ${configfile}" 1>&2
                usage 1
            fi
            ;;
        N)  sample_number="${OPTARG}"   ;;
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
{ python3 - ${uploader_workdir}/${uploaderlist} ${uploader_uploaded} ${sample_number} ${uploader_tempdir}/to_upload.txt <<EOF
import sys
try:
    with open(sys.argv[1]) as f:
        all_to_upload = [ element.strip() for element in f.readlines() ]
    with open(sys.argv[2]) as f:
        uploaded = [ element.strip() for element in f.readlines() ]
    current = list(set(all_to_upload) - set(uploaded))
    current = current[:int(sys.argv[3])]
    with open(sys.argv[4],'w') as f:
        for item in current:
            f.write(item+"\n")
except IOError:
    # fixes BrokenPipe
    print("ERROR")
    sys.stdout.flush()
EOF
}

