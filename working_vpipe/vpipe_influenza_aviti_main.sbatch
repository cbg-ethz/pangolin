#!/bin/bash
#SBATCH --job-name=flu_main_aviti
#SBATCH --time=72:00:00

set -euo pipefail

echo "Starting main influenza A Aviti vpipe job with ID $SLURM_JOB_ID"
readonly file_path="/cluster/project/pangolin/processes/influenza/pangolin/working_vpipe"

# Array to store child job IDs
child_jobs=()
failure_detected=0

# Submit child jobs
cd /cluster/project/pangolin/processes/influenza/IA_H1/working/
job_id=$(sbatch ${file_path}/vpipe_influenza_H1_aviti.sbatch | awk '{print $NF}')
echo "Submitted child IA_H1 job with ID $job_id"
child_jobs+=($job_id)
cd /cluster/project/pangolin/processes/influenza/IA_H3/working/
job_id=$(sbatch  ${file_path}/vpipe_influenza_H3_aviti.sbatch | awk '{print $NF}')
echo "Submitted child IA_H3 job with ID $job_id"
child_jobs+=($job_id)
cd /cluster/project/pangolin/processes/influenza/IA_MP/working/
job_id=$(sbatch  ${file_path}/vpipe_influenza_MP_aviti.sbatch | awk '{print $NF}')
echo "Submitted child IA_MP job with ID $job_id"
cd /cluster/project/pangolin/processes/influenza/IA_N1/working/
child_jobs+=($job_id)
job_id=$(sbatch  ${file_path}/vpipe_influenza_N1_aviti.sbatch | awk '{print $NF}')
echo "Submitted child IA_N1 job with ID $job_id"
child_jobs+=($job_id)
cd /cluster/project/pangolin/processes/influenza/IA_N2/working/
job_id=$(sbatch  ${file_path}/vpipe_influenza_N2_aviti.sbatch | awk '{print $NF}')
echo "Submitted child IA_N2 job with ID $job_id"
child_jobs+=($job_id)

# Wait for all child jobs to finish and check their status
for job_id in "${child_jobs[@]}"; do
    echo "Waiting for child job $job_id to finish..."
    # TODO: change this logic - it is unstable
    # check the job id; once the job is finished it goes on
    #job still in queue → grep returns 0; job gone → grep returns 1
    while squeue -h -j "$job_id" | grep -q .; do
        sleep 30
    done

    # Check exit status of the child job
    job_status=$(sacct -j "$job_id" --format=JobID,State -n | grep "$job_id" | awk '{print $2}' | head -n 1)
    if [[ "$job_status" != "COMPLETED" ]]; then
        echo "Child job $job_id failed with status $job_status"
        failure_detected=1
    else
        echo "Child job $job_id completed successfully"
    fi
done

if [[ $failure_detected -eq 1 ]]; then
    echo "One or more child jobs failed. Marking parent job as failed."
    exit 1
fi

echo "All child jobs completed successfully. Parent job $SLURM_JOB_ID exiting."
exit 0
