# Documentation Wastewater Surveillance

## Introduction

This document describes the automated data processing pipeline used for wastewater-based viral surveillance. The purpose of this system is to enable standardized, reproducible, and timely monitoring of selected respiratory viruses using high-throughput sequencing data derived from wastewater samples.

Wastewater samples are collected and initially processed at EAWAG. The processed samples are then transferred to the Functional Genomics Center Zurich (FGCZ), where sequencing is performed. Following sequencing, the resulting raw sequencing data (FastQ files) are made available to our system for downstream analysis.

The current surveillance scope includes COVID-19 (SARS-CoV-2), respiratory syncytial virus (RSV), and influenza virus. Due to differences in epidemiological and analytical requirements, the processing strategy differs between virus types. For SARS-CoV-2, the pipeline includes a deconvolution step aimed at identifying co-circulating viral variants and estimating their relative abundance within the sample. In contrast, the RSV and influenza pipelines focus on detecting viral presence and assessing sequencing coverage at predefined genomic regions, without variant deconvolution.

The overall system is composed of four major automations. One automation is dedicated to monitoring the FGCZ sequencing project and automatically detecting and downloading newly available sequencing data. The remaining three automations are virus-specific and handle the processing of FastQ files using the appropriate reference genomes and analysis logic for COVID-19, RSV, and influenza, respectively.

Following the automated analyses, additional manual post-processing and interpretation steps are performed. These steps are outside the scope of this document and are therefore not described in detail here.

### Automation Architecture and Execution Logic

All automations are executed on a dedicated virtual machine, referred to as the WiseDB VM, which serves as the central control node of the system. Each automation is launched within a dedicated Docker container to ensure reproducibility and isolation of the execution environment.

Upon container startup, predefined entry-point scripts are executed automatically. These scripts initialize and trigger the respective automations without manual intervention, ensuring consistent startup behavior across runs.

The WiseDB VM coordinates the overall workflow and communicates with the high-performance computing cluster Euler via forced ssh commands, where the computationally intensive analysis steps are executed. Orchestration and control remain on the WiseDB VM but are strongly dependent on status files generated during the individual analysis steps. The VM continuously checks for the presence of specific status files and uses their existence to determine whether subsequent analysis steps should be triggered or not.

In addition, a separate virtual machine, referred to as the Bewi08 VM, is used for uploading and storing backups generated during the processing workflow.

### Note on documentation
There is a mixture of absolute path or path described with variables (e.g. ${clusterdir_old}). The variables are virus specific and defined in `pangolin/pangolin_src/config/server.conf`.
**TBD**: replace all the absolute path with the variables to make the documentation more general

## Main Working Folders Overview

### Euler

`/cluster/project/pangolin/processes`

- Git repors and working folders of the 3 Virus Automations and the FGCZ datasync
- This path also contains the V-pipe installation that is used for all 3 virus automations
- This folder also contains relevant resouces for the genspectrum upload (should be moved to resources)
- **Covid** `/cluster/project/pangolin/processes/sars_cov_2`
- **RSV** `/cluster/project/pangolin/processes/rsv`
- **Influenza** `/cluster/project/pangolin/processes/influenza`

`/cluster/project/pangolin/data`

- synced data from fgcz (specifically in `/cluster/project/pangolin/data/fgcz_raw/p23224`)
  
`/cluster/project/pangolin/resources`

- resources and helper scripts / git repos needed in the automations
- not all of this is acutally used, thus here are some important git repos and files highlighted:
  - cowwid: main git repo for ww processing resources
  - (dbsse-user-setup.md/euler-user-setup.md ?)
  - lollipop_blacklist.txt : covid specific list with batch names or samples that should not be used for deconvolution with lollipop (should be moved to cowwid git repo)

`/cluster/project/pangolin/research`

- folder for research

### WiseDB VM

`/data/projects/fgcz_data_sync_automation`

- git repo, status files and secrets of the fgcz sync automation

`/data/projects/influenza_automation_restructuring`

- git repo, status files and secrets of the the influenza automation

`/data/projects/rsv_automation_restructuring`

- git repo, status files and secrets of the the rsv automation

`/data/projects/sars_cov_2_automation`

- git repo, status files and secrets of the the covid automation

`/data/projects/wisedb_uploader`

- script used to upload sample specific data to the wiseDB (e.g. cram files etc.)

## Euler

The automation runs on the wisedbVM but data processing is done on Euler and processing steps are coordinated via:
SSH forced command / Restricted SSH key / Command-restricted key / SSH wrapper execution model

### Folder structure and git branches

```bash
cd /cluster/project/pangolin
|__ data
   |__ fgcz_raw
      |__ p23224 (raw data download from fgcz befabric)


|__ processes
   |__ rsv
      |__ pangolin (git branch origin/rsv_automation_folder_restructuring)
      |__ working
      |__ vpipe_input (vpipe input data: reorganized and transfered from fgcz_raw with function batman.sh sortsamples)
      |__ RSVA
            |__ pangolin (git origin/rsv_automation_folder_restructuring)
            |__ vpipe_output
            |__ working
      |__ RSVB
            |__ pangolin (git origin/rsv_automation_folder_restructuring)
            |__ vpipe_output
            |__ working
      |__ rsv_downstream_analysis
         |__ RSV-wastewater-V-pipe (git status origin/production)
         |__ downstream_analysis_statusdir
   |__ influenza
      |__ pangolin (git origin/flu_automation_folder_restructuring)
      |__ working
      |__ vpipe_input
      |__ IA_H1
            |__ pangolin (git origin/flu_automation_folder_restructuring)
            |__ vpipe_output
            |__ working
      |__ IA_H3
            |__ ...
      |__ IA_MP
            |__ ...
      |__ IA_N1
            |__ ...
      |__ IA_N2
            |__ ...
      |__ influenza_downstream_analysis
            |__ AA_mutationAnalysis_IAV (git branch origin/automation)
   |__ sars_cov_2
      |__ amplicon_coverage
      |__ explore-new-variants (ivan)
      |__ garbage
      |__ lollipop
      |__ pangolin (git branch origin/sarscov2_folder_restructuring)
      |__ vpipe_input
      |__ vpipe_output
      |__ working
      |__ work-new-variants (test environment for new variants in lollipop)
   |__ fgcz_sync 
      |__ pangolin (git branch origin/fgcz_sync_automation_folder_restructuring)
      |__ ... 
   |__ genspectrum_upload
      |__ WISE-mut-freq-data-uploader (git branch pangolin_dev)
   |__ V-pipe (git branch origin/rubicon)


|__resources
   |__ cowwid (git branch origin/master)
      |__ covvfit (used to generate plots for reporting mail)
      |__ for_communication (used to generate plots for reporting mail)
      |__ genspectrum_upload (scripts used for the genspectrum upload of RSV and Influenza)
   |__ lollipop_blacklist.txt (Blacklist for Covid lollipop !untracked! TODO!)
|__ research
```

**Git:**

Pangolin: https://github.com/cbg-ethz/pangolin/tree/master
V-pipe: https://github.com/cbg-ethz/V-pipe
cowwid: https://github.com/cbg-ethz/cowwid
WISE-mut-freq-data-uploader: https://github.com/GenSpectrum/WISE-mut-freq-data-uploader
RSV-wastewater-V-pipe: https://github.com/cbg-ethz/RSV-wastewater-V-pipe/tree/production
AA_mutationAnalysis_IAV: https://github.com/anikajohn/AA_mutationAnalysis_IAV/tree/automation

### Bad List

