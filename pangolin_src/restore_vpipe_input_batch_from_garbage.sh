#!/bin/bash
set -euo pipefail

readonly dir=/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src
. "${dir}/config/server.conf"
. "${dir}/config/fgcz.conf"

readonly batch="20260325_2531482360"
readonly logfile="/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src/20260409_restore_batches_input.log"

exec >>"${logfile}" 2>&1

echo "==== Starting $(date '+%Y-%m-%d %H:%M:%S') batch=${batch} ===="

vpipe_input_dir="${clusterdir_old}/${clusterdir}/vpipe_input"
garbage_dir="${vpipe_input_dir}/garbage"

projects_tsv="${vpipe_input_dir}/projects.${batch}.tsv"
garbage_projects_tsv="${garbage_dir}/projects.${batch}.tsv"

if [[ -f "${projects_tsv}" ]]; then
  sample_list_file="${projects_tsv}"
elif [[ -f "${garbage_projects_tsv}" ]]; then
  sample_list_file="${garbage_projects_tsv}"
else
  echo "ERROR: neither ${projects_tsv} nor ${garbage_projects_tsv} exists"
  exit 1
fi

echo "Restoring batch: ${batch}"
echo "Using sample list: ${sample_list_file}"

mapfile -t samples_from_batch < <(cut -f1 "${sample_list_file}")

for sample in "${samples_from_batch[@]}"; do
  src="${garbage_dir}/${sample}/${batch}"
  dest_parent="${vpipe_input_dir}/${sample}"
  dest="${dest_parent}/${batch}"

  echo "Processing sample: ${sample}"

  if [[ ! -d "${src}" ]]; then
    echo "No garbaged batch directory found for ${sample}: ${src}"
    continue
  fi

  mkdir -p "${dest_parent}"

  if [[ -e "${dest}" ]]; then
    echo "ERROR: destination already exists: ${dest}"
    exit 1
  fi

  echo "Moving ${src} -> ${dest_parent}/"
  mv "${src}" "${dest_parent}/"

  if [[ -d "${garbage_dir}/${sample}" ]] && [[ -z "$(ls -A "${garbage_dir}/${sample}")" ]]; then
    echo "Removing empty garbage directory ${garbage_dir}/${sample}"
    rmdir "${garbage_dir}/${sample}"
  fi
done

for meta_file in \
  "batch.${batch}.yaml" \
  "samples.${batch}.tsv" \
  "missing.${batch}.txt" \
  "projects.${batch}.tsv"
do
  if [[ -e "${garbage_dir}/${meta_file}" ]]; then
    if [[ -e "${vpipe_input_dir}/${meta_file}" ]]; then
      echo "ERROR: destination metadata file already exists: ${vpipe_input_dir}/${meta_file}"
      exit 1
    fi
    echo "Moving metadata ${garbage_dir}/${meta_file} -> ${vpipe_input_dir}/"
    mv "${garbage_dir}/${meta_file}" "${vpipe_input_dir}/"
  fi
done

echo "Restore complete for batch ${batch}"
echo "==== Finished $(date '+%Y-%m-%d %H:%M:%S') batch=${batch} ===="
