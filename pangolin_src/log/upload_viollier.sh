#!/bin/bash

configfile=config/viollier.conf

usage() { echo "Usage: $0 [-c <configfile>]" 1>&2; exit $1; }

while getopts "c:h" o; do
	case "${o}" in
		c)	configfile=${OPTARG}
			if [[ ! -r ${configfile} ]]; then
				echo "Cannot read ${configfile}" 1>&2
				usage 1
			fi
			;;
		h)	usage 0	;;
		*)	usage 1	;;
	esac
done
shift $((OPTIND-1))


. ${configfile}

: ${lab:?}
: ${fileserver:?}
# ${srvport}
: ${expname:?}
: ${basedir:=$(pwd)}
: ${download:?}
: ${sampleset:?}
: ${working:=working}

target=consensus_sequences

[[ "${1}" == '-h' || "${1}" == '--help' ]] && usage 0

if [[ ! -d ${basedir}/${download}/ ]]; then
	echo "missing directory ${download}" >&2
	exit 1
elif [[ ! -d ${basedir}/${working}/ ]]; then
	echo "missing working ${working}" >&2
	exit 1
fi

lastmonth=$(date '+%Y%m' --date='-1 month')
month3ago=$(date '+%Y%m%d' --date='-3 month')

mkdir -p ${basedir}/${download}/${target}
cd ${basedir}
error=0
tsvs=( )
for byml in $(grep -l "lab: ${lab}" ${sampleset}/batch.*.yaml); do
	if [[ ! $byml =~ batch\.(20[[:digit:]]{2}[01][[:digit:]][0-3][[:digit:]]_[[:alnum:]]{4,})\.yaml$ ]]; then
		echo "cannot parse $byml name" >&2
		error=1
		continue
	fi
	batch=${BASH_REMATCH[1]}

	if [[ ${lastmonth} > ${batch} ]]; then
		echo "skipping ${batch}"
		continue
	fi
	echo "batch: ${batch}"

	tsv="${sampleset}/samples.${batch}.tsv"
	if [[ ! -r ${tsv} ]]; then
		echo "Cannot read ${tsv}"
		error=1
		continue
	fi

	tsvs+=( ${tsv} )
done

if (( ${#tsvs[@]} == 0 )); then
	echo "Nothing to do"
	exit $error
fi

cat "${tsvs[@]}" | while read sample batch len; do
	cp --link -vrf ${working}/samples/${sample}/${batch}/references/ref_majority_dels.fasta ${download}/${target}/${sample}-${batch}.fasta || error=1
done

(( error )) && exit 0

./upload_sftp -c ${configfile} ${target} && exec ./purge_sftp_fasta -r ${month3ago} -c ${configfile} ${target}
