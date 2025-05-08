#!/bin/bash

# Input: Virus subtype e.g. RSVA/RSVB
# Infput: Batch e.g. 20250417_2427493980

dir=/cluster/project/pangolin/rsv_pipeline/pangolin/pangolin_src
. ${dir}/config/server.conf
. ${dir}/config/fgcz.conf

# defaults, in case flags aren’t passed
variant=""
batch=""

# parse flags
while [[ $# -gt 0 ]]; do #$# is the count of remaining arguments; as long as it’s > 0 we loop.
  case "$1" in
    --variant)
      variant="$2"
      shift 2 #shift 2 drops the first two parameters and renumbers the others
      ;;
    --batch)
      batch="$2"
      shift 2
      ;;
    --) # end of options
      shift
      break
      ;;
    -*)
      echo "Error: unknown option $1" >&2 # matches any argument with single dash
      exit 1
      ;;
    *)  # positional arguments (if any) - matches anything that didn’t match a flag pattern
      extras+=("$1")
      shift
      ;;
  esac
done
#check if the variables are set correctly (if they are non empty)
if [[ -z "$variant" || -z "$batch" ]]; then
  echo "Usage: $0 --variant <name> --batch <id>" >&2
  exit 1
fi

echo "Variant is: $variant"
echo "Batch is: $batch"

variant_base_dir="${clusterdir_old}/${variant}/${working}/results" #variant/workdir/results

cd $variant_base_dir
garbage_dir="${variant_base_dir}/garbage"
mkdir -p "$garbage_dir"

sampleset_file="${sampleset}/projects.${batch}.tsv"

if [[ ! -f "$sampleset_file" ]]; then
  echo "ERROR: Required file '$sampleset_file' not found!" >&2
  exit 1
fi


# Read the first column (one sample name per line) into an array:
mapfile -t samples_from_batch < <(cut -f1 "$sampleset_file")

# Loop over the array:
for sample in "${samples_from_batch[@]}"; do
  echo "Processing sample: $sample"
  #create the directory in the garbage folder
  mkdir -p "${garbage_dir}/${sample}"
  #if directory exists then:
  if [[ -d "${variant_base_dir}/${sample}/${batch}" ]]; then 
    rsync -a "${variant_base_dir}/${sample}/${batch}" "${garbage_dir}/${sample}" &&  rm -r "${variant_base_dir}/${sample}/${batch}" 
    #now check if the sample has another batch directory inside; if not delete sample folder
    if [[ -d "${variant_base_dir}/${sample}/" && -z $(ls -A "${variant_base_dir}/${sample}/") ]]; then #-d "$dir" ensures it actually exists and is a directory.]ls -A lists all entries except ./..; if its output is zero-length (-z), the directory is empty.
      echo "Moved directory to garbage: ${variant_base_dir}/${sample}/"
      rmdir "${variant_base_dir}/${sample}/" 
    else
      echo "Directory is not empty and will not be deleted! ${variant_base_dir}/${sample}/"
      continue
    fi
  else
    echo "No batch has been processed for this sample"
  fi

done


path_to_samples_tsv="${clusterdir_old}/${variant}/${working}/samples.tsv"
backup_samples_tsv="${garbage_dir}/${batch}_backup_samples.tsv"

if [[ ! -f "${path_to_samples_tsv}" ]]; then
  echo "ERROR: File ${path_to_samples_tsv} not found!" >&2
  exit 1
fi

echo "claining sample.tsv file: path_to_samples_tsv=${path_to_samples_tsv} "

mv "${path_to_samples_tsv}" "${backup_samples_tsv}"
awk -v batch="$batch" -F'\t' '$2 != batch' "${backup_samples_tsv}" > "${path_to_samples_tsv}"

