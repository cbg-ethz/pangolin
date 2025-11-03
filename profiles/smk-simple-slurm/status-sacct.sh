#!/usr/bin/env bash

# Check status of Slurm job

jobid="$1"

if [[ "$jobid" == Submitted ]]
then
  echo smk-simple-slurm: Invalid job ID: "$jobid" >&2
  echo smk-simple-slurm: Did you remember to add the flag --parsable to your sbatch call? >&2
  exit 1
fi

read output other < <(sacct -j "$jobid" --format State --noheader)

if [[ $output =~ ^(COMPLETED).* ]]
then
  echo success
elif [[ $output =~ ^(RUNNING|PENDING|COMPLETING|CONFIGURING|SUSPENDED).* || -z "$output" ]]
# HACK: if sacct has crashed (e.g. failure to connect to slurmdb) and doesn't return any output, consider the jobs as still running
then
  echo running
else
  echo failed
  echo "failure reason: ${output}" >&2
fi

# CD  COMPLETED       Job has terminated all processes on all nodes with an exit code of zero.

# BF  BOOT_FAIL       Job terminated due to launch failure, typically due to a hardware failure (e.g. unable to boot the node or block and the job can not be requeued).
# CA  CANCELLED       Job was explicitly cancelled by the user or system administrator.  The job may or may not have been initiated.
# DL  DEADLINE        Job terminated on deadline.
# F   FAILED          Job terminated with non-zero exit code or other failure condition.
# NF  NODE_FAIL       Job terminated due to failure of one or more allocated nodes.
# OOM OUT_OF_MEMORY   Job experienced out of memory error.
# TO  TIMEOUT         Job terminated upon reaching its time limit.
# PR  PREEMPTED       Job terminated due to preemption.
# RQ  REQUEUED        Job was requeued.
 # RS  RESIZING        Job is about to change size.
# RV  REVOKED         Sibling was removed from cluster due to other cluster starting the job.

# PD  PENDING         Job is awaiting resource allocation.
# R   RUNNING         Job currently has an allocation.
# S   SUSPENDED       Job has an allocation, but execution has been suspended and CPUs have been released for other jobs.
