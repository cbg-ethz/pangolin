#/usr/bin/env bash

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

source vars.sh
export TMPDIR=${tempdir}

echo "Creating the necessary files and directories"
if [ -f ${tempdir}/uploaded_run.txt ]
then
	rm ${tempdir}/uploaded_run.txt
fi
if [ -d $staging ]
then
	rm -rf $staging
fi
mkdir -p $staging/{bacteria,viruses,logs,sent}

mkdir -p $target
tsv=$target/meta_data.tsv
echo $tsv
archive_now=$1

echo "Initializing the submission metadata"
echo -e "is_assembly_update\tspecies\tstrain_name\tisolation_date\tlocation_general\tlocation_city\tlocation_geocoordinates\tisolation_source_description\tisolation_source_detailed\tisolation_source_name\tisolation_source_size_catchment_area\tisolation_source_population_size_catchment_area\tisolation_source_regions_catchment_area\tsequencing_purpose\tsequencing_investigation_type\torig_fastq_name_forward\tlibrary_preparation_kit\tsequencing_lab_name\tsequencing_platform\tassembly_method\traw_dataset_coverage\treporting_lab_name\tcollecting_lab_name\treporting_authors\traw_dataset_embargo\tgenbank_identifier\tENA_accession"> $tsv

echo "Retrieving CRAM files and adding their metadata line"
cat ${tempdir}/to_upload.txt |
while read samplename batch; do
  echo $samplename
  samplename=$(echo $samplename | tr -d '"')
  if [[ $samplename =~ [A-H][0-9]_24_.* ]]; then
    echo "skipped ski resort $samplename" >> ${archive_now}/not_found.txt
    continue
  fi
  batch=$(echo $batch | tr -d '"')
  echo "$samplename $batch"
  X=${fldr}/${samplename}/${batch}/uploads/dehuman.cram
  if [ -f $X ]; then
    ln $(realpath $X) $target/${samplename}.cram
    python3 ${maindir}/create_metadata_line.py -s ${samplename} -b ${batch} -o $tsv
    echo $samplename >> ${archive_now}/uploaded_run.txt
  else
    echo "not found $samplename" >> ${archive_now}/not_found.txt
  fi
done

# fix pending spaces:
sed $tsv -i"" -e "s/ \t/\t/g"

echo $tsv

ls -l $target
echo
echo

echo "Running sendCrypt"

sendcrypt version | tee ${archive_now}/sencrypt_version_used.txt

sendcrypt send ${target} && \
	cp ${tsv} ${archive_now} && \
	cp -r ${staging}/sent ${archive_now}/ && \
	cp -r ${staging}/logs ${archive_now}/ || \
	echo "ERROR: the upload failed" && \
	exit 1

