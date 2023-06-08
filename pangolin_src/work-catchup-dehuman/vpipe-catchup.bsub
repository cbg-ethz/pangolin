#!/bin/bash
#BSUB -L /bin/bash
#BSUB -J CATCHUP-vpipe
#BSUB -u "ivan.topolsky@bsse.ethz.ch" # carrara@nexus.ethz.ch" # pelin.icer@bsse.ethz.ch david.dreifuss@bsse.ethz.ch" # kim.jablonski@bsse.ethz.ch louis.duplessis@bsse.ethz.ch" # sarah.nadeau@bsse.ethz.ch chaoran.chen@bsse.ethz.ch
#BSUB -N
#BSUB -M 16384
#BSUB -R rusage[mem=16384]
#BSUB -R light
##### -q light.5d
#BSUB -W 23:0
##### -W 72:0

umask 0007

# unlock if crashed before finishing
./vpipe --dryrun --unlock



# update the shared snake envs (with proxy when not on a login node)

# proxy so update can work
echo "Using proxy"
. /etc/profile.d/software_stack_default.sh
module load eth_proxy
echo "${https_proxy}"

#./vpipe --conda-create-envs-only -j 1 "$@"


mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=$(realpath ../profiles/)
#exec ./vpipe --cluster "$cluster" -j 120  --latency-wait 240 --keep-going --rerun-incomplete --use-conda  all coverage --omit-from snv
#exec ./vpipe --cluster "$cluster" -j 120  --latency-wait 240 --keep-going --rerun-incomplete --use-conda  --notemp --keep-incomplete samples/35970056/20220204_HYFH3BGXK/raw_uploads/dehuman.cram
exec ./vpipe --profile ${SNAKEMAKE_PROFILE}/smk-simple-slurm/ --until dehuman prepare_upload

