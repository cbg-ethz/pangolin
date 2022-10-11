#!/bin/bash
#SBATCH --job-name="COVID-vpipe"
#SBATCH --mail-user="ivan.topolsky@bsse.ethz.ch"
#SBATCH --mail-type=END
#SBATCH --mem-per-cpu=16384
####### --partition=light
#SBATCH --time=23:00:00

umask 0007

mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=$(realpath ../profiles/)
exec ./vpipe --profile ${SNAKEMAKE_PROFILE}/custom-lsf/ --configfile config.snv.yaml
