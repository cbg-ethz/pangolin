# pangolin
This is the Influenza adaptation of the pangolin project based on the commit 794dc7c of the rsv_automation branch.
[Main Branch](https://github.com/cbg-ethz/pangolin)
[rsv_automation branch](https://github.com/cbg-ethz/pangolin/tree/rsv_automation)

This is a Influenza sequencing project done at the BSSE relying on [V-pipe](https://cbg-ethz.github.io/V-pipe/sars-cov-2/) ([doi:10.1093/bioinformatics/btab015](https://doi.org/10.1093/bioinformatics/btab015))
to analyse Aviti data done on [wastewater samples](https://bsse.ethz.ch/news-and-events/d-bsse-news/2021/01/sars-cov-2-variants-detected-in-wastewater-samples.html)
provided by [Eawag](https://www.eawag.ch/en/department/sww/projects/sars-cov2-in-wastewater/).

## pipeline

for the V-pipe pipeline, see:

 - tutorial: https://cbg-ethz.github.io/V-pipe/tutorial/sars-cov2/ ([video tutorial](https://youtu.be/pIby1UooK94))
 - SARS-CoV-2 subpage: https://cbg-ethz.github.io/V-pipe/sars-cov-2/
 - main website: https://cbg-ethz.github.io/V-pipe/
 - github repo: https://github.com/cbg-ethz/V-pipe

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
    - `id_ed25519_rsv_backups.pub`, the public key to connect to bs-bewi08 for the backups
    - `id_ed25519_rsv.pub`, the main public key used by the container to connect to external services
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
    - `id_ed25519_rsv` the main private key to connect to external services
    - `id_ed25519_rsv_backups`, the private key to connect to bs-bewi08 for the backups
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

# Processing
## Sample collection
Samples from the WWTPs under surveillance are collected by Eawag during a week, usually from Tuesday afternoon to the next Tuesday morning. Frequency of collection and number of WWTPs under surveillance depend on the current terms of agreement. Eawag prepares the samples and ships them to the sequencing center (FGCZ) on Tuesday.

## Sequencing
FGCZ receives the samples, completes the library prepapration and the sequencing. The sequencing platform and library prep kit used change depending on the available technologies and the scientific evidence on the detection efficiency of SARS-CoV-2.

## Raw data retrieval
Raw sequencing results are delivered by FGCZ to their LFTP server. The automation regularly checks the server for new data to process. If new data is available, the entire delivery is mirrored on Euler, checked for consistency with the metadata, and V-pipe is ran on the samples. The automation is able to differentiate between Aviti and NextSeq sequencing and run V-pipe with the specific settings.

## Lollipop (temporary)
The current automated V-pipe analysis does not include the Lollipop deconvolution steps. Until those steps are integrated in the automated V-pipe run, Lollipop needs to be manually ran.

To do so, a user is required to wait for the automated Slurm email confirming that a run on a new batch has successfully completed, then run the script `cowabunga.sh` to hardlink the necessary data to the dedicated Lollipop directory. More specifically, the two commands to run are:
- `./cowabunga.sh autoaddwastewater year` to list all batches received in the current year and update the sample list with the samples from the new batches
- `./cowabung.sh bring_results` to hardlink the necessary V-pipe output to the Lollipop directory `work-vp-test` in preparation of the Lollipop run

After running `cowabunga.sh`, the user can navigate to the working directory `work-vp-test` and run Lollipop using the command `sbatch vpipe-test.sbatch`.

## Postprocessing
Lollipop results need to be postprocessed to generate and visualize the curves, as well as share the results with BAG.

Similarly to the automated V-pipe step, Lollipop reports the status of a run through automated slurm emails. If a Lollipop run is succesful, the post-processing can start.

All postprocessing happens on a dedicated machine called `jupyterhub05`. The machine runs a jupyter notebook server pre-configured with the necessary kernels. Kernels definitions are available on the server. The necessary notebooks are `ww_cov_uploader_V-pipe` and `ww_cov_SwitzerlandMap`.

- `ww_cov_uploader_V-pipe` loads the deconvolution and tallymut results, processing them for plotting and upload
    - A user needs first to run the notebook up until the cell `Multiple choice time`. The curves preview should then be shared for review before proceeding
        - If the review finds abnormalities, the cell `db.rollback()` should be run to cancel any update to the cov-spectrum database
        - If the review finds no abnormalities, the cell `db.rollback()` should be *skipped* and the remainder of the notebook can be run, committing the changes to the cov-spectrum database and uploading the results on Polybox for BAG and for the public
- `ww_cov_SwitzerlandMap` loads the deconvolution and tallymut results, processing them for plotting cake plots with the average relative abundances for the week on each WWTP on a map of Switzerland
    - The plot needs to be included in the email reports. The plot caption can be copy-pasted from previous weeks unless the method or the WWTPs change

After running both notebooks, the email report can be written. The mandatory content is as follows:
- Last collection date available for each WWTP. This information is provided as output of the early cells of the notebook `ww_cov_uploader_V-pipe`
- Comment on the current status, mentioning the dominant variant (if any) and the observable relative abundance trends
- Signature
- Switzerland map plot with its caption

The email report must be reviewed by an additional person before submission. Submission should be done by sending the email to the dedicated mailing list.
