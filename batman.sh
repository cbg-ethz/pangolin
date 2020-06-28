#!/bin/bash

clusterdir=/cluster/work/bewi/pangolin
working=working-dev
sampleset=sampleset

case "$1" in
	rsync)
		# rsync daemon : see ${SSH_ORIGINAL_COMMAND}
		rsync --server --daemon .
	;;
	addsamples)
		cp -vrf --link ${clusterdir}/${sampleset}/*_*/ ${clusterdir}/${working}/samples/   ## failure: "no rule to create {SAMPLE}/extract/R1.fastq"
		sort ${clusterdir}/${sampleset}/samples.*.tsv > ${clusterdir}/${working}/samples.tsv
	;;
	vpipe)
		phase1="$(bsub < vpipe-no-shorah.bsub)"
		# Generic job.
		# Job <129052039> is submitted to queue <light.5d>.
		if [[ "${phase1}" =~ Job\ \<([[:digit:]]+)\>\ is\ submitted ]]; then
			bsub -w "ended(${BASH_REMATCH[1]})"  < gatherqa
			bsub -w "ended(${BASH_REMATCH[1]})"  < test.bsub
		fi
	;;
esac
