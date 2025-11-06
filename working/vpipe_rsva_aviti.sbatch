#!/bin/bash
#SBATCH --job-name="RSVA-vpipe-aviti"
#SBATCH --mail-user=""
#SBATCH --mail-type=END
#SBATCH --mem-per-cpu=16384
#SBATCH --oversubscribe
#SBATCH --time=24:00:00

umask 0007

# unlock if crashed before finishing
./vpipe --dryrun --unlock --configfile vpipe_rsva_aviti.yaml

# update the shared snake envs (with proxy when not on a login node)

# proxy so update can work
echo "Using proxy"
#. /etc/profile.d/software_stack_default.sh
module load eth_proxy
echo "${https_proxy}"

mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=$(realpath ../profiles/smk-simple-slurm/ )
exec ./vpipe --profile ${SNAKEMAKE_PROFILE}     \
        --configfile vpipe_rsva_aviti.yaml