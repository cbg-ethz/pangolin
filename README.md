# pangolin

This is a [SARS-CoV-2 sequencing project done at the BSSE](https://ethz.ch/en/news-and-events/eth-news/news/2020/04/analyses-for-getting-to-grips-with-the-pandemic.html)
relying on [V-pipe](https://cbg-ethz.github.io/V-pipe/sars-cov-2/) ([doi:10.1093/bioinformatics/btab015](https://doi.org/10.1093/bioinformatics/btab015))
to analyse Illumina data done on [positive swabs test samples](https://bsse.ethz.ch/cevo/research/sars-cov-2/swiss-sequencing-consortium---viollier.html)
for the [genomic surveillance of the COVID-19 pandemic in Switzerland](https://sciencetaskforce.ch/en/nextstrain-phylogenetic-analysis/)
and on [wastewater samples](https://bsse.ethz.ch/news-and-events/d-bsse-news/2021/01/sars-cov-2-variants-detected-in-wastewater-samples.html)
provided by [EPFL](https://actu.epfl.ch/news/covid-19-using-wastewater-to-track-the-pandemic/) and [Eawag](https://www.eawag.ch/en/department/sww/projects/sars-cov2-in-wastewater/).

## pipeline

for the V-pipe pipeline, see:

 - tutorial: https://cbg-ethz.github.io/V-pipe/tutorial/sars-cov2/ ([video tutorial](https://youtu.be/pIby1UooK94))
 - SARS-CoV-2 subpage: https://cbg-ethz.github.io/V-pipe/sars-cov-2/
 - main website: https://cbg-ethz.github.io/V-pipe/
 - github repo: https://github.com/cbg-ethz/V-pipe

## wastewater

for the code used in wastewater analysis, see:

 - https://github.com/cbg-ethz/cojac


## video presentation

Short Oral presentation done at the [ECCVID conference in September 2020](https://www.escmid.org/research_projects/escmid_conferences/past_escmid_conferences/eccvid/):

 - https://youtu.be/BJ-un88CT9A

## automation

the automation is a collection of scripts connected together by a loop that is configured to monitor, log and kickstart all necessary processes. The automation is completely dockerized.

The automation runs on VM `wisedb.nexus.ethz.ch`. Access is granted by the VM administrators and uses the ETH LDAP credentials.

The docker container dedicated to run the automation is named `revseq-revseq-1` and runs indefinitely in an internal loop.

### Setup

#### Pre-requisites
- [Docker engine](https://docs.docker.com/engine/install/)

#### Configuration
Automation configuration relies on the file `pangolin_src/config/server.conf`. The file contains all necessary variables for the automation, fully commented for clarity.

Please refer directly to the file to define directories and automation behaviors as necessary.

#### Resources and secrets
The automation relies on a set of resources and secret to successfully connect to external services. The necessary files are as follows:
- a `resource` directory with the files
    - `config`, the ssh config file with an entry for the FGCZ sftp server
    - `id_ed25519_spsp_uploads.pub`, the public key to connect to SPSP for the uploads
    - `id_ed25519_wisedb_backups.pub`, the public key to connect to bs-bewi08 for the backups
    - `id_ed25519_wisedb.pub`, the main public key used by the container to connect to external services
    - `id_euler_ed25519.pub`, the public key to connect to Euler's rsync daemon
    - `known_hosts`, the ssh file containing the accepted public keys of the FGCZ SFTP server, euler and bs-bewi08. The remaining hosts are automatically added during the container deployment
- a `secrets` directory with the files
    - `bs-pangolin@d@bs-bewi08`, a file wih the credentials to login to bs-bewi08
    - `bs-pangolin@euler.ethz.ch`, a file wih the credentials to login to Euler
    - `ABC9FC14AAC952E7767FD14A48B70E724BAFE0A3.asc`, the GPG key provided by SPSP for the uploads. Please refer to [SendCrypt manual](https://gitlab.sib.swiss/clinbio/sendcrypt/sendcrypt-cli/-/tree/main?ref_type=heads) for further details
    - `bs-pangolin_spsp-uploads_gpg-key.gpg`, the GPG created locally for the SPSP uploads. Please refer to [SendCrypt manual](https://gitlab.sib.swiss/clinbio/sendcrypt/sendcrypt-cli/-/tree/main?ref_type=heads) for further details
    - `default.sendcrypt-profile`, the profile to use for the SPSP uploads
    - `fgcz-gstore.uzh.ch`, a file with the credentials to login to the FGCZ SFTP server
    - `gpg_key_secrets`, a file containing the password of the local GPG key for the SPSP uploads
    - `id_ed25519_spsp_uploads`, the private key to connect to SPSP for the uploads
    - `id_ed25519_wisedb` the main private key to connect to external services
    - `id_ed25519_wisedb_backups`, the private key to connect to bs-bewi08 for the backups
    - `id_euler_ed25519`, the private key to connect to Euler
    - `rsync.pass.euler`, the password to access the rsync daemon on Euler

#### Docker configuration

docker-compose needs to be adapted to the host machine filesystem for a successful deploy. Sections `services-pangolin-build-context`, `service-pangolin-volumes` and `secrets` rely on host absolute paths and are currently configured to run on the dedicated VM

### Deployment

It is suggested to deploy the automation using `docker-compose up --detach`

### Steps

The automation loop is started by `quasimodo.sh` which is in charge of running `carillon.sh` every loop. `carillon.sh` code can be divide in multiple phases.

1. Data Sync:
    - Provided the sync is activated in the configuration, the script runs a forced command on Euler using the script `batman.sh`, starting an rsync job that syncs any new raw data from FGCZ SFTP server to Euler directory `bfabric-downloads`
    - The exit status of the sync procedure is downloaded from Euler and checked for success before running the next procedure
    - The script runs a forced command on Euler to execute `sort_samples_bfabric.py` through the command `belfry.sh sortsamples --recent`. The command checks the consistency and completeness of the synced plates and creates the directory structure necessary for Vpipe
2. Vpipe run check:
    - The automation checks if any Vpipe run is ongoing on Euler and logs the status
    - If there is no ongoing Vpipe run, the results are backupped on bs-bewi08
    - If there is no ongoing Vpipe run, the latest batch successfully analysed by Vpipe is added to the queue of samples to upload to SPSP
3. Start Vpipe run:
    - If the previous steps detected and successfully handled a new full plate to analyse and there is no ongoing Vpipe run on Euler, the automation submits a new Vpipe job on Euler to analyse the new data and logs the new submission
4. VILOCA run check:
    - The automation checks if any VILOCA run is ongoing on Euler and logs the status
    - If it detects the previous VILOCA run as ended because of TIMEOUT, the VILOCA snakemake directory is unlocked and the run is retried
    - If there is no ongoing VILOCA run, the results are backupped on bs-bewi08
5. Start VILOCA run:
    - If the Vpipe logs shows a new batch successfully analysed by Vpipe and there is no ongoing VILOCA run on Euler, the automation submits a new VILOCA job on Euler using a forced command to analyse the new data and logs the new submission
6. Upload samples to SPSP:
    - The automation keeps track of the number of files submitted to SPSP and the estimated total size uploaded for any day. As first step, the automation checks if the quotas set in the configuration are reached, before attempting any upload
    - If no quota is reached and the uploads are activated, the automation triggers the upload scripts.
        - The scripts take in input a full list of samples to upload and a list of samples that have been already uploaded
        - A temporary list of samples to upload is generated and used to download from Euler the related cram files
        - using the file `uploader/submission_metadata.py`, an SPSP metadata line is created for each sample to submit. Metadata lines are sanity checked before submission and the procedure will fail if provided unexpected samples
        - The directory containing the cram files and the metadata is submitted to SPSP using the provided tool SendCrypt
        - The temporary folders created by SendCrypt are deleted
        - The metadata and logs from the submission are archived and backupped to bs-bewi08
7. Amplicon coverage:
    - If the Vpipe logs shows a new batch successfully analysed by Vpipe, the automation triggers the scripts necessary to calculate the amplicons coverage using a forced commands
    - The results (a csv table of the coverage per amplicon and a heatmap visualization of the table) are backupped on bs-bewi08
