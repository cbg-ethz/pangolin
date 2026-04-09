#!/bin/bash
#SBATCH --job-name="LOLLIPOP"
#SBATCH --mail-user="carrara@nexus.ethz.ch kyra@nexus.ethz.ch" 
#SBATCH --mail-type=END
#SBATCH --mem-per-cpu=16384
#SBATCH --oversubscribe
#SBATCH --time=72:00:00
######  --time=72:00:00

umask 0007

# unlock if crashed before finishing
./vpipe --dryrun --unlock



# update the shared snake envs (with proxy when not on a login node)

# proxy so update can work
echo "Using proxy"
#. /etc/profile.d/software_stack_default.sh
module load eth_proxy
echo "${https_proxy}"

#./vpipe --conda-create-envs-only -j 1 "$@"


mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=/cluster/project/pangolin/processes/sars_cov_2/pangolin/profiles/smk-simple-slurm
exec ./vpipe --profile ${SNAKEMAKE_PROFILE} --restart-times=0 \
	tallymut deconvolution \
	--groups sigmut=group0 cooc=group1 \
        --group-components group0=10 group1=5

#	allCooc variants/cohort_cooc_report.v542.csv tallymut deconvolution \


#allCooc tallymut deconvolution \

#TSV=samples.wastewateronly.v41.tsv
# samples.basel.proto.tsv

#exec ./vpipe --profile ${SNAKEMAKE_PROFILE}/smk-simple-slurm/ --restart-times=0 \
#	$(gawk '{printf("results/%s/%s/signatures/cooc.yaml\n",$1,$2)}' ${TSV})


#	$(gawk '{printf("results/%s/%s/references/consensus.bcftools.fasta\n",$1,$2)}' samples.basel.proto.tsv)	\
#	$(gawk '{printf("results/%s/%s/alignments/REF_aln_stats.yaml\n",$1,$2)}' samples.basel.proto.tsv)
#exec ./vpipe --cluster "$cluster" -j 120  --latency-wait 240 --keep-going --rerun-incomplete --use-conda $(gawk '{printf("results/%s/%s/alignments/REF_aln_trim.bam\n",$1,$2)}' samples.basel.proto.tsv)
#exec ./vpipe --cluster "$cluster" -j 120  --latency-wait 240 --keep-going --rerun-incomplete --use-conda results/Ba210463_2021-11-26/20211220_HV7LHDRXY/{references/consensus.bcftools.fasta,alignments/REF_aln_stats.yaml}

