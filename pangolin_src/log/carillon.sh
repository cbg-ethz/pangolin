#!/bin/bash

scriptdir="$(dirname $(realpath $(which $0)))"

. ${scriptdir}/config/server.conf

: ${run_shorah:=0}
: ${staging:=1}

if [[ $(realpath $scriptdir) != $(realpath $basedir) ]]; then
    echo "$scriptdir vs $basedir"
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
lockfile=${statusdir}/carillon_lock


touch ${statusdir}/oh_hai_im_lopping


#
# Phase 1: periodic data sync
#

echo '========='
echo 'Data sync'
echo '========='

set -e

[[ -n $skipsync ]] && echo "Hack: ${skipsync} will be skiped."


# UWE: UNDO:
# [[ $skipsync != gfb     ]] && ${scriptdir}/belfry.sh syncopenbis --twoweeksago # --recent
# ${scriptdir}/belfry.sh sortsamples --recent $([[ ${statusdir}/syncopenbis_last -nt ${statusdir}/syncopenbis_new ]] && echo '--summary')

# uploading requests require prior successful download
if [[ ( -e ${statusdir}/sortsamples_fail ) && ( ${statusdir}/sortsamples_fail -nt  ${statusdir}/sortsamples_success ) ]]; then
    echo 'warning: cannot serve upload requests sampleset data not successfully fetched yet' > /dev/stderr
#else
    #${scriptdir}/belfry.sh uploadrequests
fi

echo '---------'
if [[ !  ${statusdir}/syncopenbis_last -nt ${statusdir}/syncopenbis_new ]]; then
    echo "Data was copied: $(<${statusdir}/syncopenbis_new)"
    limit=$(date --date='1 week ago' '+%Y%m%d')
    echo "Fixing perms back until $limit:"
    for d in $(echo ${basedir}/${download}/20* | grep -oP "(?<=/${download}/)(20[0-9][0-9][0-1][0-9][0-3][0-9])" | sort -r -u); do
        if [[ "$d" < "$limit" ]]; then
            echo '...done'
            break
        else
            echo "...${d}..."
        fi
        ${scriptdir}/belfry.sh fixopenbisrights "${d}"
    done
fi

source ./secrets/${cluster_user}@${cluster}

remote_batman="ssh -ni ${privkey} ${cluster_user}@${cluster} --"


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
        if [[ ( -n "${stat}" ) && ( ! "${stat}" =~ (EXIT|DONE) ) ]]; then
            # running
            echo -n "$j : $id : $stat"
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

    echo $stillrunning

    if (( stillrunning == 0 )); then
        # HACK temporarily avoid copying over ShoRAH files
        #${scriptdir}/belfry.sh pullsamples --recent
        #if [[ ( ! -e ${statusdir}/pullsamples_fail ) || ( ${statusdir}/pullsamples_success -nt ${statusdir}/pullsamples_fail ) ]]; then
        ${scriptdir}/belfry.sh pullsamples_noshorah --recent
        if [[ ( ! -e ${statusdir}/pullsamples_noshorah_fail ) || ( ${statusdir}/pullsamples_noshorah_success -nt ${statusdir}/pullsamples_noshorah_fail ) ]]; then
            echo "$(basename $(realpath ${statusdir}/vpipe_started))" > ${statusdir}/vpipe_ended
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
    #${scriptdir}/belfry.sh qa_report
    touch ${statusdir}/qa_report_success
else
    echo 'no newer results'
fi

if [[ ( -e ${statusdir}/qa_report_success ) && ( ( ! -e ${statusdir}/pushseq_success ) || ( ${statusdir}/qa_report_success -nt ${statusdir}/pushseq_success ) ) ]]; then
    :
    ${scriptdir}/belfry.sh pushseq
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
rxsample='(^[[:digit:]]{6,}_)|(^[[:digit:]]{8,})|(^Y[[:digit:]]{8,})|([[:digit:]]{2}_20[[:digit:]]{2}_[01]?[[:digit:]]_[0-3]?[[:digit:]])|(^KLZHC[oO][vV])|(^B[aA][[:digit:]]{4,})|(^USB_20[[:digit:]]{2}_[01]?[[:digit:]]_[[:digit:]]{2}_.{8})'
#rxsample='^[[:digit:]]{6,}_'

scanmissingsamples() {
    while read sample batch other; do
        # look for only guaranteed samples
        [[ $sample =~ $rxsample ]] || continue
        # check the presence of fasta on each sample
        if [[ -e ${basedir}/${working}/samples/${sample}/${batch}/upload_prepared.touch ]]; then
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
    echo 1
    clearline=0
    mustrun=0
    runreason=( )
    declare -A flowcell
    if test -e ${statusdir}/vpipe_started; then
        ref=$(date --reference="${statusdir}/vpipe_started" '+%Y%m%d')
        now=$(date '+%Y%m%d')
        limit=$(date --date='2 weeks ago' '+%Y%m%d')
        echo "Check batch against ${ref}:"
        for t in ${basedir}/${sampleset}/samples.*.tsv; do
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
    fi

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
            ${remote_batman} addsamples --recent    && \
            ${remote_batman} vpipe ${shorah} --recent --tag "$(join_by ';' "${runreason[@]}")" > ${statusdir}/vpipe.${now}  &&  \
            if [[ -s ${statusdir}/vpipe.${now} ]]; then
                ln -sf vpipe.${now} ${statusdir}/vpipe_started
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
        staging_tsv=( sampleset/samples.202*.tsv.staging )
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

#
# Closing words
#

${scriptdir}/belfry.sh  df
${remote_batman} df
date -R
