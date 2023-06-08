#!/bin/bash

configfile=config/server.conf

usage() { echo "Usage: $0 [ -l <outputlist> ] [-c <configfile>] [filter [...]]" 1>&2; exit $1; }

while getopts "l:c:h" o; do
	case "${o}" in
		c)	configfile=${OPTARG}
			if [[ ! -r ${configfile} ]]; then
				echo "Cannot read ${configfile}" 1>&2
				usage 1
			fi
			;;
		l)	listfile=${OPTARG}	;;
		h)	usage 0	;;
		*)	usage 1	;;
	esac
done
shift $((OPTIND-1))


. ${configfile}

: ${fileserver:?}
# ${srvport}
: ${expname:?}
: ${basedir:=$(pwd)}
: ${download:?}

if [[ $( < ~/.netrc ) =~ machine[[:space:]]+${fileserver}[[:space:]]?login[[:space:]]+([^[:space:]]+) ]]; then
	username="${BASH_REMATCH[1]}"
elif [[ $( < ~/.ssh/config ) =~ Host[[:space:]]+${fileserver}[[:space:]]+ ]]; then
	username=
else
	echo "cannot find login for machine ${fileserver} in ~/.netrc" >&2
	exit 1
fi

if (( ${#@} )); then
	dir=( "${@/#/ /${expname}/}" )
	source="${dir[*]}"
else
	source="/${expname}/"
fi

missing=( )
for d in $(lftp -c "connect sftp://${username:+${username}@}${fileserver}${srvport:+:${srvport}}; cls -q1B ${source}"); do
	if [[ ! -d "${basedir}/${download}/${d}" ]]; then
		missing+=( "${d}" )
		: #echo "${d} missing"
	else
		: #echo "${d} present"
	fi
done

if (( ${#missing[@]} > 0 )) && [[ -n ${listfile} ]]; then
	printf "%s\n" "${missing[@]}" > ${listfile}
fi
