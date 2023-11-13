#!/usr/bin/env bash

usage() { echo "Usage: $0 [-c <configfile>] [ -N <sample_number> ] [ -a <archivedir> ]" 1>&2; exit $1; }


while getopts "c:N:a:h" o; do
    case "${o}" in
        c)  configfile=${OPTARG}
            if [[ ! -r ${configfile} ]]; then
                echo "Cannot read ${configfile}" 1>&2
                usage 1
            fi
            ;;
        a)  arhivedir="${OPTARG}"    ;;
        N)  sample_number="${OPTARG}"   ;;
        h)  usage 0 ;;
        *)  usage 1 ;;
    esac
done
shift $((OPTIND-1))

# set -euo pipefail
set -uo pipefail

. ${configfile}

${clusterdir}/uploader/prepare.sh -N $sample_number

archive_now="${clusterdir}/${uploader_archive}/$(date +"%Y-%m-%d"-%H-%M-%S)"
mkdir -p $archive_now

${clusterdir}/uploader/upload.sh ${archive_now}
cat ${archive_now}/uploaded_run.txt >> ${uploaded} 


echo ${batch_to_upload}

