#!/usr/bin/env bash

scriptdir="$(dirname $(realpath $(which $0)))"

if [[ $(uname) == Darwin ]]; then
    date=gdate
else
    date=date
fi


declare -A lab
. ${scriptdir}/config/server.conf

: ${basedir:=$(pwd)}
: ${download:?}
: ${sampleset:=sampleset}
: ${working:=working}
: ${releasedir:?}
: ${storgrp:?}
: ${parallel:=16}
: ${parallelpull:=${parallel}}
: ${contimeout:=300}
: ${retries:=10}
: ${iotimeout:=300}
: ${protocolyaml:=/references/primers.yaml}

if [[ $(realpath $scriptdir) != $(realpath $basedir) ]]; then
    echo "$scriptdir vs $basedir"
fi

if [[ ! $mode =~ ^[0-7]{,4}$ ]]; then
    echo "Invalid characters <${mode//[0-7]/}> in <${mode}>"
    echo 'mode should be an octal chmod value, see `mkdir --help` for informations'
    mode=
fi

set -e

# cd ${basedir}

umask 0002

statusdir="${basedir}/status"
mkdir ${mode:+--mode=${mode}} -p ${statusdir}

timeoutforeground=
#--foreground
#

now=$($date '+%Y%m%d')
lastmonth=$($date '+%Y%m' --date='-1 month')
thismonth=$($date '+%Y%m')
twoweeksago=$($date '+%Y%m%d' --date='-2 weeks')
oneweekago=$($date '+%Y%m%d' --date='-1 weeks')

#
# Input validator
#
validateBatchDate() {
    if [[ "$1" =~ ^(20[0-9][0-9][0-1][0-9][0-3][0-9])$ ]]; then
        return;
    else
        echo "bad batchdate ${1}"
        exit 1;
    fi
}

validateBatchName() {
    if [[ "$1" =~ ^(20[0-9][0-9][0-1][0-9][0-3][0-9]_[[:alnum:]-]{4,})$ ]]; then
        return;
    else
        echo "bad batchname ${1}"
        exit 1;
    fi
}


