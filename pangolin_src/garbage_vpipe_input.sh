#!/bin/bash
set -euo pipefail


# Script to garbage vpipe_outputs. Remember to blacklist them from vpipe run before running the garbage.sh script.
# Input: Virus subtype e.g. IA_H1
# Infput: Batch e.g. 20250417_2427493980

dir=/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src
. ${dir}/config/server.conf
. ${dir}/config/fgcz.conf

# defaults, in case flags aren’t passed
variant=""
batch=""

# parse flags
while [[ $# -gt 0 ]]; do #$# is the count of remaining arguments; as long as it’s > 0 we loop.
  case "$1" in
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
if [[ -z "$batch" ]]; then
  echo "Usage: $0 --batch <id>" >&2
  exit 1
fi

echo "Batch is: $batch"

vpipe_input_dir="${clusterdir_old}/${clusterdir}/vpipe_input" 

cd $vpipe_input_dir
garbage_dir="${vpipe_input_dir}/garbage"
mkdir -p "$garbage_dir"

sampleset_file="projects.${batch}.tsv"

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
  if [[ -d "${vpipe_input_dir}/${sample}/${batch}" ]]; then 
    if [[ -e "${garbage_dir}/${sample}/" ]]; then
      mv "${garbage_dir}/${sample}/" "${garbage_dir}/${sample}.bak.$(date +%Y%m%d%H%M%S)"
    fi
    mv "${vpipe_input_dir}/${sample}/${batch}" "${garbage_dir}/${sample}/"

    #now check if the sample has another batch directory inside; if not delete sample folder
    if [[ -d "${vpipe_input_dir}/${sample}/" && -z $(ls -A "${vpipe_input_dir}/${sample}/") ]]; then #-d "$dir" ensures it actually exists and is a directory.]ls -A lists all entries except ./..; if its output is zero-length (-z), the directory is empty.
      echo "Moved directory to garbage: ${vpipe_input_dir}/${sample}/"
      rmdir "${vpipe_input_dir}/${sample}/" 
    else
      echo "Directory is not empty and will not be deleted! ${vpipe_input_dir}/${sample}/"
      continue
    fi
  else
    echo "No batch has been processed for this sample"
  fi

done

# Move batch metadata files into garbage so addsamples cannot recreate them
for meta_file in \
  "${vpipe_input_dir}/batch.${batch}.yaml" \
  "${vpipe_input_dir}/samples.${batch}.tsv" \
  "${vpipe_input_dir}/missing.${batch}.txt" \
  "${vpipe_input_dir}/projects.${batch}.tsv"
do
  if [[ -e "${meta_file}" ]]; then
    mv "${meta_file}" "${garbage_dir}/"
    echo "Moved metadata file to garbage: ${meta_file}"
  else
    echo "Metadata file not found, skipping: ${meta_file}"
  fi
done


path_to_samples_tsv="${clusterdir_old}/${clusterdir}/${working}/samples.tsv"
backup_samples_tsv="${garbage_dir}/${batch}_backup_samples.tsv"

if [[ ! -f "${path_to_samples_tsv}" ]]; then
  echo "ERROR: File ${path_to_samples_tsv} not found!" >&2
  exit 1
fi

echo "claining sample.tsv file: path_to_samples_tsv=${path_to_samples_tsv} "

mv "${path_to_samples_tsv}" "${backup_samples_tsv}"
awk -v batch="$batch" -F'\t' '$2 != batch' "${backup_samples_tsv}" > "${path_to_samples_tsv}"

path_to_recent_samples_tsv="${clusterdir_old}/${clusterdir}/${variant}/${working}/samples.recent.tsv"
backup_recent_samples_tsv="${garbage_dir}/${batch}_backup_samples.recent.tsv"

if [[ ! -f "${path_to_recent_samples_tsv}" ]]; then
  echo "ERROR: File ${path_to_recent_samples_tsv} not found!" >&2
  exit 1
fi
echo "claining recent.sample.tsv file: path_to_recent_samples_tsv=${path_to_recent_samples_tsv} "

mv "${path_to_recent_samples_tsv}" "${backup_recent_samples_tsv}"
awk -v batch="$batch" -F'\t' '$2 != batch' "${backup_recent_samples_tsv}" > "${path_to_recent_samples_tsv}"


#cleanup mutation frequency table
influenza_subtypes_list=(IA_H1 IA_H3 IA_N1 IA_N2)

for iva_subtype in "${influenza_subtypes_list[@]}"; do
  subtype_seg="${iva_subtype#IA_}"
  mutation_file_path="/cluster/project/pangolin/processes/influenza/${iva_subtype}/working/mutation_frequencies/${batch}_${subtype_seg}_Mutations_Dashboard.tsv"
  base_mutation_file_path="/cluster/project/pangolin/processes/influenza/${iva_subtype}/working/mutation_frequencies"

  if [[ ! -f "${mutation_file_path}" ]]; then
    echo "ERROR: File ${mutation_file_path} not found!" >&2
    #exit 1 #tollerate this error as often the file not yet exists
  else
    mv "$mutation_file_path" "${base_mutation_file_path}/old/"
    echo "moved ${mutation_file_path} to old"
  fi

done