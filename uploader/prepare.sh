#!/usr/bin/env bash

usage() { echo "Usage: $0 [-c <configfile>] [ -N <sample_number> ] [ -a <archivedir> ] [ -l <uploadlist> ] [ -u uploaded ]" 1>&2; exit $1; }


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

set -eu

. ${configfile}

if [ -f ${uploader_tempdir}/to_upload.txt ]
then
	rm "${uploader_tempdir}/to_upload.txt"
fi
 TODO HERE
echo "Preparing the list of files to upload for this batch"
{ python3 - <(grep -v \# $sampleset_batch | cut -f 1 | tr -d '"') ${uploaded} ${batch_to_upload} ${tempdir}/to_upload.txt <<EOF
import sys
try:
	with open(sys.argv[1]) as f:
		current = [ element.strip() for element in f.readlines() ]
	with open(sys.argv[2]) as f:
		all = [ element.strip() for element in f.readlines() ]
	current = list(set(current) - set(all))
	current = [ element + "\t" + sys.argv[3] for element in current ]
	with open(sys.argv[4],'w') as f:
		for item in current:
			f.write(item+"\n")
except IOError:
        # fixes BrokenPipe
        sys.stdout.flush()
EOF
} 

