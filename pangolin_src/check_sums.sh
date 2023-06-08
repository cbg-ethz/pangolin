#!/bin/bash

configfile=config/server.conf

usage() { echo "Usage: $0 [-c <configfile>] <sumfile> <directories [...]>" 1>&2; exit $1; }

while getopts "l:c:h" o; do
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

: ${basedir:=$(pwd)}
: ${download:?}

if (( ${#@} < 2)); then
	usage 2
else
	sumfile=$1
	shift
	case ${sumfile,,} in
		*xxh*)
			sum=xxh64sum
		;;
		*md5*)
			sum=md5sum
		;;
		*sha256*)
			sum=sha256sum
		;;
		*sha*)
			sum=sha1sum
		;;
		*)
			echo "Unrecognized sum type: ${sumfile}" 1>&2
			exit 2
		;;
	esac
fi

success=1
checkfiles=( )
for d in "${@}"; do
	if [[ ! -d "${basedir}/${download}/${d}" ]]; then
		echo "No ${d}" 1>&2
		success=0
		continue
	elif [[ ! -r "${basedir}/${download}/${d}/${sumfile}" ]]; then
		echo "No ${sumfile} in ${d}" 1>&2
		success=0
		continue
	else
		checkfiles+=( "${basedir}/${download}/${d}/${sumfile}.check" )
		echo -ne "\r\e[Kchecksum ${d}/${sumfile}\r"
		# TODO skip past checks if successful
		# TODO make parallel
		( cd ${basedir}/${download}/${d}/; ${sum} -c "${sumfile}" > "${sumfile}.check" )
	fi
done

echo -ne "\r\e[K"
#echo "success: ${success}"
#echo "${#checkfiles[@]}: ${checkfiles[*]}"

(( (success > 0) && (${#checkfiles[@]} > 0) )) || exit 2

echo -n "FAILED: "
exec grep -cvP ': OK$' "${checkfiles[@]}"
