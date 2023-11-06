#!/usr/bin/env bash

# set -euo pipefail
set -uo pipefail

batch_to_upload=$1
source vars.sh

{

cat<<EOF
To:  ${mailrecipients}
Subject: spsp wastewater data upload
MIME-Version: 1.0
Content-Type: text/html
Content-Disposition: inline
<html>
<body>
<pre style="font: monospace">
EOF

if [ ! -d ${euler} ]
then
	echo "ERROR: cannot access the Euler mount"
	exit 8
fi
if [ ! -d ${workdir} ]
then
	echo "ERROR: cannot access the working directory"
	exit 9
fi

./prepare.sh $batch_to_upload

archive_now="${archive}/$(date +"%Y-%m-%d"-%H-%M-%S)"
mkdir $archive_now

${maindir}/upload.sh ${archive_now}
cat ${archive_now}/uploaded_run.txt >> ${uploaded} 

echo
echo

echo ${batch_to_upload}

echo "<br/>"
echo "<br/>"

cat<<EOF
</pre>
</body>
</html>
EOF


} 2>&1 | /usr/sbin/sendmail -t carrara@nexus.ethz.ch

