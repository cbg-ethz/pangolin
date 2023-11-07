#!/usr/bin/env bash

# set -euo pipefail
set -uo pipefail

batch_to_upload=$1
source vars.sh

./prepare.sh $batch_to_upload

archive_now="${archive}/$(date +"%Y-%m-%d"-%H-%M-%S)"
mkdir $archive_now

${maindir}/upload.sh ${archive_now}
cat ${archive_now}/uploaded_run.txt >> ${uploaded} 


echo ${batch_to_upload}

