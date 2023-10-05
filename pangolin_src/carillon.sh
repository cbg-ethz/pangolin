#!/bin/bash

scriptdir="$(dirname $(realpath $(which $0)))"

set -e

. ${scriptdir}/config/server.conf

: ${run_shorah:=0}
: ${staging:=1}

if [[ $(realpath $scriptdir) != $(realpath $basedir) ]]; then
    echo "The scripts are in $scriptdir"
    echo "The base working directory for the automation is $basedir"
fi

if [[ ! $mode =~ ^[0-7]{,4}$ ]]; then
    echo "Invalid characters <${mode//[0-7]/}> in <${mode}>"
    echo 'mode should be an octal chmod value, see `mkdir --help` for informations'
    mode=
fi

mkdir -p ${basedir}
# cd ${basedir}

umask 0002

statusdir="${basedir}/status"
mkdir ${mode:+--mode=${mode}} -p ${statusdir}
viloca_statusdir="${basedir}/viloca_status"
mkdir ${mode:+--mode=${mode}} -p ${viloca_statusdir}
viloca_staging=${viloca_samples}.staging
lockfile=${statusdir}/carillon_lock


touch ${statusdir}/oh_hai_im_lopping


source ${baseconda}/secrets/${cluster_user}@${cluster}
remote_batman="ssh -o StrictHostKeyChecking=no -ni ${privkey} ${cluster_user}@${cluster} --"

#
# Phase 1: periodic data sync
#

echo '========='
echo 'Data sync'
echo '========='

set -e

[[ -n $skipsync ]] && echo "${skipsync} will be skipped."


[[ $skipsync != fgcz ]] && ${scriptdir}/belfry.sh syncfgcz --recent


#
# Phase 2: update status of current run and trigger backups
#

echo "================="
echo "Check current run"
echo "================="

