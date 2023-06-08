#!/bin/bash

configfile=config/server.conf

usage() { echo "Usage: $0 [ -d ] [ -i ] [ -r <recent_to_keep> ] [-c <configfile>] [filter [...]]" 1>&2; exit $1; }

dryrun=0
ignoredownload=0
while getopts "r:c:dih" o; do
	case "${o}" in
		c)	configfile=${OPTARG}
			if [[ ! -r ${configfile} ]]; then
				echo "Cannot read ${configfile}" 1>&2
				usage 1
			fi
			;;
		d)	dryrun=1 ;;
		i)	ignoredownload=1 ;;
		r)	recent=${OPTARG}
			if [[ ! ${recent} =~ ^20[[:digit:]]{2}-?([01][[:digit:]]-?([0-3][[:digit:]])?)?$ ]]; then
				echo "Wrong format ${recent}" 1>&2
				usage 2
			fi
			;;
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

du_option=
if (( ${#@} )); then
	dir=( "${@/#/ /${expname}/}" )
	source="${dir[*]}"
	if (( ${#dir[@]} > 1)); then
		du_option='c'
	fi
else
	source="/${expname}/"
fi

if [[ -z "${recent}" ]]; then
	echo -e "\e[31;1mWarning, no date limit set to purge ${fileserver}\e[0m"
else
	echo -e "\e[37;1mPurging older than ${recent} from ${fileserver}\e[0m"
fi


purgelist=( )
for d in $(lftp -c "connect sftp://${username:+${username}@}${fileserver}${srvport:+:${srvport}}; cls -q1 ${source};"); do
	b=$(basename "${d}")
	if [[ ! -d "${basedir}/${download}/${d}" ]] && (( ! ignoredownload )); then
		echo "${d} not present!"
		continue
	elif [[ ! "${b}" =~ ^(20[[:digit:]]{2})-?([01][[:digit:]])-?([0-3][[:digit:]]) ]]; then
		echo "${b} cannot parse"
		continue
	elif [[ -n "${recent}" && "${b}" > "${recent}" ]]; then # lexicographic order, so it works with subsets
		echo "${b} skip"
	else
		purgelist+=( "${d}" )
		echo "${b} to be purged"
	fi
done

if (( ${#purgelist[@]} > 0 )) && [[ -n "${purgelist[*]}" ]]; then
	if [[ "${purgelist[*]}" =~ [\;\"\'] ]]; then
		echo "<${purgelist[*]}> invalid character ${BASH_REMATCH[0]}"
		exit 1
	fi
	if (( dryrun )); then
		echo "Dry-run, not actually deleting"
		exit 0
	fi
	exec lftp -c "connect sftp://${username:+${username}@}${fileserver}${srvport:+:${srvport}}; du -s${du_option}h ${source}; rm -r ${purgelist[*]}; sleep 5s; du -s${du_option}h ${source};"
else
	echo "Nothing to do"
	exec lftp -c "connect sftp://${username:+${username}@}${fileserver}${srvport:+:${srvport}}; du -s${du_option}h ${source};"
fi
