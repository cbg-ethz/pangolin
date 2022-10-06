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
elif [[ $output =~ ^(RUNNING|PENDING|COMPLETING|CONFIGURING|SUSPENDED).* ]]
then
  echo running
else
  echo failed
fi