if [[ ( -e ${statusdir}/vpipe_started ) && ( ( ! -e ${statusdir}/vpipe_ended ) || ( ${statusdir}/vpipe_started -nt ${statusdir}/vpipe_ended ) ) ]]; then
    stillrunning=0
    echo "CHECK"
    while read j id; do
	    echo $j $id
        # skip missing
        if [[ -z "${id}" ]]; then
            echo "$j : (not started)"
            continue
        fi

        # skip already finished
        if [[ ( -e ${statusdir}/vpipe_${j}_ended ) && ( ${statusdir}/vpipe_${j}_ended -nt ${statusdir}/vpipe_started ) ]]; then
            old="$(<${statusdir}/vpipe_${j}_ended)"
            if [[ "${id}" == "${old}" ]]; then
                echo "$j : $id already finished"
            else
                echo "$j : mismatch $id vs $old"
            fi
            continue
        fi

        # cluster status
        stat=$(${remote_batman} job "${id}" || echo "(no answer)")
        if [[ ( -n "${stat}" ) && ( ! "${stat}" =~ (COMPLETED|FAILED) ) ]]; then
            # running
            echo -n "$j : $id : $stat"
            (( ++stillrunning ))
            if [[ "${stat}" == 'RUNNING' && ( ! "$j" =~ qa$ ) ]]; then
                echo -ne '\t'
                ${remote_batman} completion "${id}" | tail -n 1
            else
                echo ''
            fi
            sleep 1
            continue
        fi

        # not running
        echo "$j : $id finishing"

        case "$j" in
            seqqa)
                ${scriptdir}/belfry.sh pullsamples_noshorah --recent
                if [[ ( -e ${statusdir}/pullsamples_noshorah_fail ) && ( ${statusdir}/pullsamples_noshorah_fail -nt ${statusdir}/pullsamples_noshorah_success ) ]]; then
                    echo "pulling data failed"
                    (( ++stillrunning ))
                    continue
                fi
            ;;
        esac

        echo "${id}" > ${statusdir}/vpipe_${j}_ended
    done < ${statusdir}/vpipe_started
    echo done

    if (( stillrunning == 0 )); then
        # HACK temporarily avoid copying over ShoRAH files
        #${scriptdir}/belfry.sh pullsamples --recent
        #if [[ ( ! -e ${statusdir}/pullsamples_fail ) || ( ${statusdir}/pullsamples_success -nt ${statusdir}/pullsamples_fail ) ]]; then
        ${scriptdir}/belfry.sh pullsamples_noshorah --recent
        if [[ ( ! -e ${statusdir}/pullsamples_noshorah_fail ) || ( ${statusdir}/pullsamples_noshorah_success -nt ${statusdir}/pullsamples_noshorah_fail ) ]]; then
            echo "$(basename $(realpath ${statusdir}/vpipe_started))" > ${statusdir}/vpipe_ended
	    vpipe_enddate = $(cat ${statusdir}/vpipe_ended)
	    vpipe_enddate = ${vpipe_enddate#*.}
	    lastbatch_vpipe = $(cat ${statusdir}/vpipe_new.${vpipe_enddate} | awk '{print $1}')
            ${scriptdir}/belfry.sh queue_upload
        else
            echo "pulling data failed"
        fi
    fi
else
    echo 'No current run.'
fi



#
# Phase 3: Reports and sequences
#

echo "================"
echo "Results handling"
echo "================"

if [[ ( -e ${statusdir}/pullsamples_noshorah_success || -e ${statusdir}/pullsamples_success ) && ( ( ! -e ${statusdir}/qa_report_success ) || ( ${statusdir}/pullsamples_noshorah_success -nt ${statusdir}/qa_report_success ) || (  ${statusdir}/pullsamples_success -nt ${statusdir}/qa_report_success ) ) ]]; then
    # ${scriptdir}/belfry.sh qa_report
    :
else
    echo 'no newer results'
fi

if [[ ( -e ${statusdir}/qa_report_success ) && ( ( ! -e ${statusdir}/pushseq_success ) || ( ${statusdir}/qa_report_success -nt ${statusdir}/pushseq_success ) ) ]]; then
    echo push data to vilolier -- deactivated
    #${scriptdir}/belfry.sh pushseq
    #${scriptdir}/belfry.sh gitaddseq
else
    echo 'no upload needed'
fi



#
# Phase 4: restart runs if new data
#

echo "============="
echo "Start new run"
echo "============="

# TODO support a yaml with regex
rxsample='([[:digit:]]{2}_20[[:digit:]]{2}_[01]?[[:digit:]]_[0-3]?[[:digit:]])'

scanmissingsamples() {
    while read sample batch other; do
        # look for only guaranteed samples
        [[ $sample =~ $rxsample ]] || continue
        # check the presence of fasta on each sample
        echo ls ${cluster_mount}/${working}/samples/${sample}/${batch}
        ls ${cluster_mount}/${working}/samples/${sample}/${batch}
        if [[ -e ${cluster_mount}/${working}/samples/${sample}/${batch}/upload_prepared.touch ]]; then
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
}

# like "$*" but with a different field separator than default.
join_by() { local IFS="$1"; shift; echo "$*"; }

if [[ ( ( ! -e ${statusdir}/vpipe_ended ) && ( ! -e ${statusdir}/vpipe_started ) ) || ( ${statusdir}/vpipe_ended -nt ${statusdir}/vpipe_started ) ]]; then
    echo check missing samples
    clearline=0
    mustrun=0
    runreason=( )
    declare -A flowcell
    # if test -e ${statusdir}/vpipe_started; then
    ref=$(date --reference="${statusdir}/vpipe_started" '+%Y%m%d')
    now=$(date '+%Y%m%d')
    limit=$(date --date='2 weeks ago' '+%Y%m%d')
    echo "Check batch against ${ref}:"
    for t in ${cluster_mount}/${sampleset}/samples.20*.tsv; do
        if [[ ! $t =~ samples.([[:digit:]]{8})_([[:alnum:]]{5,}(-[[:digit:]]+)?).tsv$ ]]; then
            echo "oops: Can't parse <${t}> ?!" > /dev/stderr
        fi

        # check Duplicates
        b="${BASH_REMATCH[1]}"
        f="${BASH_REMATCH[2]}"
        if [[ -n "${flowcell[$f]}" ]]; then
            echo "error: Duplicate flowcell $f : ${flowcell[$f]} vs $b" > /dev/stderr
            exit 2
        else
            flowcell[$f]=$b
        fi

        # check dates
        if (( clearline )) && [[ "$limit" < "$b"  ]]; then
            echo -ne "\n"
            clearline=0
        fi
        if [[ "$ref" < "$b" || "$ref" == "$b" ]]; then
            echo "!$b:$f"
            (( ++mustrun ))
            runreason+=( "${b}_${f}" )
        elif [[ "$limit" < "$b"  ]] && scanmissingsamples $t; then
            (( ++mustrun ))
            runreason+=( "${b}_${f}" )
        else
	echo " " $limit $b
            if  [[ "$limit" < "$b"  ]]; then
                echo -e "\r($b:$f)\e[K"
            else
                echo -ne "($b:$f)\t"
                clearline=1
            fi
        fi
        # sanity check
        if [[ "$now" < "$b" ]]; then
            echo "oops: in the future $b vs $now"
        fi
    done
    
    echo "mustrun $mustrun"

    # are we allowed to submit jobs ?
    if (( donotsubmit )); then
        echo -e '\e[35;1mWill NOT submit jobs\e[0m...' > /dev/stderr
        if (( mustrun )); then
            echo 'submit blocked' > ${statusdir}/submit_fail
            echo -e '...\e[33;1mbut there are new jobs that should be started !!!\e[0m' > /dev/stderr
        else
            echo '...and there is nothing to run anyway' > /dev/stderr
        fi
    # start jobs ?
    elif (( mustrun )); then
        echo 'Will start new job'

        # Sanity check
        if [[ ( -e ${statusdir}/sortsamples_fail ) && ( ${statusdir}/sortsamples_fail -nt  ${statusdir}/sortsamples_success ) ]]; then
            if (( staging )); then
                echo -e '\e[33;1mwarning: sampleset data not successfully fetched yet, using staging\e[0m' > /dev/stderr
            else
                echo 'data fetch error' > ${statusdir}/submit_fail
                echo -e '\e[31;1merror: sampleset data not successfully fetched yet\e[0m' > /dev/stderr
                exit 1
            fi
        fi
        if [[ ( ! -e ${statusdir}/syncopenbis_new ) || ( ( -e ${statusdir}/vpipe_started ) && ( ${statusdir}/vpipe_started -nt ${statusdir}/syncopenbis_new ) ) ]]; then
            echo 'oops: something fishy: no downloaded data newer than last run ?' > /dev/stderr
        fi
        # point of comparison for dates:
        if [[ -e ${statusdir}/vpipe_ended ]]; then
            lastrun=${statusdir}/vpipe_ended
        else
            # find the most recent 'new' sync status
            lastsync=( $(ls -t ${statusdir}/sync*_new) )
            if [[ -e "${lastsync[0]}" ]]; then
                lastrun="${lastsync[0]}"
            else
                # last fall back: sort success
                lastrun=${statusdir}/sortsamples_success
            fi
        fi

        # push sampleset data
        if [[ ( ! -e ${statusdir}/pushsampleset_success ) || ( ${lastrun} -nt ${statusdir}/pushsampleset_success ) ]]; then
            ${scriptdir}/belfry.sh pushsampleset --recent
        else
            echo 'oops: Sampleset already pushed' > /dev/stderr
        fi

        # must run
        if [[ ( -e ${statusdir}/pushsampleset_fail ) && ( ${statusdir}/pushsampleset_fail -nt ${statusdir}/pushsampleset_success ) ]]; then
            echo 'error: Pushing sampleset did not succeed' > /dev/stderr
        else
            echo 'starting jobs'
            if (( run_shorah )); then
                shorah=""
            else
                shorah="--no-shorah"
            fi
            # ${remote_batman} addsamples --recent #   && \
            ${remote_batman} vpipe ${shorah} --recent --tag "$(join_by ';' "${runreason[@]}")" > ${statusdir}/vpipe.${now} #  &&  \
            if [[ -s ${statusdir}/vpipe.${now} ]]; then
                ln -sf ${statusdor}/vpipe.${now} ${statusdir}/vpipe_started
                cat ${statusdir}/vpipe_started
                printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${statusdir}/vpipe_new.${now}
                if [[ -n "${mailto[*]}" ]]; then
                    (
                        echo '(Possibly new) samples not having consensus sequences yet found in batches:'
                        printf ' - %s\n' "${runreason[@]}"
                        echo -e '\nStarting V-pipe on Euler:'
                        cat ${statusdir}/vpipe_started
                    ) | mail -s '[Automation-carillon] Starting V-pipe on Euler' "${mailto[@]}"
                    # -r "${mailfrom}"
                fi
            fi
        fi
    else
        echo 'No new jobs to start'

        # check for left-over .staging files
        staging_tsv=( ${basedir}/sampleset/samples.202*.tsv.staging )
        if [[ "${staging_tsv[*]}" =~ \* ]]; then
            # no staging files => safe to purge
            ${scriptdir}/belfry.sh purgeviollier
        else
            echo 'possible unsubmitted failed import?' > ${statusdir}/submit_fail
            echo -e '\e[31;1mLeft-over staging files\e[0m' > /dev/stderr
            printf ' - %s\n' "${staging_tsv[@]##*/}" > /dev/stderr
        fi

    fi
else
    echo 'There is already run going on'
fi

######## TODO: CHECK PHASE 5
#
# Phase 5: run viloca on new samples if no viloca instance is running
#
if run_viloca; then

	echo "========================"
	echo "Check current VILOCA run"
	echo "========================"


	if [[ ( -e ${viloca_statusdir}/viloca_started ) && ( ( ! -e ${viloca_statusdir}/viloca_ended ) || ( ${viloca_statusdir}/viloca_started -nt ${viloca_statusdir}/viloca_ended ) ) ]]; then
		stillrunning=0
		while read j id; do
			# skip missing
			if [[ -z "${id}" ]]; then
				echo "VILOCA - $j : (not started)"
				continue
			fi

			# skip already finished
			if [[ ( -e ${viloca_statusdir}/viloca_${j}_ended ) && ( ${viloca_statusdir}/viloca_${j}_ended -nt ${viloca_statusdir}/viloca_started ) ]]; then
				old="$(<${viloca_statusdir}/viloca_${j}_ended)"
				if [[ "${id}" == "${old}" ]]; then
					echo "VILOCA - $j : $id already finished"
				else
					echo "VILOCA - $j : mismatch $id vs $old"
				fi
				continue
			fi

			# cluster status
			stat=$(${remote_batman} job "${id}" || echo "(no answer)")
			if [[ ( -n "${stat}" ) && ( ! "${stat}" =~ (EXIT|DONE) ) ]]; then
				# running
				echo -n "VILOCA - $j : $id : $stat"
				(( ++stillrunning ))
				if [[ "${stat}" == 'RUN' && ( ! "$j" =~ qa$ ) ]]; then
					echo -ne '\t'
					${remote_batman} completion "${id}" | tail -n 1
				else
					echo ''
				fi
				sleep 1
				continue
			fi

			# not running
			echo "VILOCA - $j : $id finishing"

			echo "${id}" > ${viloca_statusdir}/viloca_${j}_ended
		done < ${viloca_statusdir}/viloca_started

		if (( stillrunning == 0 )); then
			echo "No VILOCA running. Checking if the run was successful or if it ended prematurely due to the time limit"
			if grep -rq snake.err -e "JOB.*CANCELLED.*DUE TO TIME LIMIT"; then
				echo "Previous VILOCA run cancelled due to time limit. Restarting it"
				${remote_batman} unlock_viloca && \
				${remote_batman} viloca --recent --tag "${lastbatch_vpipe}" > ${viloca_statusdir}/viloca.${now}	&&	\
				if [[ -s ${viloca_statusdir}/viloca.${now} ]]; then
					ln -sf viloca.${now} ${viloca_statusdir}/viloca_started
					cat ${viloca_statusdir}/viloca_started
					printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${viloca_statusdir}/viloca_new.${now}
					if [[ -n "${mailto[*]}" ]]; then
						(
							echo '(Possibly new) samples not having VILOCA results yet found:'
							printf ' - %s\n' "${runreason[@]}"
							echo -e '\nStarting VILOCA on Euler:'
							cat ${viloca_statusdir}/viloca_started
						) | mail -s '[Automation-carillon] Starting VILOCA on Euler' "${mailto[@]}"
						# -r "${mailfrom}"
					fi
				fi
				continue
			fi
	        echo found
	    else
	        echo not found
	    fi
		${scriptdir}/belfry pullsamples_viloca --recent
		if [[ ( ! -e ${viloca_statusdir}/pullsamples_viloca_fail ) || ( ${viloca_statusdir}/pullsamples_viloca_success -nt ${viloca_statusdir}/pullsamples_viloca_fail ) ]]; then
			echo "$(basename $(realpath ${viloca_statusdir}/viloca_started))" > ${viloca_statusdir}/viloca_ended
		else
			echo "pulling VILOCA data failed"
		fi
		
	else
		echo 'No current VILOCA run.'
	fi

	#
	# Phase 6: restart VILOCA runs if new data
	#

	echo "===================="
	echo "Start new VILOCA run"
	echo "===================="
	mustrun_viloca=0
	if [[ ( ( ! -e ${viloca_statusdir}/viloca_ended ) && ( ! -e ${viloca_statusdir}/viloca_started ) ) || ( ${viloca_statusdir}/viloca_ended -nt ${viloca_statusdir}/viloca_started ) ]]; then
		if [[ ! -f ${viloca_basedir}/${viloca_samples} ]]; then
			echo "Can't find ${viloca_basedir}/${viloca_samples}, creating it empty"
			echo ",sample,batch" > ${viloca_basedir}${viloca_samples}
		fi
		cat ${viloca_basedir}/${viloca_samples} > ${viloca_basedir}/${viloca_staging}
		lastbatch_viloca=$(cat $(ls -Art ${viloca_statusdir}/viloca_new* | tail -n 1))
		echo "Last batch analysed by VILOCA is ${lastbatch_viloca}"
		vpipe_enddate=$(cat ${statusdir}/vpipe_ended)
		vpipe_enddate=${vpipe_enddate#*.}
		lastbatch_vpipe=$(cat ${statusdir}/vpipe_new.${vpipe_enddate} | awk '{print $1}' | tail -n 1)
		echo "The most recent completed V-Pipe run is on batch ${lastbatch_vpipe}"
		if [[ lastbatch_viloca != lastbatch_vpipe ]]; then
			echo "There is a new most recent batch that VILOCA can run on!"
			t=${basedir}/${sampleset}/samples.${lastbatch_vpipe}.tsv
			if [[ ! $t =~ samples.([[:digit:]]{8})_([[:alnum:]]{5,}(-[[:digit:]]+)?).tsv$ ]]; then
							echo "oops: Can't parse <${t}> ?!" > /dev/stderr
			fi
			echo ",sample,batch" > $viloca_staging
			cat $t | awk '{print $1,$2}' | tr " " "," | sed 's/^/,/' >> $viloca_staging
			(( ++mustrun_viloca ))

		else
			echo "No new batch to run VILOCA on"
		fi

		# are we allowed to submit jobs ?
		if (( donotsubmit_viloca )); then
			echo -e '\e[35;1mWill NOT submit VILOCA jobs\e[0m...' > /dev/stderr
			if (( mustrun_viloca )); then
				echo 'VILOCA submit blocked' > ${viloca_statusdir}/viloca_submit_fail
				echo -e '...\e[33;1mbut there are new VILOCA jobs that should be started !!!\e[0m' > /dev/stderr
			else
				echo '...and there is nothing VILOCA-related to run anyway' > /dev/stderr
			fi
		# start jobs ?
		elif (( mustrun_viloca )); then
			echo 'New VILOCA job waiting. Checking if Viloca is already running...'
			if [[ ( -e ${viloca_statusdir}/viloca_started ) && ( ( ! -e ${viloca_statusdir}/viloca_ended ) || ( ${viloca_statusdir}/viloca_started -nt ${viloca_statusdir}/viloca_ended ) ) ]]; then
				echo "BUT there is already a VILOCA instance running! Retrying during the next loop"
			else
				echo 'starting VILOCA jobs'
				mv ${viloca_staging} ${viloca_samples}
				${remote_batman} viloca  > ${viloca_statusdir}/viloca.${now}	&&	\
					if [[ -s ${viloca_statusdir}/viloca.${now} ]]; then
						ln -sf viloca.${now} ${viloca_statusdir}/viloca_started
						cat ${viloca_statusdir}/viloca_started
						printf "%s\t$(date '+%H%M%S')\n" "${runreason[@]}" | tee -a ${viloca_statusdir}/viloca_new.${now}
						if [[ -n "${mailto[*]}" ]]; then
							(
								echo '(Possibly new) samples not having VILOCA results yet found:'
								printf ' - %s\n' "${lastbatch_vpipe}"
								echo -e '\nStarting VILOCA on Euler:'
								cat ${viloca_statusdir}/viloca_started
							) | mail -s '[Automation-carillon] Starting VILOCA on Euler' "${mailto[@]}"
							# -r "${mailfrom}"
						fi
					fi
				else
					echo "pushing VILOCA sample list failed"
				fi
			fi
		else
			echo 'No new VILOCA jobs to start'
		fi
	else
		echo 'There is already A VILOCA run going on'
	fi
else
	echo "Skipping VILOCA as per configuration"
fi

#
# Closing words
#

${scriptdir}/belfry.sh  df
${remote_batman} df
date -R
