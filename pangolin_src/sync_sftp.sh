#!/bin/bash

configfile=config/server.conf

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

. /home/bs-pangolin/wastewater_setup/secrets/${fileserver}

# add host rsa key if not done yet:
grep --silent \\[${fileserver}\\]:${srvport} ~/.ssh/known_hosts || { ssh-keyscan -t rsa -p ${srvport} ${fileserver} >> ~/.ssh/known_hosts; }

if (( ${#@} )); then
    dir=( "${@/#/ --directory=${prefix:+${prefix}/}${expname}/}" )
    source="${dir[*]}"
else
    source="--directory=${prefix:+${prefix}/}${expname}/*"
fi

umask 0002


connect="connect sftp://${user}:${password}@${fileserver}:${srvport}"
echo $connect
settings="set cmd:move-background false; set net:timeout $(( contimeout / retries)); set net:max-retries ${retries}; set net:reconnect-interval-base 8; set xfer:timeout ${iotimeout}"
mirror="mirror --ignore-time -v --continue --no-perms --parallel=${parallel} --loop --target-directory=${basedir}/${download} ${source} ${newerthan:+ --newer-than="'${newerthan}'"}${exrxfile:+ --exclude-rx-from="'${exrxfile}'"}"

echo lftp -c "$settings; $connect; $mirror"
exec lftp -c "$settings; $connect; $mirror"
