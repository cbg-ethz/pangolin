#!/bin/bash

configfile=config/server.conf

usage() { echo "Usage: $0 [-c <configfile>] directories [...] " 1>&2; exit $1; }

while getopts "c:h" o; do
	case "${o}" in
		c)	configfile=${OPTARG}
			if [[ ! -r ${configfile} ]]; then
				echo "Cannot read ${configfile}" 1>&2
				usage 2
			fi
			;;
		h)	usage 0	;;
		*)	usage 2	;;
	esac
done
shift $((OPTIND-1))

. ${configfile}

: ${fileserver:?}
# ${srvport}
: ${expname:?}
: ${basedir:=$(pwd)}
: ${download:?}
: ${parallel:=16}
: ${contimeout:=300}
: ${retries:=10}
: ${iotimeout:=300}

if [[ $( < ~/.netrc ) =~ machine[[:space:]]+${fileserver}[[:space:]]?login[[:space:]]+([^[:space:]]+) ]]; then
	username="${BASH_REMATCH[1]}"
elif [[ $( < ~/.ssh/config ) =~ Host[[:space:]]+${fileserver}[[:space:]]+ ]]; then
	username=
else
	echo "cannot find login for machine ${fileserver} in ~/.netrc nor ~/.ssh/config" >&2
	exit 1
fi

if (( ${#@} )); then
	dir=( "${@/#/ --directory=${download}/}" )
	source="${dir[*]}"
else
	source="--directory=${download}/*"
	echo "directories to upload are currently mandatory !" >&2
	exit 2
fi

cd ${basedir}
exec lftp -c "set cmd:move-background false; set net:timeout $(( contimeout / retries)); set net:max-retries ${retries}; set net:reconnect-interval-base 8; set xfer:timeout ${iotimeout}; connect sftp://${username:+${username}@}${fileserver}${srvport:+:${srvport}}; mirror --reverse --continue --no-perms --no-umask --parallel=${parallel} --loop --target-directory=${expname} ${source}"
