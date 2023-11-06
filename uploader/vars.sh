#main uploader directory
maindir=/home/bs-pangolin/wastewater_setup/uploader
#working directory for the uploader scripts
workdir=/data/backup/wastewater/uploads
#temporary directory for files that should be dropped or overwritten between runs
tempdir=${workdir}/temp
#position of the Euler mount
euler=/mnt/cluster
#the Euler "samples" directory position on the local mount
fldr=${euler}/working/samples
#staging directory with the structure expected by the SPSP SendCrypt CLI tool
staging=${euler}/ww_uploads_archive/staging
#sub directory of the staging directory where the files to upload should be copied
target=$staging/viruses/wastewater-uploads
#archival directory for the upload files
archive=${euler}/ww_uploads_archive
#location of the full list of uploaded samples
uploaded=${archive}/all_uploaded.tsv
#the Euler directory containing the sampleset files
sampleset=${euler}/sampleset
#recipients to which send the email about the upload
mailrecipients=carrara@nexus.ethz.ch
# file containing the list of batches still to be uploaded
uploadlist=${workdir}/batches_to_upload.txt
# file containing the list of batches already uploaded
uploadedbatches=${archive}/uploaded_batches.txt
