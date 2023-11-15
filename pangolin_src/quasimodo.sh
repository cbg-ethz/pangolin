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

#do_the_drop() {
#	# TODO move this into a root user's forced-command with an SSH key
#	echo 3 | sudo tee /proc/sys/vm/drop_caches
#}

#drop_cache() {
#	echo dropping cache
#	printf '[%u]\t[%s]\tdrop cache reason:\t%s\n' "$(date --utc '+%s')" "$(date --rfc-3339=seconds)" "${1}" >>drop_cache.log
#
#	# empty some cache
#	do_the_drop
#	printf '[%u]\t[%s]\tcache droped\n' "$(date --utc '+%s')" "$(date --rfc-3339=seconds)" >>drop_cache.log
#
#	# sync the buffer to have more to drop
#	synctimeout=$(timeout -k 5 -s INT ${shorttimeout} grep -oP '(?<=^synctimeout=).*$' config/server.conf)
#	if [[ -z '$synctimeout' ]]; then
#		synctimeout=$runtimeout
#	fi
#	if (( synctimeout > 0)); then
#		if timeout -k 5 -s INT $synctimeout sync; then
#			printf '[%u]\t[%s]\tsynced (< %u s)\n' "$(date --utc '+%s')" "$(date --rfc-3339=seconds)" "${synctimeout}" >>drop_cache.log
#		else
#			printf '[%u]\t[%s]\tsync timed out (>= %u s)\n' "$(date --utc '+%s')" "$(date --rfc-3339=seconds)" "${synctimeout}" >>drop_cache.log
#		fi
#	else
#		sync
#		printf '[%u]\t[%s]\tsynced (long-wait)\n' "$(date --utc '+%s')" "$(date --rfc-3339=seconds)" >>drop_cache.log
#	fi
#
#	# drop the extra freed by sync
#	do_the_drop
#	printf '[%u]\t[%s]\tcache droped\n' "$(date --utc '+%s')" "$(date --rfc-3339=seconds)" >>drop_cache.log
#}

ring_carillon() {
	newtimeout=$(timeout -k 5 -s INT ${shorttimeout} grep -oP '(?<=^runtimeout=).*$' config/server.conf)
	if [[ -n "${runtimeout}" ]]; then
		runtimeout=${newtimeout}
	fi
	## kill any remaining rsync
	#if killall -3 rsync; then
	#	echo killing stuck rsync processes
	#	sleep 10
	#	if killall rsync; then
	#		sleep 10
	#		killall -9 rsync
	#	fi
	#	# drop the cache (in case it help getting rsync processes unstuck
	#	#drop_cache 'lingering rsync'
	#else
	#	nfsmsg="$(dmesg -Lk | gawk -vT=$(($(date '+%s' --date="-${runtimeout} seconds") - $(date '+%s' --date="$(uptime --since)"))) '(substr($1,2)+0)>=(T+0) && $0~/nfs:.*not responding/')"
	#	if [[ -n "$nfsmsg" ]]; then
	#		echo "Since: $(date  --rfc-3339=seconds --date="-${runtimeout} seconds")"
	#		echo "$nfsmsg"
	#
	#		# drop the cache (in case of non-responding server)
	#		#drop_cache "nfs not responding since ${runtimeout} sec ago"
	#	fi
	#fi
	# check if inode limitation "No spoace left on device" is still going on
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
	timeout -k 5 -s INT $runtimeout ${scriptdir}/carillon.sh
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
