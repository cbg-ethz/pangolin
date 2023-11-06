#!/bin/bash

clusterdir=/cluster/project/pangolin
status=${clusterdir}/status
working=working
sampleset=sampleset
vilocadir=work-viloca/SARS-CoV-2-wastewater-sample-processing-VILOCA
uploaderdir=work-uploader/

#
# Input validator
#
validateBatchName() {
        if [[ "$1" =~ ^(20[0-9][0-9][0-1][0-9][0-3][0-9]_[[:alnum:]-]{4,})$ ]]; then
                return;
        else
                echo "bad batchname ${1}"
                exit 1;
        fi
}

validateTags() {
        local IFS="$1"
        for b in $2; do
                validateBatchName "${b}"
        done
}

#
# sync helper
#
checksyncoutput() {
    local new="${status}/sync${1}_new"
    local last="${status}/sync${1}_last"

    if [[ "${2}" =~ Total:\ +([[:digit:]]+)\ +directories,\ +([[:digit:]]+)\ +files,.*?New:\ +([[:digit:]]+)\ +files, ]]; then
        echo "Newfiles downloaded"
        echo -e "${BASH_REMATCH[2]}\n${BASH_REMATCH[1]}" > ${last}
        flock -x -o ${last} -c "sleep 1"
        echo "${BASH_REMATCH[3]}" > ${new}
    else
        echo "No files to sync found"
        touch ${last}
    fi 2>&1
}


RXJOB='Job <([[:digit:]]+)> is submitted'
# Generic job.
# Job <129052039> is submitted to queue <light.5d>.

now=$(date '+%Y%m%d')
lastmonth=$(date '+%Y%m' --date='-1 month')
thismonth=$(date '+%Y%m')
twoweeksago=$(date '+%Y%m%d' --date='-2 weeks')

if [[ "$1" == "--limited" ]]; then
        shift
        case "$1" in
                rsync|df)
                        # sub-commands allowed in limited mode.
                ;;
                *)
                        echo "sub-command ${1} not allowed in limited mode" >&2
                        exit 2
                ;;
        esac
fi

case "$1" in
        rsync)
                # rsync daemon : see ${SSH_ORIGINAL_COMMAND}
                rsync --server --daemon .
        ;;
        logrotate)
                # rotate logs
                ~/log/rotate
        ;;
        addsamples)
                lst="${clusterdir}/${working}/samples.tsv"
                case "$2" in
                        --recent)
                                lst="${clusterdir}/${working}/samples.recent.tsv"
                                echo "syncing recent: ${lastmonth}, ${thismonth}"
                        ;;
                        *)
                                echo "Unkown parameter ${2}" > /dev/stderr
                                exit 2
                        ;;
                esac
                mkdir -p --mode=2770 "${clusterdir}/${working}/samples/"
                #cp -vrf --link ${clusterdir}/${sampleset}/*/ ${clusterdir}/${working}/samples/   ## failure: "no rule to create {SAMPLE}/extract/R1.fastq"
                cat ${clusterdir}/${sampleset}/samples.{${lastmonth},${thismonth}}*.tsv | sort -u > "${clusterdir}/${working}/samples.recent.tsv"
                sort -u ${clusterdir}/${sampleset}/samples.*.tsv > "${clusterdir}/${working}/samples.tsv"
                cut -f1 "${lst}" | xargs -P 8 -i cp -vrf --link "${clusterdir}/${sampleset}/{}/" "${clusterdir}/${working}/samples/"
        ;;
        vpipe)
                declare -A job
                list=('seq' 'seqqa' 'snv' 'snvqa' 'hugemem' 'hugememqa')
                shorah=1
                hold=
                tag=
                while [[ -n $2 ]]; do
                        case "$2" in
                                --no-shorah)
                                        shorah=0
                                ;;
                                --hold)
                                        hold='-H'
                                ;;
                                --tag)
                                        shift
                                        if [[ ! "${2}" =~ ^[[:alnum:]]+$ ]]; then
                                                # if it's not just letters and number, test if it is a list of valid batches
                                                validateTags ';' "$2"
                                        fi
                                        tag="${2%;}"
                                ;;
                                 --recent)
