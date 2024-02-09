#!/bin/bash


usage() { echo "Usage: $0 -s
	-s : singleshot - stops at the first loop if it fails
	-h : this help" 1>&2; exit $1; }

singleshot=0
while getopts "sh" o; do
	case "${o}" in
		s)	singleshot=1   ;;
		h)	usage 0	;;
		*)	usage 1	;;
	esac
done

scriptdir=/app/pangolin_src
. ${scriptdir}/config/server.conf
runtimeout=3600
shorttimeout=300

ring_carillon() {
	now=$(date '+%Y%m%d')
	newtimeout=$(timeout -k 5 -s INT ${shorttimeout} grep -oP '(?<=^runtimeout=).*$' config/server.conf)
	if [[ -n "${runtimeout}" ]]; then
		runtimeout=${newtimeout}
	fi
	if timeout -k 5 -s INT ${shorttimeout} touch b0rk && [[ -f b0rk ]]; then
		rm b0rk
	else
		echo "Aargh: problem writing on storage !!!"
		# TODO use carillon phases
		${scriptdir}/belfry.sh  df
		cluster_user="${USER%%@*}"
		cluster_user=$(timeout -k 5 -s INT ${shorttimeout} grep -oP '(?<=^cluster_user=).*$' config/server.conf)
		remote_batman="ssh -o StrictHostKeyChecking=no -ni ${HOME}/.ssh/id_ed25519_batman -l ${cluster_user} euler.ethz.ch --"
		timeout -k 5 -s INT $shorttimeout ${remote_batman} df
		date -R
		return 1
	fi
	# run the carrillon script
	echo "Starting loop for: $runtimeout sec"
	timeout -k 5 -s INT $runtimeout ${scriptdir}/carillon.sh | tee -a ${statusdir}/carillon/carillon_${now}.log
	local retval=$?
	timeout -k 5 -s INT $shorttimeout touch ${statusdir}/loop_done

	# report NFS status
	#dmesg -LTk| grep -P 'nfs:.*server \S* (OK|not responding)' --colour=always|tail -n 1

	return $retval
}


stopfile="${statusdir}/stop"

# remove previous abort file
if [[ -e "${stopfile}" ]]; then
	echo "(removing previous stop file)"
	rm "${stopfile}"
fi

echo 'First run...'
ring_carillon || (( singleshot == 0 )) || exit 1

while sleep 1200; do 
	# re-enter directory (in case a NFS crash has rendered the previous CWD handle stale)
	workpath=$(dirname $(which $0))
	cd ~
	cd "${workpath}"

	echo 'loop...'
	#######/usr/bin/kinit -l 1h -k -t $HOME/$USER.keytab ${USER%@*}@D.ETHZ.CH;
	ring_carillon

	# check for abort
	if [[ -e "${stopfile}" ]]; then
		rm "${stopfile}"
		exit 0
	fi

	date -R;
done
