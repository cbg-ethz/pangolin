# Pangolin
Pangolin is an automation primarily designed to monitor the upload of new samples to B-fabric, and subsequent alignment of these samples to a reference genomes with the help of V-pipe. When new samples are detected, Pangolin automatically synchronizes them to Euler for downstream processing. Once the samples are synced, V-Pipe is executed to process the data, and both the samples and results are backed up to Bewi08.


In addition to its automated processes, Pangolin also offers some manual (not yet automated) functionalities. 
One such feature is Lollipop, which is used for the deconvolution step in virus analysis.

The automation is organized into three main subfolders:

- pangolin_src: Contains the source code for Pangolin.
- uploader: Handles the synchronization of uploaded samples.
- working: Manages intermediate processes and data handling. --> pangolin/woking = NOT IN UNSE ANYMORE / ARTEFACT
   - the ../woking is used as working directory, not pangolin/working

#### General Logic
The autoamtion is started by launching it's docker container on the wiseDB VM and interacts with Euler (sHPC) and databases such as b-fabric and SPSP.
Additionally backups are done on the bewi08 VM.


**Status Files**
Generally status files are created directly on wisedb in `workdir/status. If a command is executed on euler (with the batman.sh script) status files are created on euler and synced to wisedb.

# Main Working Folders
**V-pipe**
There is one v-pipe installation which is called from everywhere (all the viruses): '/cluster/project/pangolin/V-pipe'

**work-vp-test**
Working folder to run lollipop for covid. Points also at '/cluster/project/pangolin/V-pipe'. This should be included in the future in pangolin/working (main covid working directory).


**Covid**
The SARS CoV19 directory where the regular analysis takes place (lollipop) is `/cluster/project/pangolin/work-vp-test`
   - corresponding blacklist: `/cluster/project/pangolin/lollipop_blacklist.txt`
- the vpipe is run in : `/cluster/project/pangolin/working` (go here to check the slurm-out of vpipe)
   - in the slurm-out (main) it tells you which batches it checks for new samples, but this does not mean that it runs on all of these batches, it only checks if there are samples that have not yet been aligned by v-pipe!
- config files for covid vpipe: `/cluster/project/pangolin/test_automation/pangolin/pangolin_src`

#### Automation
The folder for the covid autoamtion on euler is: '/cluster/project/pangolin/test_automation/pangolin'
'/cluster/project/pangolin/test_automation' is the main folder in the covid automation. However, the working in test_automation is outdated and we use '/cluster/project/pangolin/working'.
In this working folder there is also the results directory (huge directory which sould not me copied!) - this will be restructured soon.


**RSV**
For RSV it is `/cluster/project/pangolin/rsv_pipeline`

**Influenza**
For Influenza it is `/cluster/project/pangolin/influenza_pipeline/`


## Bad List 
**For Covid, Influenza and RSV!!**
(similar to blacklist for covid-lollipop but here we define it for the fgcz downloads!)
- in pangolin/pancoling_scr/config there is a fgcz.yaml file where there is a badlist specified
- put the delivery name (order) in this list
- you can find the delivery name associated to the batch in sampleset folder: batch.BATCHNAME.tsv

Covid: `/cluster/project/pangolin/test_automation/pangolin/pangolin_src/config/fgcz.conf`



**samples download from bfabric**
`/cluster/project/pangolin/sampleset`

# Main Folders General Structure
## pangolin_src
This folder contains all the code that is used during the automation. The automation constantly runs in the background and tries to check if there are new samples uploaded to bfabric. If there are new samples, it fetches them and automatically starts vpipe (the alignment). 

In the folder are several scripts to run the Automation. Once the docker image  is created the first script that is celled is entrypoint.sh which then further distributes the tasks and starts the automation.


### entrypoint.sh
The `entrypoint.sh` script in the `flu_automation` branch of the `cbg-ethz/pangolin` repository is designed to set up necessary credentials and configurations for the automation of influenza sequencing processes. It performs the following key actions:

1. **Credential Setup:** Copies various secret files, such as SSH keys and configuration files, into appropriate directories to establish secure connections with external servers and services.

2. **Host Verification:** Adds the SSH keys of specific hosts to the `known_hosts` file, ensuring that the system recognizes and trusts these hosts during SSH connections.

3. **GPG Key Configuration:** Imports GPG keys required for secure data uploads, particularly to the Swiss Pathogen Surveillance Platform (SPSP).

By executing these steps, the script prepares the environment for automated data processing and secure communication with external platforms.

### quasimodo.sh
This script is designed to run a monitoring process called "carillon" in a loop, with some additional checks and configurations to handle potential issues like storage problems or system crashes. Here's a breakdown of what the script does:

1. **Command Line Options**:
   - The script accepts two command line options: `-s` for singleshot mode (which stops the script after the first failure) and `-h` for help information.
   - By default, `singleshot` is set to `0`, meaning the script will continue looping even if there are failures.

2. **Initialization**:
   - The `scriptdir` variable is set to point to the directory `/app/pangolin_src`, which contains the necessary configuration and scripts.
   - The script sources a configuration file (`server.conf`) from this directory, which contains key-value pairs that the script uses for further actions.

3. **Timeout Configuration**:
   - Default values for `runtimeout` and `shorttimeout` are set to 3600 seconds and 300 seconds respectively.
   - The `ring_carillon` function is defined to perform the main operations, including reading a new value for `runtimeout` from the configuration file if available.

4. **Function `ring_carillon()`**:
   - This function is responsible for running the carillon monitoring process.
   - It first sets up a new timeout value by reading from the configuration file.
   - A temporary file (`b0rk`) is created to test if writing to storage works. If this test fails, it executes commands to troubleshoot and prints an error message.
   - If the storage test is successful, it runs the `carillon.sh` script for the duration of `runtimeout` and logs its output. The results are saved in a log file named according to the current date.
   - It then creates a file (`loop_done`) to indicate the completion of a loop.

5. **Handling Previous Stop Files**:
   - If there is a stop file (`${statusdir}/stop`) from a previous run, it removes this file, indicating that the process should start afresh.

6. **First Run**:
   - The `ring_carillon` function is called for the first run. If singleshot mode is enabled and the first run fails, the script exits.

7. **Main Loop**:
   - The script enters a loop that runs indefinitely with a sleep interval of 1200 seconds (20 minutes).
   - Within the loop:
     - It re-enters the script directory, which is necessary if an NFS crash makes the current working directory inaccessible.
     - The `ring_carillon` function is called again.
     - It checks if the stop file exists (`${statusdir}/stop`). If the stop file is found, it exits the loop gracefully.
     - The current date is printed in RFC 2822 format after each loop.

8. **Kerberos Ticket Renewal (Commented Out)**:
   - There is an optional command for renewing a Kerberos ticket, which is currently commented out. This may be necessary for authenticating with certain systems in the environment where the script runs.

**Summary:**

This script is intended to monitor a system or application in a repetitive manner using the "carillon" process. It has features to:
- Handle failures in storage operations.
- Periodically renew its running state to avoid stale directory handles (especially useful in networked file systems).
- Manage failure conditions and exit appropriately based on whether singleshot mode is enabled.
- It logs its operations and attempts to self-correct in case of errors.

The script is designed for an environment with potential network storage (NFS) and remote server access, and it takes measures to ensure that it can continue functioning even when minor errors or crashes occur.

### carillon.sh
The script is an automation tool designed to perform a series of tasks for managing data processing and analysis runs on a remote computing cluster. Here's a detailed breakdown of what the script does:

1. **Initialization**
   - The script starts by defining paths, sourcing a configuration file, and setting default values.
   - It also sets up environment variables for SSH connections to remote servers for both the main cluster and backup.

2. **Directories and Permissions Setup**
   - Necessary directories (`statusdir`, `viloca_statusdir`, etc.) are created, and permissions are managed with `umask` to ensure group write access.
   - A status file (`oh_hai_im_looping`) is created to indicate that the script is running.

3. **Phase 0: General Information**
   - This phase prints general information about the automation run, including the current script commit for tracking versions.

4. **Phase 1: Data Synchronization**
   - **Data Sync**: The script syncs data from the FGCZ (Functional Genomics Center Zurich) using a remote command (`sync_fgcz`).
   - **Error Handling**: If the sync fails, the script indicates that the automation will not be aware of new deliveries.
   - **Backup**: If configured (`backup_fgcz_raw` set to `1`), it also performs a backup of recent data.
   - **Sample Sorting**: The script sorts samples depending on the type (e.g., Aviti or Illumina) and the current date. It then pulls the sorting status to check for any issues.

5. **Phase 2: Update Status of Current Run and Trigger Backups**
   - **Check Current Run**: The script checks if a V-Pipe process is currently running by reading from the `vpipe_started` file.
   - **Handle Running Jobs**: If a job is still running (`RUNNING`, `PENDING`, etc.), it prints the status, otherwise, it proceeds to mark it as finished.
   - **Trigger Backup**: If no jobs are running and if backups are enabled (`backup_vpipe` set to `1`), it triggers a backup of the samples.
   - **Queue for Upload**: If the current run is complete, the last processed batch is queued for upload using the script’s `queue_upload` feature.

6. **Phase 3: Restart V-pipe Runs if New Data**
   - **Check for New Data**: The script checks if there are new data batches that need to be processed.
   - **Identify Missing Samples**: It iterates over all available sample sets to identify batches that need to be processed, filtering by date (`limit` is set to two weeks ago).
   - **Sanity Checks and Starting Jobs**:
     - The script verifies if all required data are available.
     - If there are jobs that should be started and job submissions are allowed (`donotsubmit` not set), it starts the necessary jobs, potentially skipping certain types of runs (e.g., Aviti or Shorah) based on configuration flags.

    **Handling Jobs and Submission**
   - **Run Parameters**: The script determines whether to run the Shorah analysis, skip Aviti, or include other flags as required.
   - **Start Jobs**: It runs commands to add samples and start V-Pipe, tagging them with batch information.
   - **Notify Users**: If configured, it sends emails to notify users about new runs and samples that are being processed.


7. **Phase 4 & 5: Viloca**
- TODO

8. **Phase 6: Uploader to SPSP and Backup to bs-bewi08**
   - **Quota Check**:
      - Reads or initializes the daily status file to track the number of samples uploaded.
      - Calculates the current and estimated upload size and compares it against daily limits (sample count and total upload size).

   - **Upload Execution**:
      - If the upload request exceeds quotas, it defers the upload to the next day.
      - If within quotas, it starts the upload process using the `belfry.sh upload` script and updates the status file with the new total.

   - **Backup**:
      - If enabled, backs up the results of the upload to a backup server and logs the status of the backup operation.
      - Handles both successful and failed backup attempts.


9. **Phase 7: Amplicon Coverage**
- TODO

 

### belfry.sh 
Batch Processing Script - 
Helper functions for carillon.sh (VM interaction / data sync)
 
 **Rsync Commands**:
  - The script uses `rsync` to manage the transfer of data between local and remote servers.
  - SSH keys are used for authentication, and `timeout` ensures no command runs indefinitely.
  - Exclude patterns are used to filter out unnecessary files and directories, which is important for optimizing network usage and focusing on relevant data.

 **Directory and File Operations**:
  - The script has specific routines for managing directories and file permissions, including using `umask` and `mkdir` with `mode` settings to ensure that directories are created with appropriate permissions for group collaboration.

1. **Initial Setup**
   - **Set Variables**: 
     - It sets up different date variables (`now`, `lastmonth`, etc.) to help manage data according to different timeframes.
     - Uses `date` or `gdate` based on the operating system to handle date calculations.
   - **Environment Setup**:
     - Loads configuration from `server.conf` to get key variables.
     - Defines default values for important variables, such as directories (`basedir`, `sampleset`), parallel processing settings (`parallel`, `parallelpull`), and others.
   - **Permissions**:
     - Sets default file creation permissions using `umask 0002`, ensuring group write access.

2. **Directory Setup**
   - Creates directories (`statusdir`, `viloca_statusdir`, `uploader_statusdir`) required for the script’s execution, using `mkdir` with the optional `mode` parameter if it is defined.

3. **Validation Functions**
   - **`validateBatchDate()`**:
     - Ensures that the provided batch date is in the correct format (`YYYYMMDD`). Exits with an error message if not.
   - **`validateBatchName()`**:
     - Validates that the batch name follows the expected format (`YYYYMMDD_<alphanumeric>`).

4. **Data Synchronization Functions**
   - **`callpushrsync()`**:
     - This function synchronizes files from a local directory to a remote server using `rsync`. It constructs arguments based on the provided inputs and appends the correct directory paths.
     - Uses SSH for authentication and sets up file permissions for the remote server.
     - `timeout` ensures the command terminates if it exceeds a defined time.
   - **`callpullrsync_fordb()`**:
     - Similar to `callpushrsync()`, but used for pulling files from the remote server to a local destination. It excludes specific directories to avoid unnecessary data transfers (e.g., `alignments/`, `raw_data/`).
   - **`callpullrsync_viloca()`**:
     - A specialized function for pulling VILOCA results from the remote server. It uses `rsync` and also supports timeouts and SSH authentication.

5. **Sync Helper Function**
   - **`checksyncoutput()`**:
     - Parses the output of the `rsync` command to determine if new files were downloaded and updates status files accordingly.
     - Uses a regular expression to match and extract data from the output, and uses `flock` to prevent race conditions while writing to files.

6. **Main Command Handler**
   - Handles different commands passed to the script as arguments (`$1`). Based on the command, it performs various tasks:
     
     - **`qa_report`**:
       - Activates a conda environment named `qa_report` and runs a Python script (`qa_report.py`) to generate a quality assessment report.
       - If successful, it updates a status file; otherwise, it logs failure.
     
     - **`pushseq`**:
       - Activates a conda environment (`wastewater`) and runs a script (`upload_viollier`) to push sequencing data. Updates status files based on success or failure.

     - **`gitaddseq`**:
       - Activates the `wastewater` conda environment and adds sequencing files (`*.fasta`) and QA files to a git repository for version control.
     
     - **`df`**:
       - Displays the disk usage information of the base directory, including inode usage.

     - **`garbage`**:
       - Moves a specified batch to a "garbage" directory for cleanup. Validates the batch name and moves all related data files from both the sampleset and working directories to the garbage folder.
     
     - **`pull_sync_status`**:
       - Uses `rsync` to pull updated status information for raw data synchronization from the remote server.
       - Logs success or failure to status files.

      - **`pull_sortsamples_status`**
      - **`pushsamplelist_viloca`**
      - **`queue_upload`**
      - **`upload`**
      - **`clean_sendcrypt_temp`**
      - **`pullsamples_for_db`**
      - **`backup_uploader`**

7. **Error Handling and Safety Features**
   - **`set -e`**: 
     - Ensures that the script exits immediately if any command fails. This is a safety feature to avoid continuing operations if something goes wrong.
   - **`timeout`**:
     - Used in `rsync` commands to ensure they do not run indefinitely. Commands will be killed if they exceed the allowed time.


### batman.sh


#### Downstream analysis
For Influenza and RSV the vpipe output has to be processed to get a table with the amino acid mutation frequency data which will be uploaded to the genspectrum dashboard. 
The function that takes the vpipe output and transforms it to a .tsv file is refered to as *downstream analysis*. This Analysis differes between RSV and Influenza as the provided code stems from different sources.
The scripts that perform the data transformation are uniformly stored in a folder on Euler calles *rsv_downstream_analysis* or *influenza_downstream_analysis* respectively.

In *carillon.sh* first, it is checked if there is an ongoing vpipe run and if so, nothing happens. If the last vpipe run completed and the downstream analysis has not yet been run for this batch the downstream analysis will start.
These checks are done via the status files created throughout the pipline. 

To start the downstream analysis the *remote_batman* script on euler is called with the respective name of the function (Influenza:vpipe_out_to_tsv , RSV: rsv_vpipe_out_to_tsv).
These functions are stored in the respective batman.sh script on euler and have differences which accomodate the differences between the downstream processing scripts. 

**RSV: rsv_vpipe_out_to_tsv**
This function is stored in batman.sh and executed on euler. The scripts that are celled in the function are stored in a public [git repository](https://github.com/cbg-ethz/RSV-wastewater-V-pipe/blob/production/README.md)
on the production branch. The git repo on euler can be found in `/cluster/project/pangolin/rsv_pipeline/rsv_downstream_analysis/RSV-wastewater-V-pipe`.
The function calles 3 different scripts: */timeline.py*, */annotate_vcf.py* and */make_mutation_tsv_annotated.py*.
It tracks sucessfull run of the script by means of status files.
It loops through the 2 RSV subtypes and defines the subtype specific input path needed to run the scripts, as well as subtype specific variables.
*/timeline.py* creates the timeline file for all the subtype spcific samples. This file in needed in */make_mutation_tsv_annotated.py* to filter for 
the relevant samples to create the output file.
*/annotate_vcf.py* loops thought the snvs.vcf files and creates amonoacide annotated snvs_annotated.vcf in the respective directory where snvs.vcf is located.
For this it needs the genbank reference file (path stored in server.conf).
Once both scripts run sucessfully */make_mutation_tsv_annotated.py* is called. The input requires the new timeline.tsv file and the annotated vcf file.
It takes the information from the annotated vcf file and transforms then into a table that can be uploaded to genspectrum.
The output is stored in `/cluster/project/pangolin/rsv_pipeline/*/working/MutationFrequencies`. (Note that the first batches up to 20250321_2429695737 only contain the nucleotide mutation frequency and not the amino acid mutation frequencies!)

**Influenza: vpipe_out_to_tsv**
The files for the analysis are in a currently local version stored on euler at: `/cluster/project/pangolin/influenza_pipeline/influenza_downstream_analysis` (tbd: update to git repo).
This function is embedding the /detect_AAMutations.R script which runs the transformation of the vpipe output to the .tsv table for uploading. The function ensures that this script is run on each of the fragments and creates the status files accordingly.
As input the function needs the fragment specific vpipe working folder as well as the path to the location.tsv file (which is stored in server.conf).
As output it generates the mutation frequency table in `/cluster/project/pangolin/influenza_pipeline/*/working/MutationFrequencies`.

**what happend to these files?**
The Files are manually checked and then uploaded to genspectrum (automation tbd).

**how to run the downstream analysis manually?**
Influenza:
```Bash
cd /cluster/project/pangolin/influenza_pipeline/pangolin/pangolin_src
./batman.sh vpipe_out_to_tsv
```
RSV:
```Bash
cd /cluster/project/pangolin/rsv_pipeline/pangolin/pangolin_src
./batman.sh rsv_vpipe_out_to_tsv
```

### garbage.sh
**Garbage RSV/Influenza**
If any batch already run v-pipe, use the garbage script for a cleanup of the folders from this batch. BEFORE: Add the batch to the **Bad List** as described above.
Garbage script: `./cluster/project/pangolin/rsv_pipeline/pangolin/pangolin_src/garbage.sh --variant "RSVB" --batch "20250417_2427493980"`
creates a garbage directroy in ./results and moves the sample/batch directrories inside the garbage directroy. Then checks if there are other batchech for the sample and if not deletes the sample directory form the ./results directroy.

**Garbage Covid**
`test_automation/pangolin/pangolin_scr/batman.sh garbage BATCHNAME`
moves the samples from sampleset to `/cluster/project/pangolin/garbage`
*Remember* to first black list the batch in `test_automation/pangolin/pangolin_scr/config/fgcz.conf`


## FGCZ Sync

### Merging orders 
It can happend that ordres (Batches) need to be merged e.g. if one sequencing run did not result in high enough read depth etc. Then the automation will first see it as a separate batch.
These have to be merged by adding the order in the fuselist in `/cluster/project/pangolin/fgcz_sync_automation/pangolin/fgcz_sync/config/fgcz.conf`.
The next time the sync autoamtion is running it will rake the 2 orders and create a new Batchname and places all related fastq files in this new batch. 
The remaining Batches need to be added to the badlist in `/cluster/project/pangolin/fgcz_sync_automation/pangolin/fgcz_sync/config/fgcz.conf`such that they are ingored and only the merged batch is used for further processing.
Remember to grabage the already created vpipe results of the half batches: `./batman.sh garbage BATCHNAME` (see Autoamtion above)

If this happens, remember to contact SPSP to correct the .cram file upload (the single batches need to be taken down and only the combined batch is relevant).

Currently, the created new Batchname for the combined data does not have 19 characters. Thus, the automation will not see that this is an aviti batch and vpipe will ignore the batch. 
To make vpipe see the batch as relevant, add the new batch name to the file: `/cluster/project/pangolin/working/avi_batches.tsv`
Makre sure the batch is present in: `/cluster/project/pangolin/working/samples_aviti.tsv`

**Timeframe**
The autoamtion only checks if there are missing vpipe results from the last 2 weeky samples. If the order is longer in the past adapt the timeframe in which the automation checks manually in the container on *wiseDB VM*
In carillon.sh :
```Bash
echo "============="
echo "Start new run"
echo "============="
.
.
.
limit=$(date --date='2 weeks ago' '+%Y%m%d') <--------------------------------------
.
.
```



# Euler
Base conda: 
```Bash 
eval "$(/cluster/project/pangolin/test_automation/miniconda3/bin/conda shell.bash hook)"
```
Notes on conda envs:
- If creating a new conda env which should be runnig on euler thes env has to be created **manually** before the automation can use it
- for this go to euler and activate the base env
- then create the new env form the .yaml file
```Bash 
conda env create -f environment.yaml #create conda env from existing yaml file
```
- if all the dependencies are solved the environment can be used
   - if packages need to be updates changed etc. save the new env
   - `conda env export --no-builds > environment.yaml`
- this process has to be repreated each time an environment changes / updates / adds



# Single Tool Documentation
## Uploader to SPSP
To upload samples to SPSP we use *sendcrypt* which is the tool provided by SPSP for the upload. Different functionas and parts of scripts are involved in the uploader process:

The upload happens in the folder on wise_db: wastewater_automation/pangolin/uploader.
To clarify/keep in mind: the wastewater_automation container also is responsible to analyse the covid data (run the vpipe analysis etc.) but also includes the upload of *ALL* the multiviral samples!

wise_db: wastewater_automation/pangolin/uploader_legacy
- depreciated
- contains the information of the pure covid uploads before the mulitviral samples

wise_db:/data/projects/dataset/archive → after upload, upload information it is archived there!

**belfry.sh**
Since the upload of the samples happens from the VM (wise:db) to SPSP the functions related to the upload are stored in there.
- queue_upload) creates batches_to_upload.tsv
- upload) function doing the upload
- clean_sendcrypt_temp)

*queue_upload*

This function of belfry.sh adds new samples to the batches_to_upload.tsv list which is required in *prepare.sh* to create the actual list of samples to upload (to_upload.txt) that is needed for the upload.
It gets the samples.BATCH.tsv from euler. And adds the samples to batches_to_upload.tsv which is then sortet such that the latest batch is on top.

*upload*

This function first creates a file (${uploader_tempdir}/cram_to_download.txt) to store the path of the .cram files of the new samples. This list is then used to rsync the new .creamfiles for the upload to the wise_db VM since the upload to SPSP needs to be done form the VM (technical pakage version reasons).
It also rsyncs the timeline.tsv and qa.csv file to have it in the package to be uploaded to SPSP. Then the upload.sh script is run to prepare the correct metadata.tsv table for the upload. If the metadata file in not empty the sendCrypt is run.
The upload is performed by useind the commands update (updates sendCrypt to always have the lates version), version (to record the sendCrypt version used) and send (whcih performed the upload). The send command take time since it takes the whole package and compresses it into a .gz folder and uploads it to SPSP.
After the upload was sucessfull the information is stored in the archive folder on wise_db and the .cram files are deleted.

*clean_sendcrypt_temp*

The sendcrypt send command creates a compressed version of the .cram files and the matedata and stores it in sendcrypt. folder. This needs to be deleted after the upload to avoid heavy storage usage.

**entrypont.sh**
The first script that is run when the container is created. It stores the GPG keys for the upload to SPSP. We need 2 keys to encrypt the data in the upload process one for us and another for SPSP (we need to have both). 
This setup is included in the entrypoint.sh script. (sendcrypt documentation on how to get them etc.)

**setup.sh**
setup.sh is called in entrypoint.sh (the script that sets up the container). Each time the container is recreated we run the installation of sendcrypt to have it in the container available. This installation is done as part of the setup.sh script.

**prepare.sh**
- stored at:/data/projects/wastewater_automation/pangolin/uploader
- called form belfry.sh upload) function.
- output: {uploader_tempdir}/to_upload.txt

This script prepared the list of samples to be uploaded to SPSP. First, it cleans up the to_upload.txt created fromt he previous run. Then it runs an inline Python script which created the to_upload.txt of the currently new samples.
It checks the list of batches_to_upload.tsv created in ____ and filteres out the blacklisted smaples and the already uploaded samples (${uploader_workdir}/all_uploaded.tsv) . 
Then it takes the *sample_number* which is the max nr. of samples to be uploaded at once and provides them in the to_upload.txt file which is the basis for which samples to upload.

**upload.sh**
- stored at:/data/projects/wastewater_automation/pangolin/uploader
- called form belfry.sh upload) function.

This script does not run the upload with sendcrypt but prepares the metadata.tsv file in the format that sendcrypt requires. 
It first checks the to_upload.txt files created in prepare.sh (which is called in belfry.sh) and goes through each sample line by line. It created the path to the dehuman.cram file and if it exists first makes a copy of it with the name *samplename.cram* file. This is necessary becasue by design vpipe output is called dehuman.cram for every sample. So for the upload they could not be differenciated.
Then the metadata line is created for this sample by running the create_metadata_line.py script which actually extracts the necessary information form the provided sample and wirtes it into the metadata.tsv file.
Lastly, the sample name is written in to the file that archives the uploaded run and the whole metadata.tsv is outputted.

**create_metadata_line.py**
tbd



## Amplicon Coverage Covid
The Amplicon Coverage plot is created automatically by the automation and can be found for each batch at:
`/cluster/project/pangolin/work-amplicon-coverage`


# bewi08 VM
We make regular backup of the analysed data. This is done by a VM called `bewi08`.
Inside this we have a script that runs these backup: `/links/shared/covid19-pangolin/backup/automation_backups/automation_backups.sh`.

The folder `/links/shared/covid19-pangolin` is mount to thin VM. This folder is stored inside a physical storage in D-BSSE.
If there is some storage maintenance done in the storage at the D-BSSE the link to this folder can break. Then, the folder has to be remounted to the VM with the following commands:

1. to unmount the backup folder on bewi08: `sudo umount /links/shared/covid19-pangolin`
2. to mount: `sudo mount /links/shared/covid19-pangolin`


## Storage Cleanup
The bioinformatics pipeline generates a significant amount of data that is regularly backed up on the Beerenwinkel group's shared folder, and is not necessary for research. Such data can be safely deleted from the computing cluster to minimize the space requirements.
The cleanup_storage.sh script contains the functions necessary to safely delete the temporary data.

**Variables setup**
The script defines the location of its script, of the logs and of the automation configuration

**Bash options**
`shopt -s nullglob` -> If a glob pattern matches nothing, treat it as empty instead of literal.

`set +f` -> Make sure globbing is active (needed because `set -f` might have been used before).

**Setting date**
Any run of the script, we define a date set 6 months prior, which is the current agreed-upon data retention period on the cluster.

**Script call sanity check**
The script checks if the required number of argument has been provided, then it checks if the `doit` option is also available. If it is available, it prints a warning message, waits 15 seconds and sets a flag that defines the run to be an actual deletion run. Otherwise, it warns the user that the current run is a dryrun and sets the flag to false.

**Available arguments**

- `clean_sampleset_covid`: deletes the content of the directories `raw_data` and `extracted_data` in the covid `sampleset` directory
- `clean_preproc_covid`: deletes the `fastq.gz` files in the directory `preprocessed_data` in the covid `working/samples` directory
- `clean_raw_covid`: deletes the `fastq.gz` files in the directory `raw_data` in the covid `working/samples` directory
- `clean_raw_uploads_covid`: deletes the `dehuman.cram` and `raw_reads.cram` files in the directory `raw_uploads` in the covid `working/samples` directory
- `clean_sampleset_rsv`: deletes the content of the directories `raw_data` and
 `extracted_data` in the RSV `sampleset` directory
- `clean_preproc_rsv`: deletes the `fastq.gz` files in the directory `preprocessed_data` in the RSVA and RSVB `working/samples` directories
- `clean_raw_rsv`: deletes the `fastq.gz` files in the directory `raw_data` in
 the RSVA and RSVB `working/samples` directories
- `clean_sampleset_flu`: deletes the content of the directories `raw_data` and
 `extracted_data` in the Influenza `sampleset` directory
- `clean_preproc_flu`: deletes the `fastq.gz` files in the directory `preprocessed_data` in the IA\_H1, IA\_H3, IA\_MP, IA\_N1, IA\_N2 influenza `working/samples` directories
- `clean_raw_flu`: deletes the `fastq.gz` files in the directory `raw_data` in the IA\_H1, IA\_H3, IA\_MP, IA\_N1, IA\_N2 influenza `working/samples` directories
- `clean_raw_fgcz`: deletes any FGCZ delivery older than 6 months from directory `bfabric_downloads`
- `clean_lollipop`: deletes the the files `alignments/basecnt.tsv.gz`, `alignments/host_aln.cram`, `alignments/REF_aln.bam`, `alignments/REF_aln_trim.bam` from the lollipop-specific `work-vp-test/results` directory. Such files are hardlinks to V-pipe results that are still available in the covid `working/samples` directory after this deletion step is run

**Logic**
The script avoids code duplication by setting specific variables depending on the function called, then running a generalized code snippet to search for the files and move them in a dedicated `garbage` directory.

The destination garbage directory will have the same structure of the origin of the files, and everything will reside in a dedicated subdirectory, in order to avoid overwriting files with identical names and in order to simplify restoring the files in case of problems.

The actual deletion only happens after the user manually deletes the files from the garbage directory, to ensure a final safety net.

**Deletion variables definition**
- `type`: stores the name of the type of data. Either the virus short name, fgcz or lollipop.
- `virusbase`: array storeing the virus subdirectory/subdirectories where the data is stored (e.g. `rsv_pipeline/RSVA`).
  - fgcz and lollipop are exceptions, due to the different folder structure. To avoid confusion, instead of `virusbase` they use the variable `base`.
  - **TODO**: With the current folder structure, covid has no dedicated subfolder and therefore `virusbase is set to `.`, indicating `/cluster/project/pangolin`. This will change after the folder restructuring.