#                                        # TODO switch between full cohort and only recent
#                                         #recent="..."
                                 ;;
                                *)
                                        echo "Unkown parameter ${2}" > /dev/stderr
                                        exit 2
                                ;;
                        esac
                        shift
                done
                # start first job
                cd ${clusterdir}/${working}/
                # use -H to put on hold for analysis
                if [[ "$(sed "s/@TAG@/<${tag}>/g" vpipe-no-shorah.bsub | bsub -J "COVID-vpipe-<${tag}>-cons" ${hold})" =~ ${RXJOB} ]]; then
                        job['seq']=${BASH_REMATCH[1]}
                        # schedule a gatherqa no mater what happens
                        [[ "$(sed "s/@TAG@/<${tag}>/g" qa-launcher | bsub -J "COVID-vpipe-<${tag}>-qa" ${hold} -w "ended(${job['seq']})")" =~ ${RXJOB} ]] && job['seqqa']=${BASH_REMATCH[1]}
                        # if no fail schedule a full job with snv
                        if (( shorah )) && [[ "$(bsub ${hold} -w "done(${job['seq']})" -ti < vpipe.bsub)"  =~ ${RXJOB} ]]; then
                                job['snv']=${BASH_REMATCH[1]}
                                # schedule a gatherqa no matter what happens to snv
                                [[ "$(bsub ${hold} -w "done(${job['seq']})&&ended(${job['snv']})"  < qa-launcher)" =~ ${RXJOB} ]] && job['snvqa']=${BASH_REMATCH[1]}
                                # schedule a hugemem job if snvjob failed
                                if [[ "$(bsub ${hold} -w "done(${job['seq']})&&exit(${job['snv']})" -ti < vpipe-hugemem.bsub)" =~ ${RXJOB} ]]; then
                                        job['hugemem']=${BASH_REMATCH[1]}
                                        # schedule a qa afterward
                                        [[ "$(bsub -w "done(${job['seq']})&&exit(${job['snv']})&&ended(${job['hugemem']})" -ti  < qa-launcher)" =~ ${RXJOB} ]] && job['hugememqa']=${BASH_REMATCH[1]}
                                fi
                        fi
                fi >&2
                # write job chain list
                for v in "${list[@]}"; do
                        printf "%s\t%s\n" "${v}" "${job[$v]}"
                done
        ;;
        job)
                if [[ $2 =~ ^([[:digit:]]+)$ ]]; then
                        bjobs $2 | gawk -v I=$2 '$1==I{print $3}'
                else
                        bjobs
                fi
        ;;
        purgelogs)
                find ${clusterdir}/${working}/cluster_logs/ -type f -mtime +28 -name '*.log' -print0 | xargs -0 rm --
        ;;
        scratch)
                temp_scratch="${SCRATCH}/pangolin/temp"
                olderthan=60
                purge=0
                loop=0
                filter=
                while [[ -n $2 ]]; do
                        case "$2" in
                                --minutes-ago)
                                        if [[ ! "${3}" =~ ^[[:digit:]]+$ ]]; then
                                                echo "parameter of ${2} must be a number of minutes (digits only), got <${3}> instead" > /dev/stderr
                                                exit 2
                                        fi
                                        shift
                                        olderthan=$2
                                ;;
                                --loop)
                                        loop=1
                                ;&
                                --purge)
                                        purge=1
                                ;;
                                *)
                                        echo "Unkown parameter ${2}" > /dev/stderr
                                        exit 2
                                ;;
                        esac
                        shift
                done

                if (( purge )); then
                        echo "purging in ${temp_scratch}..."
                else
                        echo "listing in ${temp_scratch}..."
                fi

                count_all=0
                count_old=0
                while read s; do
                        (( ++count_all ))
                        if [[ -r "${clusterdir}/${working}/samples/${s}/upload_prepared.touch" &&  $(find "${clusterdir}/${working}/samples/${s}/upload_prepared.touch" '!' -newermt "${olderthan} minutes ago") ]]; then
                                (( ++count_old ))
                                if (( purge )); then
                                        rm -rvf  "${temp_scratch}/samples/${s}"
                                else
                                        echo "${s}";
                                fi
                        fi;
                done < <((cd "${temp_scratch}/" && find samples/ -type f ${filter} ) | grep -oP '(?<=samples/)[^/]+/[^/]+(?=/)' | sort -u) | tee /dev/stderr | wc -l  2>&1
                echo "Samples: ${count_old} old / ${count_all} total"

                if (( loop )); then
                        echo -e '\n\e[38;5;45;1mYou just keep on trying\e[0m\n\e[38;5;208;1mTill you run out of cake\e[0m'
                        if sleep "$(( 5 + olderthan))m"; then
                                # loop if no breaks
                                exec "${0}" scratch --minutes-ago "${olderthan}" --loop
                        fi
                        echo "I'm not even angry"
                fi
        ;;
        completion)
                if [[ $2 =~ ^([[:digit:]]+)$ ]]; then
                        bpeek $2 | gawk '$0~/^\[.*\]$/{date=$0};$0~/^[[:digit:]]+ of [[:digit:]]+ steps \([[:digit:]]+%\) done$/{print $0 "\t" date}'
                fi
        ;;
        df)
                #df ${clusterdir} ${SCRATCH}
                lquota -2 ${clusterdir}
                lquota -2 ${SCRATCH}
        ;;
        garbage)
                validateBatchName "$2"
                cd ${clusterdir}

                for f in ${sampleset}/*/${2}; do
                        garbage=$(dirname "${f//${sampleset}/garbage}")
                        mkdir --mode=0770 -p "${garbage}"
                        mv -v "${f%/}" "${garbage}/"
                done
                for f in ${working}/samples/*/${2}/; do
                        garbage="${f//${working}\/samples/garbage}"
                        mkdir --mode=0770 -p "${garbage%/}/"{raw_data,extracted_data}/
                        mv -vf "${f%/}/raw_data/"* "${garbage%/}/raw_data/"
                        rm "${f%/}/raw_data/"*.fa*
                        rmdir "${f%/}/raw_data/"
                        mv -vf "${f%/}/extracted_data/"* "${garbage%/}/extracted_data/"
                        rm "${f%/}/extracted_data/"*{.log,.benchmark,_fastqc.html}
                        rmdir "${f%/}/extracted_data/"
                        mv -vf "${f%/}/"* "${garbage%/}/"
                        rmdir "${f%/}"
                done
                mv "${sampleset}/batch.${2}.yaml" "${sampleset}/samples.${2}.tsv" "${sampleset}/missing.${2}.txt" "${sampleset}/projects.${2}.tsv" garbage/
        ;;
	viloca)
		cd ${clusterdir}/${vilocadir}/
		. ${clusterdir}/miniconda3/bin/activate 'base'
		. run_workflow.sh
		# write job chain list
		for v in "${list[@]}"; do
			printf "%s\t%s\n" "${v}" "${job[$v]}"
		done
	;;
	unlock_viloca)
		cd ${clusterdir}/${vilocadir}/
		. ${clusterdir}/miniconda3/bin/activate 'base'
		snakemake --unlock
	;;
	archive_viloca_run)
		validateBatchName $2
		cd ${clusterdir}/work-viloca/
		if [ ! -d results_archive ]; then
			mkdir results_archive
		fi
		mkdir "results_archive/${2}"
		mv "${clusterdir}/${vilocadir}/results/*" "${clusterdir}/work-viloca/"
	;;
	sync_fgcz)
		bfabricdir=${clusterdir}/bfabric-downloads
		cd ${bfabricdir}
		sync_fgcz_statusdir=${status}/sync
		mkdir -p $sync_fgcz_statusdir
		fgcz_config=${bfabricdir}/config

		echo "Sync FGCZ - bfabric"
		. ${clusterdir}/miniconda3/bin/activate 'base'
		. <(grep '^projlist=' ${fgcz_config}/fgcz.conf)
		if [[ "${2}" = "--recent" ]]; then
			limitlast='3 weeks ago'
			${clusterdir}/exclude_list_bfabric.py -c ${fgcz_config}/fgcz.conf -r "${twoweeksago}" -o ${sync_fgcz_statusdir}/fgcz.exclude.lst
			param=( '-e' "${sync_fgcz_statusdir}/fgcz.exclude.lst" "${projlist[@]}" )
			echo -ne "syncing recent: ${limitlast}\texcluding: "
			wc -l ${sync_fgcz_statusdir}/fgcz.exclude.lst
		else
			param=( "${projlist[@]}" )
		fi
		syncoutput="$(${clusterdir}/sync_sftp.sh -c config/fgcz.conf ${limitlast:+ -N "${limitlast}"} "${param[@]}"|tee /dev/stderr)"
		checksyncoutput "fgcz" "$syncoutput"
		mamba deactivate
	;;
	sortsamples)
		. ${clusterdir}/miniconda3/bin/activate pybis
		cd ${clusterdir}
                sortsamples_statusdir=${status}/sortsamples
		mkdir -p $sortsamples_statusdir
		summary=""
		recent=""
		shrtrecent=""
		force="${sort_force}"
		while [[ -n $2 ]]; do
			case "$2" in
				--summary)
					summary='--summary'
				;;
				--force)
					force='--force'
				;;
				--recent)
					recent="--recent=${lastmonth}"
					shrtrecent="-r ${lastmonth}"
				;;
				*)
					echo "Unkown parameter ${2}" > /dev/stderr
					exit 2
				;;
			esac
			shift
		done
		fail=0
		if  (( ${lab[gfb]} )); then
			${clusterdir}/sort_samples_pybis.py -c ${clusterdir}/config/gfb.conf --protocols=${clusterdir}/${working}/${protocolyaml} --assume-same-protocol ${force} ${summary} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
		else
			echo "Skipping gfb"
		fi
		if  (( ${lab[fgcz]} )); then
			. <(grep '^google_sheet_patches=' ${clusterdir}/config/fgcz.conf)
 
			(( google_sheet_patches )) && ${clusterdir}/google_sheet_patches.py
 			${clusterdir}/sort_samples_bfabric_tsv.py -c ${clusterdir}/config/fgcz.conf --no-fastqc --protocols=${clusterdir}/${working}/${protocolyaml}  --libkit-override=${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${clusterdir}/movedatafiles.sh || fail=1
		else
			echo "Skipping fgcz"
		fi
		if  (( ${lab[h2030]} )) && [[ -e ${clusterdir}/synch2030_ended && -e ${clusterdir}/synch2030_started && ${clusterdir}/synch2030_ended -nt ${clusterdir}/synch2030_started ]]; then
			# NOTE always recent/based on last sync), no support for --force, move done immediately/no separate movedatafiles.sh
			# TODO support for protocols
			${clusterdir}/sort_h2030 -c ${clusterdir}/config/h2030.conf $(< ${clusterdir}/synch2030_started ) || fail=1
		else
			echo "Skipping h2030"
		fi
		if  (( ${lab[viollier]} )); then
			# NOTE always --force, short options only
			# HACK hardcoded paths due to multiple directories
			${clusterdir}/sort_viollier -c ${clusterdir}/config/viollier.conf -4 ${clusterdir}/${working}/${protocolyaml} ${shrtrecent} sftp-viollier/raw_sequences/*/ && bash ${clusterdir}/$movedatafiles.sh || fail=1
		else
			echo "Skipping viollier"
		fi
		(( fail == 0 )) &&  touch ${sortsamples_statusdir}/sortsamples_success || touch ${sortsamples_statusdir}/sortsamples_fail
		conda deactivate
	;;
        scanmissingsamples)
                sample_list=$2
                while read sample batch other; do
                        # look for only guaranteed samples
                        [[ $sample =~ $rxsample ]] || continue
                        # check the presence of fasta on each sample
                        echo ls ${clusterdir}/${working}/samples/${sample}/${batch}
                        ls ${clusterdir}/${working}/samples/${sample}/${batch}
                        if [[ -e ${clusterdir}/${working}/samples/${sample}/${batch}/upload_prepared.touch ]]; then
                            # this will check for:
                            #  - references/ref_majority.fasta
                            #  - references/consensus.bcftools.fasta & .chain
                            #  - references/frameshift_deletions_check.tsv
                            #  etc.
                            #  see V-pipe's rule 'prepare_upload' in publish.smk
                            echo -n '.'
                        else
                            echo -e "\r+${batch/_/:}\t!${sample}\e[K"
                            true
                            return 0
                        fi;
                done < $1
                false
        ;;
        listsampleset)
                ls ${clusterdir}/${sampleset}/samples.20*.tsv
        ;;
                *)
                echo "Unkown sub-command ${1}" > /dev/stderr
                exit 2
        ;;
esac
