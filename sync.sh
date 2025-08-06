scriptdir=/links/shared/covid19-pangolin/backup/automation_backups/pangolin
. ${scriptdir}/server.conf
mypart=$1
for i in $(cat $mypart); do
	echo ${i};
	rsync --timeout=${iotimeout} \
		--password-file ~/rsync.pass.euler \
		-e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} -oConnectTimeout=${contimeout}" \
		-izrlH --fuzzy --inplace \
		-p --chmod=Dg+s,ug+rw,o-rwx \
		-g --chown=:"${storgrp}" \
		belfry@euler.ethz.ch::${bfabric_downloads}/${bfabric_project}/${i} \
		${basedir}/${bfabric_downloads}/${bfabric_project} 
done