- `parent`: stores the name of the static subdirectory of `virusbase` where the sample data can be found (e.g. `working/results`).
  - fgcz and lollipop are exceptions, due to the different folder structure. They do not require a `parent` variable.
- `togarbage`: array storing the files to delete, including the sample subdirectories that contain it. The variable can include `\*` as a wildcard.
  - fgcz is an exception. The entire delivery folder is deleted, therefore `togarbage` is not necessary.
- `garbage_logfile`: stores the position and name of the log file that will be written during the run. The name is unique for each function, includes if the run is dry or not, and includes the current date.

**Deletion code**
For any function excluding fgcz and lollipop, the script:
- loops through all virus subtype provided in the array `virusbase`
  - takes the `samples.tsv` file and filters it to get only the samples older than 6 months
  - loop through all samples
    - loop through all files to garbage in array `togarbage`
      - checks if the file to garbage exists
      - if it exists
        - either print to screen the move commands (dryrun), or create the garbage directory and move the files

If `type` is `fgcz`:
- get from the `fgcz.conf` automation config file the list of tracked projects
- retrieve the last modification dates of all files in the project directory and keep only those older than 6 months
- for each found directory
  - either print to screen the move commands (dryrun), or create the garbage directory and move the directories

If `type` is `lollipop`
Follow the same logic as for any other virus, but rely on the different file structure
