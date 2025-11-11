#!/bin/bash
#SBATCH --job-name=rsv_main_aviti
#SBATCH --time=72:00:00

echo "Starting main RSV  Aviti vpipe job with ID $SLURM_JOB_ID"

# Array to store child job IDs
child_jobs=()
failure_detected=0

# Submit child jobs
cd /cluster/project/pangolin/processes/rsv/RSVA/working/
job_id=$(sbatch  /cluster/project/pangolin/rsv/pangolin/working/vpipe_rsva_aviti.sbatch | awk '{print $NF}')
echo "Submitted child RSVA job $i with ID $job_id"
child_jobs+=($job_id)
cd /cluster/project/pangolin/processes/rsv/RSVB/working/
job_id=$(sbatch  /cluster/project/pangolin/rsv/pangolin/working/vpipe_rsvb_aviti.sbatch | awk '{print $NF}')
echo "Submitted child RSVB job $i with ID $job_id"
child_jobs+=($job_id)

# Wait for all child jobs to finish and check their status
for job_id in "${child_jobs[@]}"; do
    echo "Waiting for child job $job_id to finish..."
    while squeue -j "$job_id" > /dev/null 2>&1; do
        sleep 10
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