#!/bin/bash

usage() { echo "Usage: $0 [-c <configfile>] [ -N <newerthan> ] [ -e <exclude-rx-file> ] [filter [...]]" 1>&2; exit $1; }


while getopts "c:N:e:h" o; do
    case "${o}" in
        c)  configfile=${OPTARG}
            if [[ ! -r ${configfile} ]]; then
                echo "Cannot read ${configfile}" 1>&2
                usage 1
            fi
            ;;
        e)  exrxfile="${OPTARG}"    ;;
        N)  newerthan="${OPTARG}"   ;;
        H)  https=True ;;
        h)  usage 0 ;;
        *)  usage 1 ;;
    esac
done
shift $((OPTIND-1))


. ${configfile}

: ${fileserver:?}
# ${srvport}
# ${prefix}
: ${expname:?}
: ${basedir:=$(pwd)}
: ${download:?}
: ${parallel:=16}
: ${contimeout:=300}
: ${retries:=10}
: ${iotimeout:=300}

. /cluster/home/bs-pangolin/.ssh/${fileserver}

# add host rsa key if not done yet:
grep --silent \\[${fileserver}\\]:${srvport} ~/.ssh/known_hosts || { ssh-keyscan -t rsa -p ${srvport} ${fileserver} >> ~/.ssh/known_hosts; }

if (( ${#@} )); then
    dir=( "${@/#/ --directory=${prefix:+${prefix}/}${expname}/}" )
    source="${dir[*]}"
else
    source="--directory=${prefix:+${prefix}/}${expname}/*"
fi

umask 0002

if (( https )); then
    for i in "${projlist[@]}"
    do
        exrx=$(tr '\n' ',' < ${exrxfile} | sed 's/.$//')
        wget_opt="-e robots=off --mirror --cut-dirs=1 --convert-links --adjust-extension --page-requisites --no-parent --no-host-directories -P ${download} -N -c --tries ${retries} --connect-timeout=${iotimeout} --reject *.gif,*.html,${exrx}"
        wget_cred="--user ${user} --password ${password}"
        fileserver="https://${fileserver}:${srvport}/projects/${i}"
        echo "wget ${wget_opt} --user ${user} --password <password> ${fileserver}"
        exec "wget ${wget_opt} ${wget_cred} ${fileserver}"
    done
else
    connect="connect sftp://${user}:${password}@${fileserver}:${srvport}"
    echo "connect sftp://${user}:<PASSWORD>@${fileserver}:${srvport}"
    settings="set cmd:move-background false; set net:timeout $(( contimeout / retries)); set net:max-retries ${retries}; set net:reconnect-interval-base 8; set xfer:timeout ${iotimeout}"
    mirror="mirror --ignore-time -v --continue --no-perms --parallel=${parallel} --loop ${source} -O ${download} ${newerthan:+ --newer-than="'${newerthan}'"}${exrxfile:+ --exclude-rx-from="'${exrxfile}'"}"
    echo lftp -c "$settings; connect sftp://${user}:<PASSWORD>@${fileserver}:${srvport}; $mirror"
    exec lftp -c "$settings; $connect; $mirror"
fi