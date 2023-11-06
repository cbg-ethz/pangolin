#!/usr/bin/env bash
  
# set -euo pipefail
set -uo pipefail

source vars.sh

echo "Checking the list of batches to upload"

if [ ! -d ${uploadlist} ]
then
	echo "ERROR: Cannot find the list of batches to upload"
	exit 9
fi
if [ ! -d ${uploadedbatches} ]
then
	echo "ERROR: Cannot find the list of uploaded batches"
fi

num_batches = $(wc -l ${uploadlist} | awk '{print $1}')
echo "Found ${num_batches} batches to upload"
if [[ ${num_batches} -eq 0 ]]
then
	echo "Exiting"
	exit 0
fi

batch_to_upload = $(head -n 1 $(uploadlist))
echo "Starting upload of batch ${uploadlist}. If this is a batch that has been already processed, only samples not previously submitted will be taken into consideration"

(. next_upload.sh ${batch_to_upload} && \
	tail -n +2 "${uploadlist}" > "${uploadlist}.tmp" && \
	mv "${uploadlist}.tmp" "${uploadlist}" && \
	echo ${batch_to_upload} >> ${uploadedbatches}) || \
	(echo "ERROR in handling the logging of the batches" && \
	exit 5)