**For Covid, Influenza and RSV!!**
(similar to blacklist for covid-lollipop but here we define it for the process that copies the raw data from the fgcz download folder to the vpipe_input directories per virus (function `sortsamples`!)

- For every virus in `pangolin/pancoling_scr/config` there is a `fgcz.yaml` file where there is a badlist specified
- put the delivery name (orderID) that should not be processed with vpipe in this list
- you can find the delivery name associated to the batch in vpipe_input folder: batch.BATCHNAME.tsv
- **Remember** to garbage the batch if it already run with vpipe

Example Covid: `/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src/config/fgcz.conf`

**samples download from bfabric**
`/cluster/project/pangolin/data/fgcz_raw/p23224`

___

### pangolin_src Folders General Structure

This folder contains all the code that is used in the automation. The automation constantly runs in the background and tries to check if there are new samples available on bfabric. If there are new samples, it mirrors them transforms them into the correct input format and starts vpipe.

In the folder are several scripts to run the Automation. Once the docker image  is created the first script that is celled is entrypoint.sh which then further distributes the tasks and starts the automation.
___

**entrypoint.sh**

The `entrypoint.sh` script is meant to set up necessary credentials and configurations for the automation. It performs the following key actions:

1. **Credential Setup:** Copies various secret files, such as SSH keys and configuration files, into appropriate directories to establish secure connections with external servers and services.

2. **Host Verification:** Adds the SSH keys of specific hosts to the `known_hosts` file, ensuring that the system recognizes and trusts these hosts during SSH connections.

3. **GPG Key Configuration:** Imports GPG keys required for secure data uploads, particularly to the Swiss Pathogen Surveillance Platform (SPSP).

By executing these steps, the script prepares the environment for automated data processing and secure communication with external platforms.

___ 

**quasimodo.sh**

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
     - The current date is printed after each loop.

___

**carillon.sh**

The script is the "heart" of the automation designed to perform a series of tasks for managing data processing on Euler.

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

- outdated (not used anymore)

1. **Phase 6: Uploader to SPSP and Backup to bs-bewi08**
   - **Quota Check**:
      - Reads or initializes the daily status file to track the number of samples uploaded.
      - Calculates the current and estimated upload size and compares it against daily limits (sample count and total upload size).

   - **Upload Execution**:
      - If the upload request exceeds quotas, it defers the upload to the next day.
      - If within quotas, it starts the upload process using the `belfry.sh upload` script and updates the status file with the new total.

   - **Backup**:
      - If enabled, backs up the results of the upload to a backup server and logs the status of the backup operation.
      - Handles both successful and failed backup attempts.

2. **Phase 7: Amplicon Coverage**

- TODO

___

**belfry.sh**

- Batch Processing Script
- Helper functions for carillon.sh executed on VM 
- **Functions that run on the VM**
  
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

___

### **batman .sh**
**TBD** - this sction is stillunstructured (However, most important functions should already be here)
**Disclaimer** There are virus specific functions that are described here as they are stored in the virus specific batman.sh script

- Batch Processing Script
- Helper functions for carillon.sh executed on Euler
- **Functions that run on EULER**

___

**`vpipe)`** (RSV)

vpipe triggers 2 things:

1. the main.sbatch which runs vpipe
2. the qa (quality assurance)
Only if both ended successfully it created vpipe.ended in the status and will not run both again in the next loop.

* The `qa-launcher` is called within the `vpipe` function defined in `batman.sh`. The workflow first changes into the variant-specific working directory, while the actual `qa-launcher` script itself is stored centrally in
  `${clusterdir_old}/${clusterdir}/${working_vpipe}/`.
  This setup ensures that the executable scripts are maintained in a central location, whereas log files are written to the virus-specific working directory.

* In `vpipe_rsv_aviti_main.sbatch`, the workflow changes into the variant-specific working directory
  `/cluster/project/pangolin/processes/rsv/*/working/`
  before submitting and executing the corresponding variant-specific `.sbatch` script.
  Similar to the `qa-launcher`, the `.sbatch` scripts are stored centrally in
  `${clusterdir_old}/${clusterdir}/${working_vpipe}/`,
  but they are executed from within the variant-specific working directory so that log files are generated there.

* The variant-specific `.sbatch` script executes the `vpipe` command using the corresponding variant-specific `.yaml` configuration file. These configuration files are also stored centrally in
  `${clusterdir_old}/${clusterdir}/${working_vpipe}/`.


**The qa logic**

- ``qa-launcher`` is called in batman.sh vpipe function
- this looks for
  - ./samples.recent.tsv
  - ./samples.tsv
  - /qa/ folder in the variant specific working directory
- then it runs the centrally stores `${clusterdir_old}/${clusterdir}/${working_vpipe}/gather1qa`

`gather1qa`

- checks the `vpipe_input/batch.*.yaml` for the current batch
- then checke vpipe_output directory for the output files to gather the qa stats
- they are outputted in `output_csv="/qa/qa.${batch}.csv"` in the variant specific working directory

___

**Downstream analysis**

*Goal: generate amino acid mutation frequency table form vpipe output*

For Influenza and RSV the vpipe output has to be processed to get a table with the amino acid mutation frequency data which will be uploaded to the genspectrum dashboard.
The function that takes the vpipe output and transforms it to a .tsv file is refered to as *downstream analysis*. This Analysis differes between RSV and Influenza as the provided code stems from different sources.
The scripts that perform the data transformation are stored in a folder on Euler calles *rsv_downstream_analysis* or *influenza_downstream_analysis* respectively.

In *carillon.sh* first, it is checked if there is an ongoing vpipe run and if so, nothing happens. If the last vpipe run completed and the downstream analysis has not yet been run for this batch the downstream analysis will start.
These checks are done via the status files created throughout the pipline.

To start the downstream analysis the *remote_batman* (forced command from VM to Euler) script on euler is called with the respective name of the function (Influenza:vpipe_out_to_tsv , RSV: rsv_vpipe_out_to_tsv).

___

**1. RSV: `rsv_vpipe_out_to_tsv`**

*Conda Env:* The required Conda environment is defined in:
https://github.com/cbg-ethz/RSV-wastewater-V-pipe/blob/main/envs/downstream_analysis.yml
and on Euler:
`/cluster/project/pangolin/processes/rsv/rsv_downstream_analysis/RSV-wastewater-V-pipe/envs/downstream_analysis.yml`

**Conda Environment**

The required Conda environment is defined in:
[https://github.com/cbg-ethz/RSV-wastewater-V-pipe/blob/main/envs/downstream_analysis.yml](https://github.com/cbg-ethz/RSV-wastewater-V-pipe/blob/main/envs/downstream_analysis.yml)

**Execution**

The downstream analysis function is implemented in `batman.sh` and executed on Euler.

The scripts it calls are maintained in the public repository (production branch):
[https://github.com/cbg-ethz/RSV-wastewater-V-pipe](https://github.com/cbg-ethz/RSV-wastewater-V-pipe)

Production clone on Euler:
`/cluster/project/pangolin/processes/rsv/rsv_downstream_analysis/RSV-wastewater-V-pipe`

The function executes three scripts:

* `timeline.py`
* `annotate_vcf.py`
* `make_mutation_tsv_annotated.py`

Execution success is tracked via status files. The function iterates over both RSV subtypes and sets subtype-specific input paths and variables.

**Script Overview**

* `timeline.py`: Generates a subtype-specific `timeline.tsv` file.
* `annotate_vcf.py`: Annotates `snvs.vcf` files with amino acid information, producing `snvs_annotated.vcf` in the same directory. Requires the GenBank reference defined in `server.conf`.
* `make_mutation_tsv_annotated.py`: Uses `timeline.tsv` and the annotated VCF files to generate a amino acid mutation frequency table for Genspectrum upload.

**Output**

Results are written to:
`/cluster/project/pangolin/processes/rsv/*/working/MutationFrequencies`

Batches up to `20250321_2429695737` contain only nucleotide mutation frequencies. Later batches include amino acid mutation frequencies.

___

**2. Influenza: `vpipe_out_to_tsv`**

**Location**

The analysis files are stored in a Git repo that is cloned to Euler at:
`${clusterdir_old}/${clusterdir}/influenza_downstream_analysis/AA_mutationAnalysis_IAV`
https://github.com/anikajohn/AA_mutationAnalysis_IAV


**Execution**

The function embeds the script `detect_AAMutations.R`, which converts the V-pipe output into a `.tsv` table for genspectrum upload.

It runs the script separately for each fragment and tracks successful execution using status files.

**Input**

* Fragment-specific V-pipe working directory
* Path to `location.tsv` (defined in `server.conf`)

**Output**

Amino acid mutation frequency table for Genspectrum upload tables are written to:
`/cluster/project/pangolin/influenza_pipeline/*/working/mutation_frequencies`

___

**What happend to these files?**
The Files are manually checked and then uploaded to genspectrum (automation tbd).

**How to run the downstream analysis manually?**
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

___

**Sortsample**

[#sortsample]

This is an **essential** function that takes the rawdata and sorts them to create the input data format for vpipe.

```Bash
${clusterdir_old}/${clusterdir}/${sourcefiles_location}/sort_samples_bfabric_tsv_aviti.py \
  -c ${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/fgcz.conf \
  --no-fastqc \
  --protocols=${clusterdir_old}/${clusterdir}/pangolin/${working}/${protocolyaml} \
  --libkit-override=${clusterdir_old}/${clusterdir}/${sampleset}/patch.fgcz-libkit.tsv \
  ${force} ${recent}
```

**1. Arguments maped to argparse in sort_samples_bfabric_tsv_aviti.py**

| Bash Argument              | Python `argparse` Option | Destination Variable (`args.<var>`) | Purpose / Description                                                                                                            |
| -------------------------- | ------------------------ | ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `-c <path>`                | `--config`               | `args.config`                       | Path to configuration file (overrides default `config/server.conf`). Here, it points to `config/fgcz.conf`.                      |
| `--no-fastqc`              | `-Q / --no-fastqc`       | `args.nofqc`                        | Boolean flag. When present, tells the script to **skip importing fastqc directories**.                                           |
| `--protocols=<path>`       | `-4 / --protocols`       | `args.protoyaml`                    | Path to a **protocol YAML file** used to build a 4-column `samples.tsv` (using fields `'name'` and `'alias'`).                   |
| `--libkit-override=<path>` | `-l / --libkit-override` | `args.libkittsv`                    | Path to a **TSV file** that maps library prep kit overrides for certain projects/orders.                                         |
| `${force}`                 | `-f / --force`           | `args.force`                        | Optional flag added conditionally by the shell. If set to `-f`, it tells the script to **overwrite existing files** when moving. |
| `${recent}`                | `-r / --recent`          | `args.recent`                       | Optional argument. If set (e.g. `-r 20240401`), only process batches *after* that date.                                          |

**3. Configuration Values (loaded inside the script)**

The script then reads the configuration file (fgcz.conf) using some custom loader (not shown here) and assigns variables:

| Config Key          | Assigned Python Variable | Purpose                                                                     |
| ------------------- | ------------------------ | --------------------------------------------------------------------------- |
| `_ → lab`           | `lab`                    | Name of the lab, used in the batch YAML.                                    |
| `_ → basedir`       | `basedir`                | Main data directory.                                                        |
| `_ → basedir_test`  | `basedir_test`           | Alternative directory for test runs.                                        |
| `_ → expname`       | `expname`                | Name of the experiment/project (used e.g. in SFTP naming).                  |
| `_ → download`      | `download`               | Directory where raw (unsorted) datasets are stored.                         |
| `_ → sampleset`     | `sampleset`              | Directory for sorted sample sets.                                           |
| `_ → link`          | `link`                   | Whether to **link** instead of copy files (may be `hardlink` or `reflink`). |
| `_ → badlist`       | `badlist`                | List of folder names to skip entirely.                                      |
| `_ → forcelist`     | `forcelist`              | List of folders to force process even with missing metadata.                |
| `_ → fuselist`      | `fuselist`               | List of folders to always merge.                                            |
| `_ → fallbackproto` | `fallbackproto`          | Default protocol to apply if none specified.                                |

**4. Execution Flow Summary**

- The shell checks if FGCZ lab is active.
- It sources fgcz.conf to see if google_sheet_patches is enabled.
- If yes, it runs google_sheet_patches.py first.
- Then it calls sort_samples_bfabric_tsv_aviti.py with arguments that define:
- which config file to use (fgcz.conf),
- which protocol YAML to apply,
- which library patch TSV to apply,
- whether to skip fastqc,
- and optionally --force and --recent filters.
- If the Python call fails, fail=1 is set and movedatafiles.sh is not executed.

**Overview sort_samples_bfabric_tsv_aviti.py**

The script performs two big phases:

**Phase 1 – Data gathering:**
It walks through the download directory (`basedir/download/projects/*`) and collects run information from Stats.json, dataset.tsv, etc.
It builds an internal structure called `batches`, where each key is an order and the value holds all metadata for that order/run (samples, lanes, flowcell, rundate, etc.).

**Phase 2 – Output building:**
It writes:
samples.<batch>.tsv
projects.<batch>.tsv
batch.<batch>.yaml
missing.<batch>.txt
and a shell script movedatafiles.sh

Those files define and enact how data are copied or linked into the final sampleset layout: `<sampleset>/<sample>/<batch>/{raw_data,extracted_data}
`
**Internal Batch Name**
Is created by putting together the `rundate` and `"FlowCellID"` extracted from the raw_data *DmxStats* *.json file.

**movedatafiles.sh**

A sample row is written into movedatafiles.sh if all of the following hold:

Folder-level conditions: 

- the delivery folder is found under basedir/download/...
- the folder name is not in badlist
- a valid stats JSON is found
- order can be determined
- flowcell can be parsed
- rundate can be parsed
- the run is not excluded by --recent
- the folder contains at least 2 valid samples with nonzero reads
- the folder is not dropped by the fuselist logic

Sample-level conditions:

- the sample has nonzero reads in the stats JSON
- the row in dataset.tsv can be matched to a sample in batches[b]['samples']
- directly, or
- after suffix removal, or
- by fuzzy prefix matching
- the row contains usable Read1 [File] and, if paired-end, Read2 [File]

If those conditions are met, the script prints mkdir and cp commands for that sample into movedatafiles.sh.

**Observation: samples are only copied tinot vpipe:input directory once the fastQC files are there. Currently it is not clear for me where this condition is placed as in the script sort_samples_bfabric_tsv_aviti.py the flag --no-fastqc is set which should cancel all dependency on fastqc files. (needs to be checked further!)**
___

### **batman .sh `addsamples`**

Builds the sample lists used by the workflow, now with support for configurable sample exclusion from `fgcz.conf`.

What it does:

* reads all relevant `samples.*.tsv` files from `${sampleset}`
* applies `exclude_samples` first
* applies subtype-specific exclusions on top of that
* writes:

  * shared `samples.tsv` / `samples.recent.tsv`
  * subtype-specific `samples.tsv` / `samples.recent.tsv`

Practical effect:

* a sample in `exclude_samples` is removed everywhere
* a sample in a subtype-specific exclude list is removed only from that subtype
* excluded samples are also not copied into subtype-specific output folders

Config keys:

* RSV:

  * `exclude_samples`
  * `exclude_samples_rsva`
  * `exclude_samples_rsvb`
* Influenza:

  * `exclude_samples`
  * `exclude_samples_ia_h1`
  * `exclude_samples_ia_h3`
  * `exclude_samples_ia_mp`
  * `exclude_samples_ia_n1`
  * `exclude_samples_ia_n2`

Expected format in `fgcz.conf`:

```bash
exclude_samples="SAMPLE_A,SAMPLE_B"
exclude_samples_rsva="SAMPLE_X"
exclude_samples_ia_h1="SAMPLE_Y"
```

Important note:

* filtering is done on column 1 of the TSV, so exclusion is by sample name only

### **batman .sh `scanmissingsamples`**

Checks whether the expected subtype-specific V-pipe output exists for each sample/batch pair, while respecting the same exclusion settings.

What it does:

* reads a sample list file (`samples.tsv` or `samples.recent.tsv`)
* skips globally excluded samples completely
* skips subtype checks for samples excluded only in that subtype
* reports the first sample that is missing required output files

Practical effect:

* a globally excluded sample is never checked
* a subtype-excluded sample is still checked for the other subtypes
* if a sample is excluded from all subtype checks, it is skipped entirely

Required output checked:

* RSV: subtype `snvs.vcf` files in `RSVA` / `RSVB`
* Influenza: subtype `snvs.vcf` files in `IA_H1`, `IA_H3`, `IA_MP`, `IA_N1`, `IA_N2`

In short:

* `addsamples` decides which samples enter each workflow branch
* `scanmissingsamples` verifies only the outputs that are still expected after exclusions


### Garbaging Batches - garbage.sh

[#garbage]

In cases where samples or batches need to be removed, scripts are available that move the data to a **garbage** directory instead of deleting it. For example, when correcting a sample name, both the `vpipe_input` and `vpipe_output` folders must be cleaned so that the patching file is applied and the corrected name is used. The corresponding sample directories therefore need to be moved to the **garbage** directory.

Another use case is the accidental delivery of an experimental batch to the FGCZ project that was not announced beforehand. In such cases, first add the batch to the corresponding **blacklist/bad list** (as described above) to prevent reruns. Only afterwards should the already processed batch be moved to garbage.

**Garbage RSV/Influenza**

Garbage script:
`/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src/garbage.sh --variant "RSVB" --batch "20250417_2427493980"`

This script creates a `garbage` directory in `./vpipe_output` and moves the corresponding sample/batch directories there. It then checks whether additional batches exist for the same sample. If none exist, the sample directory is removed from the `./results` directory.

`pangolin_src/garbage_covid_batches.sh`

* Script to garbage batches for both subtypes (RSVA and RSVB)
* Reduces manual interaction when multiple batches need to be garbaged for both variants
* To use it, edit the script and specify the batches to remove

**Overview `garbage_vpipe_input.sh`**

This script garbages batches that were copied from `fgcz_raw` to the `vpipe_input` directory (RSV/Influenza). These files must be removed, for example in the case of sample renaming; otherwise, V-pipe may attempt to reprocess the copied samples with the old names.

Example:
`/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src/garbage_vpipe_input.sh --batch "20250417_2427493980"`

`pangolin_src/vpipe_input_garbage_covid_batches.sh`

* Script to garbage input batches (designed for both subtypes, since there is only one input directory per virus)
* Reduces manual interaction when multiple batches need to be removed
* To use it, edit the script and specify the batches to garbage

**Garbage Covid**
`/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_scr/batman.sh garbage BATCHNAME`

*Important:* first blacklist the batch (if it should not be processed) in
`/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_scr/config/fgcz.conf`.


### Restore scripts

Two maintenance scripts are available to undo a previous "garbage" operation for a specific influenza batch:

- `pangolin_src/restore_vpipe_input_batch_from_garbage.sh`
- `pangolin_src/restore_vpipe_output_batch_from_garbage.sh`

They are intended to be used after the batch was previously moved away with:

- `pangolin_src/garbage_vpipe_input.sh --batch <batch>`
- `pangolin_src/garbage.sh --variant <variant> --batch <batch>`

These restore scripts are currently written as operator scripts rather than generic CLIs. In particular, the batch id, logfile path, and in the output case the list of restored variants, are hardcoded inside the script and must be reviewed before execution.

If both `garbage/<sample>/` and `garbage/<sample>.bak.<timestamp>/` exist, the restore scripts only inspect `garbage/<sample>/`; any batch directories previously moved into the `.bak.*` backup location are ignored and must be restored manually.
___

**`restore_vpipe_input_batch_from_garbage.sh`**

Purpose:
Restore one batch from `vpipe_input/garbage` back into the active `vpipe_input` tree.

What it does:

- Loads the cluster paths from `pangolin_src/config/server.conf` and `pangolin_src/config/fgcz.conf`.
- Uses the hardcoded batch id stored in `readonly batch=...`.
- Looks for the batch sample list in one of these files:
  - `${clusterdir_old}/${clusterdir}/vpipe_input/projects.<batch>.tsv`
  - `${clusterdir_old}/${clusterdir}/vpipe_input/garbage/projects.<batch>.tsv`
- Reads the first column of that TSV as the list of samples belonging to the batch.
- For each sample, moves the directory `vpipe_input/garbage/<sample>/<batch>` back to `vpipe_input/<sample>/<batch>`.
- Removes `vpipe_input/garbage/<sample>` if it becomes empty after the move.
- Moves these batch-level metadata files from `vpipe_input/garbage/` back to `vpipe_input/` when present:
  - `batch.<batch>.yaml`
  - `samples.<batch>.tsv`
  - `missing.<batch>.txt`
  - `projects.<batch>.tsv`
- Appends all output to the hardcoded logfile.

Safety checks:

- Fails if neither active nor garbaged `projects.<batch>.tsv` exists.
- Skips samples that do not currently have a garbaged batch directory.
- Aborts if the destination `vpipe_input/<sample>/<batch>` already exists.
- Aborts if one of the metadata files already exists at the restore destination.

Typical use:

1. Confirm the correct batch id in the script.
2. Confirm the logfile path is still appropriate.
3. Run the script on the cluster host.
4. Verify that the batch directory and metadata files are back under `vpipe_input/`.

___

**`restore_vpipe_output_batch_from_garbage.sh`**

Purpose:
Restore one batch from the garbaged `vpipe_output` trees back into the active `vpipe_output` directories for all configured influenza subvariants.

What it does:

- Loads the cluster paths from `pangolin_src/config/server.conf` and `pangolin_src/config/fgcz.conf`.
- Uses the hardcoded batch id stored in `readonly batch=...`.
- Uses the hardcoded variant list:
  - `IA_H1`
  - `IA_H3`
  - `IA_MP`
  - `IA_N1`
  - `IA_N2`
- Reads the sample list from either:
  - `${clusterdir_old}/${clusterdir}/vpipe_input/projects.<batch>.tsv`
  - `${clusterdir_old}/${clusterdir}/vpipe_input/garbage/projects.<batch>.tsv`
- For each variant and each sample, moves `.../<variant>/vpipe_output/garbage/<sample>/<batch>` back to `.../<variant>/vpipe_output/<sample>/<batch>`.
- Removes `.../garbage/<sample>` if it becomes empty after the move.
- Appends all output to the hardcoded logfile.

Safety checks:

- Fails if neither active nor garbaged `projects.<batch>.tsv` exists.
- Skips sample/variant combinations that do not currently have a garbaged batch directory.
- Aborts if the destination `vpipe_output/<sample>/<batch>` already exists.

Important limitation:

- This script restores directories only. It does not rebuild or restore the cleaned `samples.tsv` and `samples.recent.tsv` files that were modified by `garbage.sh`.
- The complementary cleanup and restoration of those TSVs is therefore still a manual operational concern unless another script handles it.

Operational notes:

- The input restore should normally be run before re-enabling processing of a batch, because the output restore relies on the same batch sample list.
- The scripts use `mv`, so the restore is a real relocation, not a copy.
- Both scripts log with `exec >> logfile 2>&1`, meaning stdout and stderr are permanently redirected to the configured log file for the full run.

___

### Patching

[#Patching]

Two types of patches are supported:

1. **Sample names** (metadata and sample files)
2. **Library prep kit** in the metadata

All other issues must be corrected by **FGCZ**.

**Sample name patching**

If sample names in the FGCZ order are incorrect, they must be patched using a patch file placed in the corresponding `vpipe_input` directory.

Example:
`/cluster/project/pangolin/processes/sars_cov_2/vpipe_input/patch.<project>.<order>.tsv`

File format:

* column 1: old sample name
* column 2: corrected sample name

Example filename:
`patch.23224.39798.tsv`

If V-pipe has already processed the incorrectly named samples, the previous results must first be garbaged.

Cleanup steps:

* **Covid:**

  ```
  /cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src/batman.sh garbage <BATCH_NAME>
  ```

* **RSV / Influenza:**
  garbage both `vpipe_input` and `vpipe_output` directories (see section *Garbaging Batches*).

After cleanup, the next automation loop will run `sort_samples`, which automatically applies the patch.


**Libkit patching (Covid only)**

Library prep kit patching is required when the libkit recorded in the metadata is incorrect. This information is used downstream (e.g. in lollipop).

Steps:

1. Identify the first order where the new libkit was used (via email or B-Fabric).
2. List all affected orders up to the latest one delivered with the correct kit.
3. Stop the **SARS-CoV-2 automation** on `wisedb`.
4. Edit the file:

   ```
   /cluster/project/pangolin/processes/sars_cov_2/vpipe_input/patch.fgcz-libkit.tsv
   ```

File structure:

```
project   order   libkit
```

Example:

```
p25650   o26956   SARS-CoV-2 ARTIC V3 NexteraXT
```

Add one line per order to patch. The libkit name must exactly match the pipeline libkit definitions
(e.g. `SARS-CoV-2 ARTIC V5.4.2 NEB Ultra II`).

Next, identify the corresponding batch names:

```
cd /cluster/project/pangolin/processes/sars_cov_2/vpipe_input
grep -rl -e <order_name> batch.*.tsv
```

Garbage all affected batches:

```
/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src/batman.sh garbage <batch> | tee garbage.log
```

Check the log for sanity. Some “file not found” errors can occur if certain expected files are missing.

Finally:

* restart the automation on `wisedb`
* confirm that V-pipe reruns

Note: this patching method only works if **all samples in an order use the same libkit**. If libkits differ between samples within the same order, the metadata must be corrected by **FGCZ**.


Here is a cleaned-up and more structured version, keeping it concise and improving clarity:

### Euler conda setup

Base conda:

```bash
eval "$(/cluster/project/pangolin/resources/miniconda3/bin/conda shell.bash hook)"
```

Notes on conda environments:

* New environments must be created **manually on Euler** before they can be used in the automation.
* Activate the base environment, then create the new environment from the `.yaml` file:

```bash
conda env create -f environment.yaml
```

* Once dependencies are resolved, the environment is ready to use.
* If packages are updated or changed, export the updated environment:

```bash
conda env export --no-builds > environment.yaml
```

* This process must be repeated whenever the environment is modified.

---

## FGCZ Sync Automation

*(updated: 6 Jan 2026)*

A dedicated automation on the **WiseDB VM** manages data synchronization from FGCZ to Euler.

* Synced data location on Euler:
  `/cluster/project/pangolin/data/fgcz_raw/p23224`

**Repositories:**

* WiseDB: `/data/projects/fgcz_data_sync_automation`
* Euler: `/cluster/project/pangolin/processes/fgcz_sync`

---

### Workflow

The automation starts when the container on WiseDB is launched:

* `entrypoint.sh` → starts `quasimodo.sh`
* `quasimodo.sh` → runs `fgcz_sync.sh` in a continuous loop

`fgcz_sync.sh`:

* Reads configuration from `server.conf`
* Triggers the sync via `remote_batman sync_fgcz` (function in `batman.sh` on Euler)

`sync_fgcz`:

* Builds an exclude list using:

  * `fgcz.conf`
  * `exclude_list_bfabric.py`
* Passes the exclude list to `sync_sftp.sh`
* `sync_sftp.sh` performs the actual sync via `lftp mirror`

---

### Merging Orders

If sequencing depth is insufficient, multiple orders (batches) may need to be merged.

Steps:

1. Add the orders to the **fuselist** in:
   `/cluster/project/pangolin/processes/fgcz_sync/pangolin/fgcz_sync/config/fgcz.conf`
   and in the relevant virus automations
   `/cluster/project/pangolin/processes/*/pangolin/pangolin_src/config/fgcz.conf`

2. Add the merged `BATCH` to `/cluster/project/pangolin/processes/sars_cov_2/working/avi_batches.tsv`

3. On the next sync run:

   * A new merged batch is created
   * FASTQ files from all listed orders are combined

4. Garbage existing V-pipe results of the partial batches:

   ```
   ./batman.sh garbage <BATCHNAME>
   ```
--> ensure that the project.BATCH.tsv files are no longer in the `vpipe_input` folders

5. Notify SPSP to correct `.cram` uploads (remove partial batches, keep merged batch only)


**Aviti Batches (Special Case)**

*Merged batches* may not follow the expected 19-character naming convention and can be ignored by V-pipe.

To ensure processing:

* Add the merged batch to:
  `/cluster/project/pangolin/processes/sars_cov_2/working/avi_batches.tsv`

* Confirm that the automation processed the merged batch correctly by verifying that it is listed in:
  `/cluster/project/pangolin/processes/sars_cov_2/working/samples_aviti.tsv`

---

### Timeframe Limitation

The automation only considers samples from the **last 2 weeks**.

For older orders, adjust the timeframe in the WiseDB container:

File: `carillon.sh`

```bash
limit=$(date --date='2 weeks ago' '+%Y%m%d')
```

___

## Maintenance

### Primer Update in Regular Processing

If there is a primer update (e.g., an ARTIC release), follow the steps below to ensure correct integration of the new primer scheme into the `v-pipe` analysis.
Typically, a `.bed` file for the primers is available from the [ARTIC GitHub repository](https://github.com/quick-lab/primerschemes/tree/main/primerschemes/artic-sars-cov-2/400/v5.4.2) ([Outdated Repo](https://github.com/artic-network/primer-schemes)), which can be downloaded and used with a custom script to generate the required files.
For analysis, the following files are required and must be referenced in:

```Bash
/cluster/project/pangolin/working/references/primers.yaml
```

This YAML file maps the required input files. It should include the following fields:

- `name`: Identifier used in the FGCZ metadata delivery.
- `insert_bedfile`: BED file defining the regions intended to be sequenced.
- `primer_bedfile`: BED file defining the primer binding regions (typically from ARTIC).
- `primers_file`: Tab-separated file with primer information.
- `primer_fasta`: FASTA file containing primer sequences.

---

###### Step 1: Generate Missing Files from ARTIC `.bed`

Usually, only the `primer_bedfile` is provided by ARTIC. The remaining files must be generated using the following script:

```Bash
/cluster/project/pangolin/folder_cleanup/resources/smallgenomeutilities/scripts/prepare_primers
```

###### Environment Setup

Activate the appropriate conda environment:

```bash
eval "$(/cluster/project/pangolin/test_automation/miniconda3/bin/conda shell.bash hook)"
conda activate amplicon_coverage
```

###### Script Parameters

- **Input:** Refer to the “arguments” section in the script header.

- **Output prefix:** Define a consistent prefix for all generated files.

- **`--change_ref`:** The reference sequence used may vary. Ensure the correct one (`NC_045512.2`) is used. If the `.bed` file uses `MN908947.3`, include this argument to override it:

  ```Bash
  --change_ref NC_045512.2
  ```

- **`--primer_names_sep`:** Specify the separator used in the primer names (e.g., `_`, `-`). This is necessary if elements in the BED file are not separated by underscores. It allows the script to correctly extract the primer number and side.

- **`--primer_number_pos`:** Indicate the zero-based position of the primer number in the split name (e.g., if `nCoV-2019_1_LEFT` is the format and `_` is the separator, the number is at position `1`).

- **`--primer_side_pos`:** Similarly, specify the position of the side (`LEFT` or `RIGHT`) in the name.

###### Output Files

The script will generate:

- A full FASTA file with primer sequences.
- A TSV file with structured primer information.
- A BED file with insert regions.

###### Step 2: Store the files

1. Create a new folder (e.g., `v542`) under:

   ```Bash
   /cluster/project/pangolin/working/references/primers
   ```

2. Place all generated files in this folder.

3. Update the `primers.yaml` file with the corresponding entries for the new set.

###### Step 3: Configure Amplicon Coverage

To enable amplicon coverage analysis (specific to COVID data in `test_automation`), update the following setting:

```Bash
pangoling/pangolinscr/config/server.conf
```

Update the `remote_primer_bed` variable to point to the new BED file.

###### Cleanup

After all files have been added, clean up any partially processed results or temporary folders.
Use the `batman.sh` garbage function to remove the corresponding batch:

```bash
batman.sh garbage <batch_name>
```



### Storage Cleanup

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
  - **TODO**: With the current folder structure, covid has no dedicated subfolder and therefore `virusbase is set to`.`, indicating`/cluster/project/pangolin`. This will change after the folder restructuring.
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



## V-pipe

[WIP (This section is work in progress)]

### Logic

The internal V-pipe logic is:

- V-pipe's rule "timeline" takes the samples.tsv, applies a config file with regex and generates the date, location code and fullname code, and saves it into timeline.tsv
this should have all the samples of the wastewater cohort.
- rule "tallymut" merges the above file with the individual "mutations of interest" TSV files of each samples in the cohort (of each sample in samples.tsv) to make a big tally of all mutations.
- rule "deconvolution" runs LolliPop. LolliPop itself filters by "location", and runs deconvolution over the time-seires (by "date").
if location or date information are missing, there won't be any corresponding points in the curve.

**Example: RSV v-pipe**

For RSV there is a main sbatch job `/cluster/project/pangolin/processes/rsv/pangolin/working_vpipe/vpipe_rsv_aviti_main.sbatch`
This job spinns the sub-jobs for RSVA and RSVB.

V-pipe runs if:

- the batch is not in `fgcz.conf`
- the `project.$batch.tsv` is in `vpipe_input` directory
- the batch is newer than the previousely analyzed batch (from the log file)

**status file logic**

For vpipe there are main 4 status files created: `vpipe_started`, `vpipe_ended`, `vpipe.${now}`, `vpipe_new.${now}`
Purpose:

- `vpipe_started`: points at `vpipe.${current date}` (soft linked)
- `vpipe_ended`: saves the value of `vpipe.${current date}` inside, this is used to check when was the last completed vpipe run
- `vpipe.${now}`: is created as soon as a new vpipe run is started, to track the date of the day vpipe was run
- `vpipe_new.${now}`: stores the runreason inside, so the batch names of the batches that were not yet analyzed and thus triggered vpipe to be run

- the *TIMESTAMP* of vpipe_ended and vpipe_started are compared to decide if vpipe is still running or not

**How to force run vpipe in the automation?**

If e.g. a batch needed patching and the previous results were garbaged, vpipe will still think it ran successfully on it due to the status file logic which recored the last successfully ended vpipe batch.
To rerun the last batch, delete the vpipe_status file so batman.sh scanmissingsamples will rerun and check the output directories.

- link the `vpipe_started` to a `vpipe.${now}` that date is before the batch you want to rerun
- edit `vpipe_ended`, write in it `vpipe.${now}` 

```bash
docker exec -it $docker_image /bin/bash
cd ../working/status
ln -sf ${statusdir}/vpipe.${now} ${statusdir}/vpipe_started
```


### Manually run v-pipe

- What if vpipe is not running on some samples because they are older than 6 months? Manually run vpipe on those samples
- take the file /cluster/project/pangolin/processes/sars_cov_2/working/samples_aviti.tsv_six_months_ago.tsv (which is the samples.tsv file for vpipe used at present) and generate a new one that has only lines for the samples you want to run manually
- go to /cluster/project/pangolin/processes/sars_cov_2/pangolin/working and make a copy of vpipe_aviti.yaml, maybe call it vpipe_aviti_manual.yaml
- change in the yaml file the field samples_file: to point to vpipe_aviti_manual.yaml
- copy vpipe_aviti.sbatch and call the copy vpipe_aviti_manual.sbatch
- Modify the file so that
- --configfile vpipe_aviti_manual.yaml
- bonus points, change the name of the slurm job for easier tracking: ##SBATCH --job-name="COVID-Aviti-vpipe"  to ##SBATCH --job-name=“manual-Aviti-vpipe”
- Run the sbatch file sbatch vpipe_aviti_manual.sbatch

### Lollipop

[#Lollipop]

[WIP]


## WiseDB VM 

[#wisedbvm]

### Building Docker Container on the WiseDB VM 

[#docker]
[#wisedbvm]

**Background**

the wisdb VM showed limitations in the amount of allocated memory. Building a new image has become impossible, due the memory requirement of mamba/conda for updating an environment.
The agreed solution is to build the image locally, transfer it to wisedb, and deploy. That will be the solution until the memory problems are solved.

**Procedure**

The build must happen on a local machine, because the HPC clusters give access only to singularity and not to docker.

Building an image for a linux host from an ARM host, means adapting the configuration.

**Adaptations**

If build locally, the docker-compose.yaml  file has to be adapted.
Then the path in the docker-compose.yaml need to be adapted. (Both locally and on the vm (see below)).

#### docker-compose.yaml (local)

The context path need to point to the local version.

- context: /Users/mcarrara/data/ww/local_deploy/pangolin

#### docker-compose.yaml (vm)

On the VM change:

```Bash
build:
      context: /data/projects/wastewater_automation/pangolin 
```

to:

```Bash
image: $tag_of_the_image (e.g. pangolin_rsv:latest)
```

such that the docker is not build on the vm!

#### Building (locally)

First **Ensure you have the latest changes pulles on Euler and the wisedb and locally**
For a local build on Mac OrbStack can be used.

```Bash
## define the target architecture
export DOCKER_DEFAULT_PLATFORM=linux/amd64
##add gtime -v to get overview of resources
now=$(date '+%Y%m%d')
gtime -v docker-compose build --no-cache --progress=plain > ${now}_docker_build.log
## check the IMAGE ID with 
docker images
## add a meaningful tagging
docker tag f44abc678111 pangolin_rsv:latest
## The hex value is the ID of the image to save
docker save -o ./pangolin-pangolin.tar IMAGE_ID (e.g."f44abc678111")
```

#### Deploy

If a Container is redeployed e.g. after a change in the code base the automation docker was rebuild on the latest version of the git commit) the old Container need to be stoped and removed.

How to stop and remove the docker
- `docker ps -a`: to find the name
- first `docker stop <containername>`
- if the docker stops or fails we need to remove the old container with : `docker rm <container name>`
- `docker image rm <image name>`

- Transfer the tar archive to wisedb in directory
  - on date 2025-04-14, the local deploy follows the commit 292bbba2c8644134f97f3e05614ead75a72e9d99
  - create a directory (or add it to the existing: `/data/projects/rsv_automation_restructuring/local_deploy`)
  - mkdir commit_"commit the container was build on"
  - copy the .tar file there and the adapted docker-compose.yaml wiht the path pointing to the vm folders and the substitution of buil to image (see above)
  
- on wisedb, run:
- this extractes the image

```Bash
##this extractes the image
docker load -i pangolin-pangolin.tar
```

- sometimes tagging again is necessary: `docker tag f44abc678111 pangolin_rsv:latest`
- copy the `docker-compose.yaml` with the VM path and remove the `build:`section and add `image: pangolin_rsv:latest`

```bash
##start the image with 
docker-compose -p pangolin_rsv up -d
docker-compose -p pangolin_iva up -d
docker compose -p sars_cov_2 up -d
```

This will take the defined path form the docker-compose.yaml file to point to all the secret files etc on the VM.
Make sure that the image already exists such that it is NOT BUILD on the VM!

___

#### Deploy on VM (not recommended - not tried yet)

If the container has to be deployed on the VM try to set a low nice vlaue such that this porcess gets ressources last and does not interrupt any other processes on the VM.
Set this in Dockerfile:

```bash
RUN nice -n 19 ionice -c 3 ulimit -v $((1024*1024)) && conda …
```

___



## Covid Json File Postprocessing

(These are steps that are performed outside the automation as a semi automated postprocessing script)

**Json file postprocessing steps**

Lollipop generates the file containing the time-dependent COVID variant deconvolution:`/cluster/project/pangolin/processes/sars_cov_2/lollipop/variants/deconvoluted_upload.json`

This file is postprocessed in several ways and subsequently uploaded (CovSpectrum, Polybox, wiseDB).
The postprocessing steps are described below.

**Overview**

```mermaid
  flowchart TD
    A["deconvoluted_upload.json<br/>(Lollipop output)"]
        --> B["make_curves.sh"]

    B --> C["enhanced_nested_json_stitching.py"]
    X["old backup <br/>deconvoluted_upload.json"] --> C
    C --> D["stitched full-history JSON"]

    D --> E["ww_cov_curves_v-pipe.py"]
    E --> F["update_data_combined_file<br/>(combined processed JSON <br/>+ plots)"]
    E --> G["update_data_covspectrum<br/>_file<br/>(CovSpectrum export)"]
    E --> H["reformatted<br/>(BAG / Polybox export)"]

    D --> I["merge_json.py"]
    Y["curves_untracked_wwtps<br/>.json<br/>(historical discontinued WWTPs)"] --> I
    I --> J["ww_update_data_wisebd<br/>.json<br/>(wiseDB upload JSON)"]
    J --> K["ww_cov_uploader_v-pipe.py<br/>(wiseDB upload)"]
```

___

### `make_curves.sh`

```
cd /cluster/project/pangolin/
resources/cowwid/for_communication/scripts/make_curves.sh
```

This Bash script calls three Python scripts:

* `enhanced_nested_json_stitching.py`
* `ww_cov_curves_v-pipe.py`
* `merge_json.py`
 
**High-Level Logic:**

Since Lollipop is run only on a chunk of the data, the deconvolution outputs must be “stitched” together to obtain a complete `deconvolution.json` file covering the entire cohort (all data since the beginning).
This ensures that downstream processes, which are already established and depend on a stable data format, do not break.
The stitching is performed by `enhanced_nested_json_stitching.py` and is described in the section **#curvestitching**.
The resulting stitched file is then passed to `ww_cov_curves_v-pipe.py`, where the curves are filtered and restructured into three different output formats.
This script is described in **#MultiPlatformVariantExport**.
Finally, `merge_json.py` processes the data specifically for upload to wiseDB.
The Lollipop-generated file contains data only for currently tracked treatment plants. However, wiseDB requires data for all treatment plants, including discontinued ones. Therefore, historical data from discontinued treatment plants is merged into the JSON file before upload.
An overview of this script is provided in **#historicalmergejson**.

### Curve stitching

#curvestitching

Relevant folder with scripts on euler: `/cluster/project/pangolin/resources/cowwid/json_parser_for_variant_curve_stitching`

- it is version controlled in the cowwid git repo master branch

- adapt and run the bash script:
`/cluster/project/pangolin/resources/cowwid/json_parser_for_variant_curve_stitching/scripts/run_stitching.sh`

For the **regular processing** this script is called from: `/cluster/project/pangolin/resources/cowwid/for_communication/scripts/make_curves.sh`

- to generate a start curve as stitched curve i ran `/cluster/project/pangolin/resources/cowwid/json_parser_for_variant_curve_stitching/scripts/run_stitching.sh`with the folowing 2 files:

```bash
old_backup_curve="/cluster/project/pangolin/processes/sars_cov_2/lollipop/reporting_20Jan2026/deconvoluted_upload.json"
new_only_few_month_curve="/cluster/project/pangolin/processes/sars_cov_2/lollipop/variants/deconvoluted_upload.json"
```

- after that the enhanced_nested_json_stitching.py script is called from the make_curves.sh script

**Purpose**

This script stitches two nested JSON datasets containing time series data
(e.g. SARS-CoV-2 variant proportions) by location and variant, while enforcing
a strict alignment of time points.

The output guarantees that, within each location, all variants share the
same date grid and can therefore be compared, plotted, or diffed reliably.

**Input Data Model**

The input JSON files are expected to have the structure:

```bash
{
  "Location": {
    "Variant": {
      "timeseriesSummary": [
        {
          "date": "YYYY-MM-DD",
          "proportion": float,
          "proportionLower": float,
          "proportionUpper": float
        },
        ...
      ]
    },
    ...
  },
  ...
}
```

#### Core Stitching Rules

1. Stitching cutoff (per location):
   - The stitch date for a location is the earliest date present in the NEW file for that location.
   - OLD data is kept only for dates strictly before the stitch date.
   - NEW data is kept for all dates.
   - If a date exists in both OLD and NEW, NEW always takes precedence.

1. Date identity:
   - Dates are treated as the primary key of the time series.
   - Internally, time series are indexed by date to avoid order-dependent logic and to enforce one entry per date.

1. Shared date grid (critical invariant):
   - For each location, a shared date grid is constructed as the union of all dates observed in OLD and NEW across all variants.
   - Every variant at that location is expanded to this grid.
   - Missing dates are filled with zero-valued entries:
       proportion = 0
       proportionLower = 0
       proportionUpper = 0

1. Newly introduced variants:
   - Variants that appear only in the NEW file are back-filled with zeros for all earlier dates in the location’s grid.
   - This ensures all variants align in time, even if they emerge later.

1. Locations present in only one file:
   - If a location exists only in OLD or only in NEW, its data is preserved, but the shared date grid invariant is still enforced within that location.

#### Design Rationale

- Lists are unsuitable for time series logic because their index has no semantic meaning. Dates are therefore treated as explicit keys.
- Enforcing a shared date grid avoids downstream issues in plotting, statistical comparison, and DeepDiff-based validation.
- Zero-filling missing dates makes variant curves directly comparable and preserves total alignment across variants.

#### Output Guarantees

- All timeseriesSummary lists are:
  - sorted by date
  - unique by date
  - identical in length across variants within a location
- The output JSON is deterministic and stable under repeated stitching.

#### Typical Use

```bash
    python stitch_variants.py \
        --old older.json \
        --new newer.json \
        --output stitched.json
```

### Variant Deconvolution Processing & Export Pipeline

#MultiPlatformVariantExport

#### Overview

This script:

- Loads smoothed variant time-series data
- Applies location-specific start-date filtering
- Generates multi-location plots
- Produces three different JSON outputs, each tailored to a different downstream consumer
  - The key difference between outputs is how the same processed data is filtered and structured.

#### Workflow

```Bash
1. Load smoothed JSON
2. Apply start-date filtering
      ↓
   → Base dataset ("update_data")
      ↓
3. Plot generation (uses this dataset)
      ↓
4. Write Combined JSON
5. Apply blacklist → Cov-Spectrum JSON
6. Restructure → FOPH/BAG JSON

``` 

#### Usage

```bash
cd /cluster/project/pangolin/resources/cowwid/for_communication/scripts/
python ww_cov_curves_v-pipe.py path/to/config.yaml
```

The script requires exactly one argument:

* `config.yaml`: YAML configuration file containing all input/output paths and parameters.

#### Input Data Format

The smoothed JSON (`jsonfile_smooth`) must follow this structure:

```json
{
  "Location_A": {
    "Variant_X": {
      "timeseriesSummary": [
        {
          "date": "YYYY-MM-DD",
          "proportion": 0.123,
          "proportionUpper": 0.150,
          "proportionLower": 0.100
        }
      ]
    }
  }
}
```

#### Processing Steps

#### Json Output Files

The script produces three JSON outputs.

___

**_1. Combined Processed Data_**

**File:** `update_data_combined_file`

**What it contains:** 

- Filtered time-series data (start-date rules applied)
- adds "mutationOccurrences"

**Structure:**

```json
{
  "Location_A": {
    "Variant_X": {
      "timeseriesSummary": [...],
      "mutationOccurrences": null
    }
  }
}
```

Location-specific start dates can be defined inside the script:

```python
only_start_from = {
    "Kanton Zürich": "2021-08-15",
    "Lausanne (VD)": "2023-01-01",
    "Basel (BS)": "2024-02-01"
}
```

- All timepoints earlier than the defined threshold are removed.
- This ensures reporting begins only from approved dates.

Purpose:

* Internal dashboards
* Reporting systems
* Archival storage
* plotting

**Notes on Plot Generation:**

* Fixed 3 × 2 subplot grid (supports up to 6 locations)
* One panel per location
* All variants plotted per panel
* Confidence intervals shown as shaded ribbons
* Only last 80 timepoints per variant are plotted

Saved in `plots_dir`:

```
combined-vpipe.pdf
combined-vpipe.svg
combined-vpipe.png
```


---

**2. Cov-Spectrum Export**

**File:** `update_data_covspectrum_file`

**What changes compared to Combined?**
- Applies blacklist filtering
- Removes specific (location, date) entries from all variants

**Additional Processing:**

Entries defined in `blacklist` are removed:

```yaml
blacklist:
  - location: "Location_A"
    date: "YYYY-MM-DD"
    reason: "Data quality issue"
```

All matching dates are removed from all variants at that location.

Purpose:

* Clean upload to Cov-Spectrum
* Removal of problematic reporting dates

---

**3. FOPH/BAG Reformatted Export**

**File:** `reformatted`

**What changes compared to Combined?**
- No blacklist removal
- Data is restructured

Data is reorganized by **variant** first:

```json
{
  "Variant_X": {
    "Location_A": {
      "timeseriesSummary": [...]
    }
  }
}
```

Purpose:

* Submission to FOPH/BAG (Polybox)
* Variant-centric reporting format


**Assumptions & Constraints**

* Smoothed JSON must follow expected nested structure.
* All variants must have defined colors.
* Plot layout supports up to 6 locations (fixed grid).
* Proportions expected within [0,1].
* Blacklist entries must reference valid location/date pairs.

___

### `merge_json.py` documentation (for WiseDB upload)

#historicalmergejson

This script `merge_json.py` processes the data exclusively for the upload to the wiseDB. 
The lollipop generated file only outputs data for currently tracked treatment plats. 
However, the wiseDB wants data of everything. Thus, the "historical" data with discontinued treatment plats is merged to the json file for the wiseDB upload.

Merge two nested JSON files into a single JSON, while **blocking duplicates at the first two nesting levels** (e.g. `location/variant` collisions).

**Usage:**

```bash
python merge_json.py static_historical_first.json stitched_second.json output_merged.json
# real example:
python $curve_analysis_dir/scripts/historical/merge_json.py \
"$curve_analysis_dir/resources/curves_untracked_wwtps.json" \
"$analysis_dir/results/stitched_curve_${ts}.json" \
"$curve_analysis_dir/output/ww_update_data_wisebd.json" \
 > "$curve_analysis_dir/logs/merge_json_${ts}.log" 2>&1
```

**Arguments**

* `first_json`: base JSON (kept unless overridden by merge rules)
* `second_json`: JSON to merge into the first
* `output_json`: path to write merged result

**Data flow for wiseDB upload:**

```Bash
1. Lollipop output
      ↓
2. processing with enhanced_nested_json_stitching.py
      ↓
3. processing with merge_json.py
      ↓
4. upload to wiseDB with ww_cov_uploader_v-pipe.py
``` 
___

**Merge rules (high-level)**

The merge is recursive:

* **dict + dict**: merge keys

  * if a key exists in both:

    * values are merged recursively if possible
    * otherwise, the value from `second_json` overrides
* **list + list**: concatenated (`a + b`)
* **anything else**: value from `second_json` overrides

**Duplicate protection (the main safety check):**

Before merging, the script checks **only the first two levels**:

* For every `top_key` in `second_json` (level 1)
* For every `sub_key` under that top key if it’s a dict (level 2)
* If `first_json[top_key][sub_key]` already exists → **error + exit**

This prevents silent overwrites of entries like:

* `Location/Variant`
* `Project/Sample`
* `Group/Item`

(If you *want* second.json to overwrite existing `top_key/sub_key` entries, you would need to remove/relax the duplicate check—currently it is strict by design.)

___


## Postprocessing and uploads

[#wisedb]

### Json upload - wiseDB

If uploads to wiseDB fail form the uploader script, an mail is sent with the header "all_upload_extract_load error". This means that something with the file changed and thus the upload was rejected.
This error will stop the whole wiseDB uploading pipeline for EVERYBODY! Thus, it is crucial to monitor this and reject the upload immediately once you see that the upload did nod succeed.
To reject the upload:

- go to <https://wisedb.ethz.ch/admin/site/upload/otherfileuploadbatch/>
- login with your credentials (every user has it's own credentials)
- on the left scroll down to: UPLOAD > other file batches
- find the just uploaded file and click on it
- check the file and klick reject

Then figure out what is wrong with the file and reupload the corrected file.
In case someting does not work as described contact someone from the wiseDB team.

### Sequence upload wisedb_uploader - wiseDB

[WIP] currently out of order

The sequence upload to wiseDB happen from the wiseVM. (TODO: can this be done directly from Euler to avoid double data transfer?)
The uploader script is: `/data/projects/wisedb_uploader/upload_to_wisedb.sh`
This script expects two arguments. The first one is the path to the sample data directory (e.g. `/data/projects/wisedb_uploader/tmp_toupload`).
This directory should contain samples in the following strucutre:

```Bash
sample
|_ batch
   |_alignments
   |_raw_uploads
   |_references
```

The second one is a random string which serves as a switch and will be removed soon, since the else of the function is depreciated.
Importantly, in the request the file order and checksum order is fixed and cannot be changed!
In case of "Bad request" a person vom wiseDB needs to be contacted.
Import checks are based on the metadata which are taken from the file string. There is no metadata file. Uploaded file contents are not checked.


### Uploader to SPSP

[WIP] currently out of order

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

### Amplicon Coverage Covid

The Amplicon Coverage plot is created automatically by the automation and can be found for each batch at:
`/cluster/project/pangolin/work-amplicon-coverage`

___

### CovvFit

[CovvFit](https://github.com/cbg-ethz/covvfit/tree/main) is a tool for Fitness estimates of SARS-CoV-2 variants from variant abundance data. It is part of the regular processing.

However, the following is only an INTERMEDIATE solution until covvfit will be art of v-pipe (at the end of 2025).
The purpose of this folder is to run the covvfit analyisis discribed in htis tutorial: <https://github.com/cbg-ethz/covvfit/blob/main/docs/running_deconv/lollipop.md>

**Disclaimer**
the lollipop installation used for regular processing in in vpipe. This repo is only an **intermediate** solution until covvfit will be a rule provided by vpipe.
Thus, also the Lollipop installation should be **removed** once covvfit is integrated in v-pipe!

**Folder strucutre**

- analysis: store the config, scripts and results
- envs: store the conda env needed to run covvid (incl. lollipop)
- git: stores the lollipop installation to run covvfit

**Procedure**

1. regular processing incl. lollipop run --> this provides the updated files (e.g. tallymut.tsv) to run the **second** lollipop here without smoothing
2. rerun lollipop with: `/cluster/project/pangolin/cowwid/covvfit/analysis/lollipop/scripts/run_covvfit_lollipop.sbatch`
3. run covvfit with: `/cluster/project/pangolin/cowwid/covvfit/analysis/covvfit_analysis/scripts/run_covvfit.sh`

**running the code**

```Bash
cd /cluster/project/pangolin/cowwid/covvfit/analysis/lollipop/scripts
sbatch /run_covvfit_lollipop.sbatch
```

```Bash
cd /cluster/project/pangolin/cowwid/covvfit/analysis/covvfit_analysis/scripts
./run_covvfit.sh
```
___

## Backups [WIP]

### bewi08 VM

We make regular backup of the analysed data. This is done by a VM called `bewi08`.
Inside this we have a script that runs these backup: `/links/shared/covid19-pangolin/backup/automation_backups/pangolin/automation_backups.sh`.

The folder `/links/shared/covid19-pangolin` is mount to thin VM. This folder is stored inside a physical storage in D-BSSE.
If there is some storage maintenance done in the storage at the D-BSSE the link to this folder can break. Then, the folder has to be remounted to the VM with the following commands:

1. to unmount the backup folder on bewi08: `sudo umount /links/shared/covid19-pangolin`
2. to mount: `sudo mount /links/shared/covid19-pangolin`

basedir=/links/shared/covid19-pangolin/backup
bfabric_downloads=bfabric-downloads
bfabric_project=p23224

exclude list for the backup: `/cluster/project/pangolin/processes/status/sync/fgcz.exclude.lst`

### Rsync Backup Configuration for FGCZ Data (raw data)

#### Overview

The backup of FGCZ raw data is performed via rsync from the backup server (`bs-bewi08`) to the Euler cluster. The process uses SSH tunneling to connect to Euler's rsync daemon, which serves data from predefined modules. The `rsyncd.conf` file configures these modules (e.g., paths, permissions).

#### Key Components

- **Client (Backup Server)**: `automation_backups.sh` (branch: `sarscov2_automation_backups`) initiates the rsync pull using SSH:

```bash
rsync -e "ssh -i key -l user" host::module /local/path
```

- **Server (Euler)**: SSH key is restricted by `authorized_keys` to run:
  `command="/path/to/batman.sh ${SSH_ORIGINAL_COMMAND}"`
  This executes `batman.sh` with the rsync command as arguments.
- **batman.sh** (branch: `sarscov2_folder_restructuring`, file: `pangolin_src/batman.sh`): Parses the command and runs the rsync daemon:

```bash
rsync --server --daemon --config "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/rsyncd.conf" .
```

- **rsyncd.conf** (branch: `sarscov2_folder_restructuring`, file: `pangolin_src/config/rsyncd.conf`): Defines modules (e.g., `[bfabric-downloads]` with path and settings). Located at `${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/rsyncd.conf` on Euler.

#### How It Works

1. Backup server SSH-connects to Euler with rsync command.
2. Euler's `authorized_keys` forces execution of `batman.sh rsync --server --daemon .` (original command).
3. `batman.sh` launches rsync daemon with custom config, serving data from modules.
4. Rsync transfers data (full or recent, based on `--recent` flag).
5. Status logged as `SUCCESS`/`FAILED`.

#### Recent Change

Added `--config "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/rsyncd.conf"` to `batman.sh`'s rsync case to use the git-managed config from the `sarscov2_folder_restructuring` branch instead of default `/etc/rsyncd.conf`. Ensures consistent module definitions across environments. Test by running the backup and checking logs.

### Backup of raw data form FGCZ - dev notes to be reviewved and cleaned up after backup issue resolvement

happen in the fgcz data sync automation

24 February 2026 preliminary notes:

- backup to bewi08 via **rsync deamon**
- runns is the fgcz sync automation (for raw data = raw downloads form fgcz data)
- in fgcz_sync.sh backup is triggered with the function: `${remote_backup} pull_fgcz_data --recent`
- `remote_backup`is defined in the .ssh/authorized_keys on the bewi08 vm (it is a bash script on the bewi08 VM `/links/shared/covid19-pangolin/backup/automation_backups/pangolin/automation_backups.sh`)
- in this script the function `pull_fgcz_data` is defined
- it rsyncs the data in folder: `belfry@euler.ethz.ch::${bfabric_downloads}/${bfabric_project}`
  - this is a rsync **daemon module** that is defined on euler / in the pangolin git repo in `pangolin_src/config/rsyncd.config`
  - in this file the path what data it should sync is defined and needs to be up to date

```Bash
Bfabric storage (real filesystem path, hidden)
        ↓
rsync daemon exports it as module "bfabric-downloads"
        ↓
Your backup VM connects via rsync protocol
        ↓
Your script copies module/p23224
        ↓
Stored locally in ${basedir}/${bfabric_downloads}/${bfabric_project}
```

Backup directory on Bewi08:

- raw data: `/links/shared/covid19-pangolin/backup/bfabric-downloads/p23224`

Ports:

- wisedbVM → bs-bewi08 (port 22)
- bs-bewi08 → euler.ethz.ch (port 873)

There are special firewall rules in place to allow communication between the systems. In case of problem, contance BSSE IT Helpdesk.

**Exclude list / blacklist for backup:** (on wisedbVM)
`/data/projects/fgcz_data_sync_automation/workdir/status/remote_sync/fgcz.exclude.lst`

**STATUS Files** (on backup machine bewi08)
`/links/shared/covid19-pangolin/backup/automation_backups/status`

### Systems / scriprs working together

On the wisedbVM

```Bash
if [[ "${skipsync}" != "fgcz" ]]; then
    ${remote_batman} sync_fgcz --ftp --recent
    ${scriptdir}/belfry.sh pull_sync_status
    if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then
        echo "\e[31;1Pulling sync status files failed\e[0m"
        echo "The automation will not be aware of any new deliveries"
    else
        if [ $backup_fgcz_raw -eq "1" ]; then
            # Backup of the raw data form fgcz to the backup location
            # remote_backup is a wrapper for executing a remote command over SSH where the function pull_fgcz_data is defined in a .sh script on the backup machine
            ${remote_backup} pull_fgcz_data --recent
            if [[ ( -e ${statusdir}/pull_sync_status_fail ) && ( ${statusdir}/pull_sync_status_fail -nt ${statusdir}/pull_sync_status_success ) ]]; then #check the correct files
                echo "\e[31;1Backup of fgcz raw data failed\e[0m"
                echo "The system will retry next loop"
            fi
        else
            echo "\e[33;1mBackup of FGCZ raw data DISABLED\e[0m"
        fi
    fi
fi
```

On the backup machine bewi08 where remote_backup is executed:
```Bash
pull_fgcz_data)
        echo "backup of the FGCZ raw data"
        custom_date=$(date -d "6 months ago" +%Y/%m/%d)
        err=0
        if [[ "${2}" = "--recent" ]]; then
            dirs=$(rsync --timeout=${iotimeout} \
             --password-file ~/rsync.pass.euler \
             -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} -oConnectTimeout=${contimeout}" \
             --list-only \
             belfry@euler.ethz.ch::${bfabric_downloads}/${bfabric_project}/ |\
             awk -v d="$custom_date" '$3 > d { print $5 }' | tail -n +2)
            timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync --timeout=${iotimeout}  \
                     --password-file ~/rsync.pass.euler \
                     -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} -oConnectTimeout=${contimeout}" \
                     -izrlH --fuzzy --inplace \
                     -p --chmod=Dg+s,ug+rw,o-rwx \
                     -g --chown=:"${storgrp}" \
                     --files-from=<( printf "%s\n" "${dirs[@]}" ) \
                     belfry@euler.ethz.ch::${bfabric_downloads}/${bfabric_project} \
                     ${basedir}/${bfabric_downloads}/${bfabric_project} || (( ++err ))
        else
            timeout ${timeoutforeground} --signal=INT --kill-after=5 $((rsynctimeout+contimeout+5)) \
                rsync --timeout=${iotimeout}  \
                        --password-file ~/rsync.pass.euler      \
                        -e "ssh -i ${HOME}/.ssh/id_ed25519_belfry -l ${cluster_user} -oConnectTimeout=${contimeout}"    \
                        -izrlH --fuzzy --inplace       \
                        -p --chmod=Dg+s,ug+rw,o-rwx     \
                        -g --chown=:"${storgrp}"        \
                        belfry@euler.ethz.ch::${bfabric_downloads}/ \
                        ${basedir}/${bfabric_downloads}/ || (( ++err ))
        fi
        if (( err )); then
            echo "FAILED" | tee ${backup_statusdir}/pull_fgcz_status_${now}
        else
            echo "SUCCESS" | tee ${backup_statusdir}/pull_fgcz_status_${now}
        fi
    ;;
```

On Euler:
the rsync daemon is started with an explicit config path:
`--config "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/rsyncd.conf"`

This means it no longer depends on a `~/rsyncd.conf` file or the default `/etc/rsyncd.conf`.



### Backup of processed data

do they happen in the sars_cov_2 automation?


## Appendix


### Naming conventions

**Samples:**
FlowCellArrayPosition_TreatmentPlant_SamplingDate

**Batch:**
SequencingRunDate_FlowCellID (named in batman.sh sortsamples function)

### Old working folders

This section should be kept to give an idea when old folders on Euler have to be searched.
The old setup is stored on Euler: `/cluster/project/pangolin/old_setup/not_necessary`
**V-pipe**
There is one v-pipe installation which is called from everywhere (all the viruses): '/cluster/project/pangolin/V-pipe'

**work-vp-test**
Working folder to run lollipop for covid. Points also at '/cluster/project/pangolin/V-pipe'. This should be included in the future in pangolin/working (main covid working directory).

**Covid**
The SARS CoV19 directory where the regular analysis takes place (lollipop) is `/cluster/project/pangolin/work-vp-test`

- corresponding blacklist: `/cluster/project/pangolin/resources/lollipop_blacklist.txt`
- the vpipe is run in : `/cluster/project/pangolin/working` (go here to check the slurm-out of vpipe)
  - in the slurm-out (main) it tells you which batches it checks for new samples, but this does not mean that it runs on all of these batches, it only checks if there are samples that have not yet been aligned by v-pipe!
- config files for covid vpipe: `/cluster/project/pangolin/test_automation/pangolin/pangolin_src`

The folder for the covid autoamtion on euler is: '/cluster/project/pangolin/test_automation/pangolin'
'/cluster/project/pangolin/test_automation' is the main folder in the covid automation. However, the working in test_automation is outdated and we use '/cluster/project/pangolin/working'.
In this working folder there is also the results directory (huge directory which sould not be copied!) - this will be restructured soon.