#
# rsync parallel helpers
#
callpushrsync() {
    . config/server.conf

    local arglist=( )
    if (( ${#@} )); then
        arglist=( "${@/#/${basedir}/${sampleset}/}" )
    else
        #arglist=( "${basedir}/${sampleset}/" )
        echo "rsync job didn't receive list"
        exit 1;
    fi
    scriptdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    
    exec    timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
        rsync \
        -izrltH --fuzzy --fuzzy --inplace   \
        -p --chmod=Dg+s,ug+rw,o-rwx,Fa-x    \
        -g \
        "${arglist[@]}" \
        ${sampleset}/
}
export -f callpushrsync


callpullrsync() {

    notfixedyet

    . config/server.conf

    local arglist=( )
    if (( ${#@} )); then
        arglist=( "${@/#/${cluster_folder}/${working}/samples/}" )
    else
        #arglist=( "belfry@euler.ethz.ch::${working}/samples/" )
        echo "rsync job didn't receive list"
        exit 1;
    fi
    exec    timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
        rsync   --timeout=${iotimeout}  \
        -izrltH --fuzzy --fuzzy --inplace   \
        --link-dest=${basedir}/${sampleset}/    \
        "${arglist[@]}" \
        --exclude='uploads/*'   \
        --exclude='raw_uploads/*.tmp.*' \
        --exclude='raw_data/*_R[12].fastq.gz'   \
        --exclude='extracted_data/R[12]_fastqc.html'    \
        --exclude='variants/SNVs/REGION_*/reads.fas'    \
        --exclude='variants/SNVs/REGION_*/w-*.reads.fas'    \
        --exclude='variants/SNVs/REGION_*/raw_reads/w-*.reads.fas.gz'   \
        --exclude='*.out.log'   \
        --exclude='*.err.log'   \
        --exclude='*.benchmark' \
        ${basedir}/${working}/samples/
}
export -f callpullrsync


callpullrsync_noshorah() {
    . config/server.conf
    scriptdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

    local arglist=( )
    if (( ${#@} )); then
        arglist=( "${@/#/:${cluster_folder}/${working}/samples/}" )
    else
        echo "rsync job didn't receive list"
        exit 1;
    fi
    mkdir -p ${basedir}/${working}/samples/
    timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
        rsync  \
        --timeout=${iotimeout}  \
	--ignore-missing-args \
        -izrltH --fuzzy --fuzzy --inplace   \
        --link-dest=${basedir}/${sampleset}/    \
        "${arglist[@]}" \
        --exclude='uploads/*'   \
        --exclude='raw_uploads/*.tmp.*' \
        --exclude='raw_data/*_R[12].fastq.gz'   \
        --exclude='extracted_data/R[12]_fastqc.html'    \
        --exclude='variants/'   \
        --exclude='visualization/'  \
        --exclude='*.out.log'   \
        --exclude='*.err.log'   \
        --exclude='*.benchmark' \
        ${basedir}/${working}/samples/
}
export -f callpullrsync_noshorah


#
# sync helper
#
checksyncoutput() {
    local new="${statusdir}/sync${1}_new"
    local last="${statusdir}/sync${1}_last"

    if [[ "${2}" =~ Total:\ +([[:digit:]]+)\ +directories,\ +([[:digit:]]+)\ +files,.*?New:\ +([[:digit:]]+)\ +files, ]]; then
        echo "Newfiles downloaded"
        echo -e "${BASH_REMATCH[2]}\n${BASH_REMATCH[1]}" > ${last}
        flock -x -o ${last} -c "sleep 1"
        echo "${BASH_REMATCH[3]}" > ${new}
    else
        echo "Same old shit"
        touch ${last}
    fi 2>&1
}


set -e

echo belfry.sh $1

#
# main handler
#
case "$1" in
    syncopenbis)
        echo "Sync GFB - OpenBIS..."
        if [[ "${2}" = "--recent" ]]; then
            param=( "${lastmonth}*" "${thismonth}*" )
            echo "syncing recent: ${param[*]}"
        elif [[ "${2}" = "--thismonth" ]]; then
            param=( "${thismonth}*" )
            echo "syncing this month: ${param[*]}"
        elif [[ "${2}" = "--lastweek" ]]; then
            param=( "${oneweekago}*" )
            echo "syncing lastweek: ${param[*]}"
        elif [[ "${2}" = "--twoweeksago" ]]; then
            param=( "${twoweeksago}*" )
            echo "syncing lastweek: ${param[*]}"
        else
            param=( )
        fi
        syncoutput="$(${scriptdir}/sync_sftp.sh -c ${scriptdir}/config/gfb.conf "${param[@]}"|tee /dev/stderr)"
        checksyncoutput "openbis" "$syncoutput"
        mamba deactivate
    ;;
    syncfgcz)
        echo "Sync FGCZ - bfabric"
        . $baseconda/mambaforge/bin/activate "wastewater"
        . <(grep '^projlist=' config/fgcz.conf)
        if [[ "${2}" = "--recent" ]]; then
            limitlast='3 weeks ago'
            ./exclude_list_bfabric.py -c config/fgcz.conf -r "${twoweeksago}" -o ${statusdir}/fgcz.exclude.lst
            param=( '-e' "${statusdir}/fgcz.exclude.lst" "${projlist[@]}" )
            echo -ne "syncing recent: ${limitlast}\texcluding: "
            wc -l ${statusdir}/fgcz.exclude.lst
        else
            param=( "${projlist[@]}" )
        fi
        syncoutput="$(/usr/bin/time ${scriptdir}/sync_sftp.sh -c config/fgcz.conf ${limitlast:+ -N "${limitlast}"} "${param[@]}"|tee /dev/stderr)"
        checksyncoutput "fgcz" "$syncoutput"
        mamba deactivate
    ;;
    synch2030)
        echo "Sync Health2030"
        . $baseconda/mambaforge/bin/activate "wastewater"
        # short test - only list dirs
        if [[ ( ( ! -e ${statusdir}/synch2030_ended ) && ( ! -e ${statusdir}/synch2030_started ) ) || ( ${statusdir}/synch2030_ended -nt ${statusdir}/synch2030_started ) ]]; then
            ${scriptdir}/list_sftp -c config/h2030.conf -l ${statusdir}/synch2030.${now}   &&  \
            if [[ -s ${statusdir}/synch2030.${now} ]]; then
                ln -sf synch2030.${now} ${statusdir}/synch2030_started
            fi
            # did we get new list?
            if [[ ( -e ${statusdir}/synch2030_started ) && ( ( ! -e ${statusdir}/synch2030_ended ) || ( ${statusdir}/synch2030_started -nt ${statusdir}/synch2030_ended ) ) ]]; then
                cat ${statusdir}/synch2030_started
            else
                echo "no new dirs"
            fi
        fi
        # long sync - full mirror
        if [[ ( -e ${statusdir}/synch2030_started ) && ( ( ! -e ${statusdir}/synch2030_ended ) || ( ${statusdir}/synch2030_started -nt ${statusdir}/synch2030_ended ) ) ]]; then
            syncoutput="$(/usr/bin/time ${scriptdir}/sync_sftp.sh -c config/h2030.conf |tee /dev/stderr)"
            checksyncoutput "h2030" "$syncoutput"
            ${scriptdir}/check_sums -c config/h2030.conf 'md5.txt' $( < ${statusdir}/synch2030_started)
            # 2: internal error, grep error
            # 1: no failed checksum found
            # 0: failed checksum found
            if [[ "$?" == "1" ]]; then
                touch ${statusdir}/synch2030_ended
            fi
        fi
        mamba deactivate
    ;;
    syncviollier)
        echo "Sync Viollier"
        . $baseconda/mambaforge/bin/activate "wastewater"
        param=( 'sample_metadata' )
        if [[ "${2}" = "--recent" ]]; then
            param+=( "raw_sequences/${lastmonth}*" "raw_sequences/${thismonth}*" )
            echo "syncing recent: ${param[*]}"
            echo "NOT SUPPORTED"
            exit 1
        else
            param+=( 'raw_sequences' )
            echo "syncing all: ${param[*]}"
        fi
        # HACK delete previous partial downloads
        . <(grep '^download=' config/viollier.conf)
        echo "Removing partial files from:" "${param[@]/#/${download}/}"
        find "${param[@]/#/${download}/}" -type f -name '*.filepart' -print0 | xargs -r -0 rm -v
        syncoutput="$(/usr/bin/time ${scriptdir}/sync_sftp.sh -c config/viollier.conf "${param[@]}"|tee /dev/stderr)"
        checksyncoutput "viollier" "$syncoutput"
        mamba deactivate
    ;;
    uploadviollier)
        echo "Uploading Viollier"
        . $baseconda/mambaforge/bin/activate "wastewater"
        param=( 'consensus_sequences' 'raw_othercenters' )

        ${scriptdir}/upload_sftp -c config/viollier.conf "${param[@]}"
        mamba deactivate
    ;;
    purgeviollier)
        if  (( ! ${lab[viollier]} )); then
            echo "Viollier disabled; no purging"
            exit 0
        fi
        echo "Purge Viollier"
        . $baseconda/mambaforge/bin/activate "wastewater"
        param=( 'raw_sequences' )
        recent=$($date --date='2 week ago' '+%Y%m%d')

        ${scriptdir}/purge_sftp -r "${recent}" -c config/viollier.conf "${param[@]}"
        mamba deactivate
    ;;
    uploadrequests)
        echo "Handling raw-read upload requests for Viollier"
	echo "deactivated"
	exit
        . $baseconda/mambaforge/bin/activate "vineyard"
        ${scriptdir}/handle_request_raw_viollier -c config/viollier.conf
        mamba deactivate
    ;;
    sortsamples)
        . $baseconda/mambaforge/bin/activate pybis
        # cd $basedir
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
	   
          ${scriptdir}/sort_samples_pybis.py -c ${scriptdir}/config/gfb.conf --protocols=${cluster_mount}/${working}/${protocolyaml} --assume-same-protocol ${force} ${summary} ${recent} && bash ${basedir}/${sampleset}/movedatafiles.sh || fail=1
        else
            echo "Skipping gfb"
        fi
        if  (( ${lab[fgcz]} )); then
#           # TODO config file
            . <(grep '^google_sheet_patches=' fgcz.conf)

            (( google_sheet_patches )) && ${scriptdir}/google_sheet_patches
            ${scriptdir}/sort_samples_bfabric_tsv -c fgcz.conf --no-fastqc --protocols=${working}/${protocolyaml}  --libkit-override=${basedir}/${sampleset}/patch.fgcz-libkit.tsv ${force} ${recent} && bash ${basedir}/${sampleset}/movedatafiles.sh || fail=1
        else
            echo "Skipping fgcz"
        fi
        if  (( ${lab[h2030]} )) && [[ -e ${statusdir}/synch2030_ended && -e ${statusdir}/synch2030_started && ${statusdir}/synch2030_ended -nt ${statusdir}/synch2030_started ]]; then
            # NOTE always recent/based on last sync), no support for --force, move done immediately/no separate movedatafiles.sh
            # TODO support for protocols
            ${scriptdir}/sort_h2030 -c h2030.conf $(< ${statusdir}/synch2030_started ) || fail=1
        else
            echo "Skipping h2030"
        fi
        if  (( ${lab[viollier]} )); then
            # NOTE always --force, short options only
            # HACK hardcoded paths due to multiple directories
            ${scriptdir}/sort_viollier -c viollier.conf -4 ${working}/${protocolyaml} ${shrtrecent} sftp-viollier/raw_sequences/*/ && bash ${basedir}/${sampleset}/movedatafiles.sh || fail=1
        else
            echo "Skipping viollier"
        fi
        (( fail == 0 )) &&  touch ${statusdir}/sortsamples_success || touch ${statusdir}/sortsamples_fail
        mamba deactivate
    ;;
    fixopenbisrights)
        validateBatchDate "$2"
        # NOTE ACLs should autopropagate

        #dir=( ${basedir}/${download}/${2}* )
        #if (( ${#dir[@]} > 1 )); then
        #   echo "${#dir[@]} directories"
        #   echo 'mode directories'
        #   find "${dir[@]}" -type d -print0 | xargs -0 chmod u+rwx,g+rwXs,o-rwx
        #   echo 'mode files'
        #   find "${dir[@]}" -type f -print0 | xargs -0 chmod 0660
        #   #echo 'group'
        #   #chgrp -R "${storgrp}" "${dir[@]}"
        #fi
    ;;
    pushsampleset)
        if [[ "${2}" = "--recent" ]]; then
            sheets=( ${basedir}/${sampleset}/samples.${lastmonth}*.tsv ${basedir}/${sampleset}/samples.${thismonth}*.tsv )
            # BUG: will generate non-globed pattern if months are missing
            echo "pushing recent: ${param[*]##/}"
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "${basedir}/${sampleset}/samples.${3}.tsv"  )
        else
            sheets=( ${basedir}/${sampleset}/samples.*.tsv )
        fi
	echo ${sheets[@]}
        err=0
	source ${baseconda}/secrets/${cluster_user}@${cluster}
        remote_batman="ssh -o StrictHostKeyChecking=no -i ${privkey} ${cluster_user}@${cluster}"
	shopt -s nullglob
        timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
            rsync -e "${remote_batman} -oConnectTimeout=${contimeout} rsync" \
            -izrltH --fuzzy --fuzzy --inplace   \
            -p --chmod=Dg+s,ug+rw,o-rwx,Fa-x    \
            -g \
            ${basedir}/${sampleset}/samples.*.tsv   \
            ${basedir}/${sampleset}/batch.*.yaml    \
            ${basedir}/${sampleset}/projects.*.tsv  \
            ${basedir}/${sampleset}/missing.*.txt   \
            ${basedir}/${sampleset}/patch.*.tsv \
	    :${cluster_mount}/${sampleset} || (( ++err ))
        cut -s --fields=1 "${sheets[@]}"|sort -u|   \
            gawk -v P=$(( parallel * 4 ))  '{i=(NR-1);b=i%P;o[b]=(o[b] " \"" $1 "\"")};END{for(i=0;i<P;i++){printf("%s\0",o[i])}}'| \
            xargs -0 -P $parallel -I '{@LIST@}' --  \
                bash -c "callpushrsync {@LIST@} " || (( ++err ))
        if (( err )); then
            echo "Error: ${err} rsync job(s) failed"
            touch ${statusdir}/pushsampleset_fail
        else
	    echo "push succeeded"
            touch ${statusdir}/pushsampleset_success
        fi
	exit
    ;;
    listsamples)
        ls ${cluster_mount}/${working}/samples/
        #timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
        #    rsync   --timeout=${iotimeout}  \
        #    -iPzrltH --fuzzy --fuzzy --inplace  \
        #    -p --chmod=Dg+s,ug+rw,o-rwx \
        #    -g \
        #    --list-only \
        #    belfry@euler.ethz.ch::${working}/samples/
    ;;
    pullsamples_noshorah)
        # fetch remote sheets
        if [[ "${2}" = "--recent" ]]; then
            sheets=( ":${cluster_mount}/${sampleset}/samples.${lastmonth}*.tsv" ":${cluster_mount}/${sampleset}/samples.${thismonth}*.tsv" )
        elif [[ "${2}" = "--batch" ]]; then
	    unused
            validateBatchName "${3}"
            sheets=( "${cluster_mount}/${sampleset}/samples.${3}.tsv"  )
        elif [[ "${2}" = "--catchup" ]]; then
	    unused
            sheets=( "${cluster_mount}/catchup/samples.catchup.tsv"  )
        else
	    unused
            sheets=( "${cluster_mount}/${sampleset}/samples.2*.tsv" )
        fi

        timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
	    rsync \
            -izrlt --fuzzy --fuzzy --inplace    \
            --exclude='*.out.log'   \
            --exclude='*.err.log'   \
            --exclude='*.benchmark' \
            ${cluster_mount}/${working}/{qa.csv,variants}  \
            ${basedir}/${working}/ || (( ++err ))
        echo "samples:"
        cut -s --fields=1 "${sheets[@]}"|sort -u|   \
            gawk -v P=$(( parallelpull * 4 )) '{i=(NR-1);b=i%P;o[b]=(o[b] " \"" $1 "\"")};END{for(i=0;i<P;i++){printf("%s\0",o[i])}}'|  \
            xargs -0 -P $parallelpull -I '{@LIST@}' --  \
                bash -c "callpullrsync_noshorah {@LIST@} " || (( ++err ))
        if (( err )); then
            echo "Error: ${err} rsync job(s) failed"
            touch ${statusdir}/pullsamples_noshorah_fail
	    exit
        elif [[ "${2}" = "--catchup" ]]; then
            echo -e '\n\e[38;5;45;1mFor the good of all of us\e[0m\n\e[38;5;208;1mExcept the ones who are dead\e[0m'
        else
            touch ${statusdir}/pullsamples_noshorah_success
        fi
    ;;
    pullsamples)
        # fetch remote sheets
        if [[ "${2}" = "--recent" ]]; then
            sheets=( "${sampleset}/samples.${lastmonth}*.tsv" "${sampleset}/samples.${thismonth}*.tsv" )
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "${sampleset}/samples.${3}.tsv"  )
        elif [[ "${2}" = "--catchup" ]]; then
            sheets=( "catchup/samples.catchup.tsv"  )
        else
            sheets=( "${sampleset}/samples.2*.tsv" )
        fi
	target_dir=$(mktemp -d)
	echo "pull samples to ${target_dir}"
	# todo: secrets
        rsync   \
            -e "ssh -o StrictHostKeyChecking=no -i ${privkey} ${cluster_user}@${cluster}" \
	    --itemize-changes \
	    --compress \
	    --recursive \
	    --links \
	    --times \
	    --hard-links \
            --fuzzy \
	    --fuzzy \
	    --inplace \
	    --perms \
	    --group \
            --chmod=Dg+s,ug+rw,o-rwx \
            "${sheets[@]}"  \
	    ${target_dir}
        if [[ "${2}" = "--recent" ]]; then
            sheets=( ${target_dir}/samples.${lastmonth}*.tsv ${target_dir}/samples.${thismonth}*.tsv )
            # BUG: will generate non-globed pattern if months are missing
            echo "pulling recent: ${param[*]##/}"
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "${target_dir}/samples.${3}.tsv" )
        elif [[ "${2}" = "--catchup" ]]; then
            sheets=( "${target_dir}/samples.catchup.tsv" )
        else
            sheets=( ${taget_dir}/samples.2*.tsv )
        fi
        err=0
        timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
            rsync  --timeout=${iotimeout}  \
            -e "ssh -o StrictHostKeyChecking=no -i ${privkey} ${cluster_user}@${cluster}" \
            -izrlt --fuzzy --fuzzy --inplace    \
            --exclude='*.out.log'   \
            --exclude='*.err.log'   \
            --exclude='*.benchmark' \
            ${working}/{qa.csv,variants}  \
            ${basedir}/${working}/ || (( ++err ))
        echo "samples:"
        cut -s --fields=1 "${sheets[@]}"|sort -u|   \
            gawk -v P=$(( parallelpull * 4 )) '{i=(NR-1);b=i%P;o[b]=(o[b] " \"" $1 "\"")};END{for(i=0;i<P;i++){printf("%s\0",o[i])}}'|  \
            xargs -0 -P $parallelpull -I '{@LIST@}' --  \
                bash -c "callpullrsync {@LIST@} " || (( ++err ))
        if (( err )); then
            echo "Error: ${err} rsync job(s) failed"
            touch ${statusdir}/pullsamples_fail
        elif [[ "${2}" = "--catchup" ]]; then
            echo -e '\n\e[38;5;45;1mFor the good of all of us\e[0m\n\e[38;5;208;1mExcept the ones who are dead\e[0m'
        else
            touch ${statusdir}/pullsamples_success
        fi
    ;;
    
    old_pullsamples)
        # fetch remote sheets
        mkdir -p /tmp/belfrysheets/
        if [[ "${2}" = "--recent" ]]; then
            sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.${lastmonth}*.tsv" "belfry@euler.ethz.ch::${sampleset}/samples.${thismonth}*.tsv" )
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.${3}.tsv"  )
        elif [[ "${2}" = "--catchup" ]]; then
            sheets=( "belfry@euler.ethz.ch::catchup/samples.catchup.tsv"  )
        else
            sheets=( "belfry@euler.ethz.ch::${sampleset}/samples.2*.tsv" )
        fi
        rsync   \
            -izrltH --fuzzy --fuzzy --inplace   \
            -p --chmod=Dg+s,ug+rw,o-rwx \
            -g \
            "${sheets[@]}"  \
            /tmp/belfrysheets/
        if [[ "${2}" = "--recent" ]]; then
            sheets=( /tmp/belfrysheets/samples.${lastmonth}*.tsv /tmp/belfrysheets/samples.${thismonth}*.tsv )
            # BUG: will generate non-globed pattern if months are missing
            echo "pulling recent: ${param[*]##/}"
        elif [[ "${2}" = "--batch" ]]; then
            validateBatchName "${3}"
            sheets=( "/tmp/belfrysheets/samples.${3}.tsv"  )
        elif [[ "${2}" = "--catchup" ]]; then
            sheets=( "/tmp/belfrysheets/samples.catchup.tsv"  )
        else
            sheets=( /tmp/belfrysheets/samples.2*.tsv )
        fi
        err=0
        timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
            rsync   --timeout=${iotimeout}  \
            -izrlt --fuzzy --fuzzy --inplace    \
            --exclude='*.out.log'   \
            --exclude='*.err.log'   \
            --exclude='*.benchmark' \
            belfry@euler.ethz.ch::${working}/{qa.csv,variants}  \
            ${basedir}/${working}/ || (( ++err ))
        echo "samples:"
        cut -s --fields=1 "${sheets[@]}"|sort -u|   \
            gawk -v P=$(( parallelpull * 4 )) '{i=(NR-1);b=i%P;o[b]=(o[b] " \"" $1 "\"")};END{for(i=0;i<P;i++){printf("%s\0",o[i])}}'|  \
            xargs -0 -P $parallelpull -I '{@LIST@}' --  \
                bash -c "callpullrsync {@LIST@} " || (( ++err ))
        if (( err )); then
            echo "Error: ${err} rsync job(s) failed"
            touch ${statusdir}/pullsamples_fail
        elif [[ "${2}" = "--catchup" ]]; then
            echo -e '\n\e[38;5;45;1mFor the good of all of us\e[0m\n\e[38;5;208;1mExcept the ones who are dead\e[0m'
        else
            touch ${statusdir}/pullsamples_success
        fi
    ;;
    qa_report)
        . $baseconda/mambaforge/bin/activate qa_report
        cd ${basedir}/${working}/
        if python qa_report.py; then
		echo qa report succeeded
	      	touch ${statusdir}/qa_report_success;
        else 
		echo qa report failed
		touch ${statusdir}/qa_report_fail
	fi
        mamba deactivate
    ;;
    pushseq)
        . $baseconda/mambaforge/bin/activate "wastewater"
        ./upload_viollier && touch ${statusdir}/pushseq_success || touch ${statusdir}/pushseq_fail
        mamba deactivate
    ;;
    gitaddseq)
        . $baseconda/mambaforge/bin/activate "wastewater"
        cd ${releasedir}
        git add qa*
        find samples -name '*.fasta' -type f -print0 | xargs -0 git add
        mamba deactivate
    ;;
    df)
        df -h ${basedir}
	echo
        df -h --inode ${basedir}
    ;;
    garbage)
        validateBatchName "$2"

        for f in ${sampleset}/*/${2}; do
            garbage=$(dirname "${f//${sampleset}/garbage}")
            mkdir ${mode:+--mode=${mode}} -p "${garbage}"
            mv -v "${f%/}" "${garbage}/"
        done
        for f in ${working}/samples/*/${2}/; do
            garbage="${f//${working}\/samples/garbage}"
            mkdir ${mode:+--mode=${mode}} -p "${garbage%/}/"{raw_data,extracted_data}/
            mv -vf "${f%/}/raw_data/"* "${garbage%/}/raw_data/"
            rm "${f%/}/raw_data/"*.fa*
            rmdir "${f%/}/raw_data/"
            #mv -vf "${f%/}/extracted_data/"* "${garbage%/}/extracted_data/"
            #rm "${f%/}/extracted_data/"*_fastqc.html
            #rmdir "${f%/}/extracted_data/"
            mv -vf "${f%/}/"* "${garbage%/}/"
            rmdir "${f%/}"
        done
        mv "${sampleset}/batch.${2}.yaml" "${sampleset}/samples.${2}.tsv" "${sampleset}/missing.${2}.txt" "${sampleset}/projects.${2}.tsv" garbage/
    ;;
    *)
        echo "Unkown sub-command ${1}" > /dev/stderr
        exit 2
    ;;
esac
