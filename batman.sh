#!/bin/bash

clusterdir=/cluster/work/bewi/pangolin
working=working-dev
sampleset=sampleset

RXJOB="Job\ \<([[:digit:]]+)\>\ is\ submitted"
# Generic job.
# Job <129052039> is submitted to queue <light.5d>.

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
		# start first job
		if [[ "$(bsub < vpipe-no-shorah.bsub)" =~ ${RXJOB} ]]; then
			mainjob=${BASH_REMATCH[1]}
			# schedule a gatherqa no mater what happens
			[[ "$(bsub -w "ended(${mainjob})"  < gatherqa)" =~ ${RXJOB} ]] && qamainjob=${BASH_REMATCH[1]}
			# if no fail schedule a full job with snv
			if [[ "$(bsub -w "done(${mainjob})" -ti < test.bsub)"  =~ ${RXJOB} ]]; then
				snvjob=${BASH_REMATCH[1]}
				# schedulte a gatherqa no matter what happens
				[[ "$(bsub -w "ended(${snvjob})"  < gatherqa)" =~ ${RXJOB} ]] && qasnvjob=${BASH_REMATCH[1]}
				# schedule a hugemem job if snvjob failed
# 				if [[ "$(bsub -w "exited(${snvjob})" -ti < vpipe-hugemem.bsub)" =~ ${RXJOB} ]]; then
# 					hugememjob=${BASH_REMATCH[1]}
# 					# schedule a qa afterward
# 					[[ "$(bsub -w "exited(${snvjob})&&ended(${hugememjob})" -ti  < gatherqa)" =~ ${RXJOB} ]] && qahugememjob=${BASH_REMATCH[1]}
# 				fi
			fi
		fi
	;;
esac
