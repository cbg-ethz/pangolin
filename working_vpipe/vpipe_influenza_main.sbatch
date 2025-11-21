#!/bin/bash
#SBATCH --job-name=flu_main_illumina
#SBATCH --time=72:00:00

echo "Starting main influenza A Illumina vpipe job with ID $SLURM_JOB_ID"

# Array to store child job IDs
child_jobs=()
failure_detected=0

# Submit child jobs
cd /cluster/project/pangolin/influenza_pipeline/IA_H1/working/
job_id=$(sbatch  /cluster/project/pangolin/influenza_pipeline/IA_H1/working/vpipe_influenza.sbatch | awk '{print $NF}')
echo "Submitted child IA_H1 job $i with ID $job_id"
child_jobs+=($job_id)
cd /cluster/project/pangolin/influenza_pipeline/IA_H3/working/
job_id=$(sbatch  /cluster/project/pangolin/influenza_pipeline/IA_H3/working/vpipe_influenza.sbatch | awk '{print $NF}')
echo "Submitted child IA_H3 job $i with ID $job_id"
cd /cluster/project/pangolin/influenza_pipeline/IA_MP/working/
child_jobs+=($job_id)
job_id=$(sbatch  /cluster/project/pangolin/influenza_pipeline/IA_MP/working/vpipe_influenza.sbatch | awk '{print $NF}')
echo "Submitted child IA_MP job $i with ID $job_id"
child_jobs+=($job_id)
cd /cluster/project/pangolin/influenza_pipeline/IA_N1/working/
job_id=$(sbatch  /cluster/project/pangolin/influenza_pipeline/IA_N1/working/vpipe_influenza.sbatch | awk '{print $NF}')
echo "Submitted child IA_N1 job $i with ID $job_id"
child_jobs+=($job_id)
cd /cluster/project/pangolin/influenza_pipeline/IA_N2/working/
job_id=$(sbatch  /cluster/project/pangolin/influenza_pipeline/IA_N2/working/vpipe_influenza.sbatch | awk '{print $NF}')
echo "Submitted child IA_N2 job $i with ID $job_id"
child_jobs+=($job_id)

# Wait for all child jobs to finish and check their status
for job_id in "${child_jobs[@]}"; do
    echo "Waiting for child job $job_id to finish..."
    while squeue -j "$job_id" > /dev/null 2>&1; do
        sleep 10
    done

    # Check exit status of the child job
    job_status=$(sacct -j "$job_id" --format=JobID,State -n | grep "$job_id" | awk '{print $2}')
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
