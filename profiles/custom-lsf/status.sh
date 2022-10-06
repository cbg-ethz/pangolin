#!/usr/bin/env bash

#RXJOB='Job <([[:digit:]]+)> is submitted'
RXJOB='<([[:digit:]]+)>'

if [[ "$*" =~ $RXJOB ]]; then
	J="${BASH_REMATCH[1]}"
else
	echo "Cannot find JobID in '$*'" > /dev/stderr
	exit
fi

state="$(bjobs $J | gawk -v I=$J '$1==I{print $3}')"

case "${state}" in
	EXIT)
		echo "failed"
	;;
	DONE)
		echo "success"
	;;
	RUN)
		echo "running"
	;;
	PEND)
		echo "running"
	;;
	*)
		echo "Weird status ${state}" > /dev/stderr
		echo "running"
	;;
esac

exit 0
