#!/bin/bash
#SBATCH --job-name="FLUMP-vpipe-aviti"
#SBATCH --mail-user=""
#SBATCH --mail-type=END
#SBATCH --mem-per-cpu=16384
#SBATCH --oversubscribe
#SBATCH --time=3:00:00

umask 0007

prefix="/cluster/project/pangolin/processes/influenza/pangolin/working_vpipe"
profile_prefix="/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src/profiles"

# unlock if crashed before finishing
${prefix}/vpipe --dryrun --unlock --configfile ${prefix}/vpipe_influenza_MP_aviti.yaml

# update the shared snake envs (with proxy when not on a login node)

# proxy so update can work
echo "Using proxy"
#. /etc/profile.d/software_stack_default.sh
module load eth_proxy
echo "${https_proxy}"

mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=$(realpath ${profile_prefix}/smk-simple-slurm/ )
exec ${prefix}/vpipe --profile ${SNAKEMAKE_PROFILE}     \
	--configfile vpipe_influenza_MP_aviti.yaml
