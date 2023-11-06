#!/usr/bin/env bash

set -eu

batch_to_upload=$1
source vars.sh

sampleset_batch=${sampleset}/samples.${batch_to_upload}.tsv

if [ -f ${tempdir}/to_upload.txt ]
then
	rm "${tempdir}/to_upload.txt"
fi

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

