#/usr/bin/env bash
scriptdir=/app/pangolin_src

if [ -z $1 ] || [ ! -d $1 ]; then
  echo "ERROR: the script uploader.sh requires the archive folder as parameter. Parameter not set of directory no found."
  exit 1
fi

. ${scriptdir}/config/server.conf
cd ${uploader_code}
source ${baseconda}/etc/profile.d/conda.sh
conda activate sendcrypt

set -eu

# don't keep non-matching globs:
shopt -s nullglob

function bash_traceback() {
  local lasterr="$?"
  set +o xtrace
  local code="-1"
  local bash_command=${BASH_COMMAND}
  echo "Error in ${BASH_SOURCE[1]}:${BASH_LINENO[0]} ('$bash_command' exited with status $lasterr)" >&2
  if [ ${#FUNCNAME[@]} -gt 2 ]; then
    # Print out the stack trace described by $function_stack
    echo "Traceback of ${BASH_SOURCE[1]} (most recent call last):" >&2
    for ((i=0; i < ${#FUNCNAME[@]} - 1; i++)); do
      local funcname="${FUNCNAME[$i]}"
      [ "$i" -eq "0" ] && funcname=$bash_command
      echo -e "  ${BASH_SOURCE[$i+1]}:${BASH_LINENO[$i]}\\t$funcname" >&2
    done
  fi
  echo "Exiting with status ${code}" >&2
  exit "${code}"
}

# provide an error handler whenever a command exits nonzero
# propagate ERR trap handler functions, expansions and subshells
set -o errtrace

export TMPDIR=${uploader_tempdir}

echo "Creating the necessary files and directories"
if [ -f ${TMPDIR}/uploaded_run.txt ]; then
  rm ${TMPDIR}/uploaded_run.txt
fi

export target=${TMPDIR}/target
if [ -d $target ]; then
  rm -rf $target
fi
mkdir -p $target
tsv=${target}/meta_data.tsv
echo $tsv
archive_now=$1

echo "Initializing the submission metadata"
echo -e "is_assembly_update\tspecies\tstrain_name\tisolation_date\tlocation_general\tlocation_city\tlocation_geocoordinates\tisolation_source_description\tisolation_source_detailed\tisolation_source_name\tisolation_source_size_catchment_area\tisolation_source_population_size_catchment_area\tisolation_source_regions_catchment_area\tsequencing_purpose\tsequencing_investigation_type\torig_fastq_name_forward\tlibrary_preparation_kit\tsequencing_lab_name\tsequencing_platform\tassembly_method\traw_dataset_coverage\treporting_lab_name\tcollecting_lab_name\treporting_authors\traw_dataset_embargo\tgenbank_identifier\tENA_accession"> $tsv

echo "Retrieving CRAM files and adding their metadata line"

cat ${TMPDIR}/to_upload.txt |
while read samplename batch; do
  samplename=$(echo $samplename | tr -d '"')
  if [[ $samplename =~ [A-H][0-9]_24_.* ]]; then
    echo "skipped ski resort $samplename" | tee -a ${archive_now}/not_found.txt
    continue
  fi
  batch=$(echo $batch | tr -d '"')
  echo "$samplename $batch"
  X=${uploader_dataset}/working/samples/${samplename}/${batch}/uploads/dehuman.cram
  if [ -f $X ]; then
    cp $(realpath $X) $target/${samplename}.cram
    python3 ${uploader_code}/create_metadata_line.py -s ${samplename} -b ${batch} -o $tsv
    echo $samplename >> ${archive_now}/uploaded_run.txt
  else
    echo "not found $samplename" | tee -a ${archive_now}/not_found.txt
  fi
done

echo $tsv

ls -l $target
echo
echo

echo "Running sendCrypt"
if [ $update_sendcrypt -eq "1" ]; then
  sendcrypt update
fi

sendcrypt version | tee ${archive_now}/sencrypt_version_used.txt

(sendcrypt send ${target} | tee ${archive_now}/sencrypt.log && \
        cp ${tsv} ${archive_now}) || \
        (echo "ERROR: the upload failed" | tee ${archive_now}/sendcrypt_failed && \
        exit 1)

