# Log book wastewater

## TODO Checklist

### Pipeline setup and cleanup

- [ ] Revise the SARS-CoV-2 setup to ensure it is configured correctly, uses the correct files, and is fully tracked in git.
- [ ] Clean up duplicated COVID files and relative paths in code and `.sbatch` files so it is clear what is actually used in the analysis.

### Uploads and automation

- [ ] Investigate why the `genspectrum` upload API review/approval step fails.
- [ ] Investigate repeated failures when copying/linking files in the RSV or IVA automation.
- [ ] Add batch information to the `spsp` upload log.

### LoFreq and resource handling

- [ ] Reduce the temporary LoFreq resource increase again after this season.
- [ ] Consider subsampling raw `.fastq` files as an alternative.
- [ ] Consider adding a subsampling function directly into the automation.

### Influenza experimental dataset

- [x] Blacklist the influenza experimental dataset once the full sample or batch name, including sequencing date, is known.
  Not needed, as the batch was not submitted to the regular processing project.

TODO:
- iva and rsv are structured and folder are cleanedup, however, sarscov should be once more revised to ensure it is setup correctly and uses the correct files and everything is tracked on git
  - for covid there are still duplicated files and many relativ path in the code /.sbatch files which makes it hard to track what is acutally used in the analysis
- covid: reenable archival run once raw_data file permissions are fixed - done
- /cluster/project/pangolin/processes/status is the status directory for the fgcz sync --> correct
- genspectrum upload: the api review and approve of the sequenced fails
- repeated fail to copy/link files in the rsv or iva automation
- spsp upload add batch to upload log

23 March 2026:

- note form fgcz about sequencing troubles in order 41461 

16 March 2026:

- Performed regular processing tasks.
- Discussed how to proceed with samples showing unexpectedly increased read depth, and considered alternatives to excluding them from the analysis.
- Tested dynamic resources in the profile. Conclusion: this is not supported in Snakemake 7.32.4.
- Increased LoFreq resources to allow runs of up to 3 days and 32 GB RAM.
- To do: This should remain an intermediate solution only and be reduced again after this season.
- Alternative to do: Subsample the raw `.fastq` files or add a subsampling function to the automation.

13 March 2026:

Batch 20260306_2530611610

- needed to exclude samples as no time / memory combination was found such that lofreq finished in time
- Excluded:
  - IA_H1 sample C3_25_2026_02_17: Processed 898074 reads (`/cluster/project/pangolin/processes/influenza/IA_H1/working/cluster_logs/lofreq/lofreq-60210251.err.log`)
  - RSVA/B sample B3_17_2026_02_22: Processed 7534734 reads (`/cluster/project/pangolin/processes/rsv/RSVA/working/cluster_logs/lofreq/lofreq-60189290.err.log`)
- to be able to exclude these samples a new functionality had to be introduced in the automation: sample specific badlist
  - added variables in fgct.conf where single samples can be added
  - added filtering for these samples in batman.sh addsamples and scanmissingsamples


Order 41026 (https://fgcz-bfabric.uzh.ch/bfabric/order/show.html?id=41026&tab=comments)
  - comment of bfabric: "from this order on, we're adjusting the annealing temperature for IAV to 62C, since we observed better coverage for H1, H3, N1 and N2 with this temperature"
Observation: since this change we observe lofreq timeout, suggesting more reads to process


3 March 2026:

- The bsse IT added a firewall rule to explicitally allow the systems to communicate with eachother
- Before this there were no backups of every thing incl. the raw data to bewi08: Mind august 2025 - March 2026
  - the raw data is now backing up again

23 Feb 2026

- stoped the iva and rsv autoamtion
- needed to garbage the latest batch 20260220_2529664984 for all iva subvariants as there was the sam2bam problem and lofreq timeout
- RSV: lofreq timeout for sample C1_10_2026_01_28/20260220_2529664984
  - **Slow sample:** `Processed 2233180 reads`
  - **Fast sample:** `Processed 422663 reads`
- rsv and iva the lofreq time was adjusted in the vpipe yaml file from 160 to 200
- docker iva and rsv start


23 Feb 2026 backup notes:

Example backup log section:

```Bash 

=========
Data sync
=========
Running in FTP mode
Sync FGCZ - bfabric
Syncing from node eu-login-39
syncing recent: 20250823	excluding: 35 /cluster/project/pangolin/processes/status/sync/fgcz.exclude.lst
connect sftp://carrara:<PASSWORD>@fgcz-gstore.uzh.ch:666
lftp -c set cmd:move-background false; set net:timeout 30; set net:max-retries 10; set net:reconnect-interval-base 8; set xfer:timeout 300; connect sftp://carrara:<PASSWORD>@fgcz-gstore.uzh.ch:666; cd /projects; mirror --only-newer --continue --no-perms --parallel=8 --loop  --directory=p23224 -O /cluster/project/pangolin/data/fgcz_raw  --newer-than='20250823'  --exclude-rx-from='/cluster/project/pangolin/processes/status/sync/fgcz.exclude.lst'
No files to sync found
/app/fgcz_sync vs /app/workdir
belfry.sh pull_sync_status
Pulling the updated status of the raw data sync
Unknown --groupmap name on receiver: bs-pangolin-group
>f..t...... fgcz.exclude.lst
>f..t...... sync_fgcz_success
ssh: connect to host bs-bewi08 port 22: Connection timed out
Mon, 23 Feb 2026 14:00:49 +0000
loop...
Starting loop for: 7200 sec
The scripts are in /app/fgcz_sync
The base working directory for the automation is /app/workdir
The current automation run is based on:
/app/fgcz_sync vs /app/workdir
belfry.sh get_pangolin_commit
fatal: not a git repository (or any of the parent directories): .git
fatal: not a git repository (or any of the parent directories): .git
Branch: \n
=========
Data sync
=========
Running in FTP mode
Sync FGCZ - bfabric
Syncing from node eu-login-30
syncing recent: 20250823	excluding: 35 /cluster/project/pangolin/processes/status/sync/fgcz.exclude.lst
connect sftp://carrara:<PASSWORD>@fgcz-gstore.uzh.ch:666
lftp -c set cmd:move-background false; set net:timeout 30; set net:max-retries 10; set net:reconnect-interval-base 8; set xfer:timeout 300; connect sftp://carrara:<PASSWORD>@fgcz-gstore.uzh.ch:666; cd /projects; mirror --only-newer --continue --no-perms --parallel=8 --loop  --directory=p23224 -O /cluster/project/pangolin/data/fgcz_raw  --newer-than='20250823'  --exclude-rx-from='/cluster/project/pangolin/processes/status/sync/fgcz.exclude.lst'
No files to sync found
/app/fgcz_sync vs /app/workdir
belfry.sh pull_sync_status
Pulling the updated status of the raw data sync
Unknown --groupmap name on receiver: bs-pangolin-group
>f..t...... fgcz.exclude.lst
>f..t...... sync_fgcz_success
ssh: connect to host bs-bewi08 port 22: Connection timed out
Mon, 23 Feb 2026 14:23:13 +0000

```


2 feb 2026:

- sample named needed to be patched: order o40900 batch 20260123_2519411291
- in this batch the sample names needed to be fixed AND it is the first bach that we used with the json parser to append the curves
Patching:
- stopped all 3 virus automations
- created patch.23224.40900.tsv with the exact content that was sent to us from eawag on the 30th january 2026 (added it to the vpipe_input filder of all 3 viruses)
- garbaged covid with the batman.sh garbage function
- garbaged iva and rsv:
  - with the pangolin_src/garbage.sh (for all subtypes except MP)
  - and with the pangolin_scr/garbage_input_vpipe.sh
  - added section to the garbage_input_vpipe.sh to move the mutaiton table formt he downstream processing to the old folder
  - needed to also go manually into the container and delete the downstream status file that records the successfull run for this batch
- started the docker conatiner and deleted downstream analysis status file that records the successfull run for this batch
- checked the logs to confirm that all 3 automations used the patching file

lollipop:
- ran the following command: in: `/cluster/project/pangolin/processes/sars_cov_2/lollipop`
  - find . -type d -name '20260123_2519411291'
  - `find . -type d -name '20260123_2519411291' -prune -exec rm -rf {} +` to delete the worngly named samples
  - find . -type d -name '20260123_2519411291'

29 Jan 2026:
Gaol include the new variant in to automation.
- discovered that the blacklisted batch somehow was copied to the lollipop results
- thus i ran the following command: `find . -type d -name '20251031_2505509054' -prune -exec rm -rf {} +`
- in the folder `/cluster/project/pangolin/processes/sars_cov_2/lollipop/results`
- (this was necessary as the lollipop wanted to run on these samples but failed due to missing input exception)
- needed to extend bring_resutls to inclue the six month ago samples.tsv file
- changed the vpipe.config : excluded the tmp folder and added absolut path

curve stitching:
- added all the test and documentation to `/cluster/project/pangolin/resources/cowwid/json_parser_for_variant_curve_stitching` on euler

KW2: 9 Jan 2026
- reactivated the covid raw carm file backup to wiseDB VM
- received the oder ID of influenza experimental data set which i only can blacklist once the full name (including the sequencing date) is known --> not needed, as the batch was not submitted to the regular processing project
- started onboarding severin in kw2

16 dec 25:
- added the order o40457_Aviti_251212_AV140 to badlist in fgcz.conf as it is an experimental batch for influenza
- manually deleted the results for this in the vpipe output driectory in covid
  - C1_10_2025_11_05/20251212_2513594616
  - E2_05_2025_11_13/20251212_2513594616
  - F2_05_2025_11_14/20251212_2513594616
- need to check for rsv and influenza

November 2025:
- restructuring of rsv and IAV_analysis
- changed all folder ownershipt on wisedb to kkirschen
- Dockerfile: updated to debian:bullseye-small, as the previous demian version was depreciated

5 May:
Claenup script and blacklisting of batches
1. add last weeks batch to balcklist for Influenza and RSV: Batch 20250417_2427493980 order o38285_Aviti_250417_AV093

week 3march - 7March:
- worked on investigating the unexpected results for covid samples
- added LP.8 to test instance
- regenreated signature of JN1, KP2, KP.2, XEC and LP.8 and rerun with test instance
- added changes to deployed instance
- added changes to dashboard (color for LP.8) pinged chaoran (he responded very fast)

3 March:
Continues rsv downstream analysis: challenge integrate the uplades with the locally stored downstream analysis
- on wisedb created a folder in rsv_downstream analysis: /data/projects/rsv_downstream_analysis/rsv_downstream_analysis
- there cloned the rsv repo from auguste
- create branch to have a dev pangolin branch
- changed the necessary things in the make_mutation_tsv_annotated.py script 
  - added the current version of the rsv_downstream_analysis.py to wisedb folder: rsv_downstream_analyisis
  - to have it available for adaptations in the new git version script
- pulled repo on euler and switched to pangolin dev branch: 
- /cluster/project/pangolin/rsv_pipeline/rsv_downstream_analysis/RSV_wastewater/regular_monitoring_2024_2025/utilities/regular_monitoring_2024_2025/make_mutation_tsv_annotated.py
- the updated batman.sh i was working on several weeks ago: /cluster/project/pangolin/rsv_pipeline/pangolin/pangolin_src/updates_11_Feb_batman.sh
  - intermediate notes:
  - downstream_analysis_dir  = /cluster/project/pangolin/rsv_pipeline/pangolin/pangolin_src/downstream_analysis
  - this `/cluster/project/pangolin/rsv_pipeline/pangolin/pangolin_src/downstream_analysis` points to /cluster/project/pangolin/rsv_pipeline/rsv_downstream_analysis
- in updates_11_Feb_batman.sh i changed such that the new script (whith the new name) is called and executed
- tried out the new script with: 
  - activating the conda env `update_rsv_downstream`
  - `./updates_11_Feb_batman.sh rsv_vpipe_out_to_tsv`
  - Errors:
    - permission denied due to the `os.chmod(out_vcf, 0o644)`in the `annotate_vcf.py`script
    - TypeError: "quotechar" must be a 1-character string: error probably in the creation of the `class VCFTools(object)`in the function: `write_vcf` ?

Biweekly processing:
- it seems that the sampels already arrived last monday
- tried to run lollipop: error in rule "sigmut"

17 Jan:
- git stash push --include-untracked
- read_and_mark_vcf debugging stopped at this function

16 + 17 Jan:
try to run the influenza downstream analysis batman.sh function on euler
- for this created the respectie environemnt on euler
  - encountered probelms since the environemnt we got is not complete to run the script 
  - had to install: conda install conda-forge::r-remotes, 

15 Jan:
- created pull_downstream_status function in belfry.sh in rsv_downstream analysis to pull the status files from euler to wisedb for the downstream analysis
- added path to putput to rsv_downstream analysis file
- added - pyyaml without specific verison to the rsv downstream.yaml file

I added the logic to rsv_downstream_anaysis that it syncs the status files form euler to wisedb then first checks if the syncing worked and then checks if the downstream analysis worked
for this a added a function to belfry and the added this function to carillon where it is called

- changed back rsv_downstream such that it does not take the output folder as input variable but rather creates the output folder in the same way as for influenza inside the script --> hardcoded but at least unified fashion as influenza....

- also added the syncing of the status files from euler to wisedb for the influenza downstream analysis part
- in rsv_downstream analysis adapted output file name such that it is the same format as in influnza

14 Jan:
- code documentation belfry.sh


13 Jan:
- added augustes rsv_downstream_analysis.yaml environment
- in the timeline.py added an input vairable for inputting the output path where the file timeline should be saved
- added function in carillon.sh to run batman function
- added the following to rsv_downstream_analysis.py
  - input of vpipe base directly
  - input of config file to read from 
  - added configfile to server.conf


- detected logic error in influenza downstream: in carillon.sh we check the wrong files  (detect_AAMutations_fail) instead the fragmant wise files
  - fixed by setting a global status file for the whole process which will return if one of the processes fail 

10 jan:
- cloned rsv_automation branch to /data/projects/rsv_downstream_analysis for rsv downstream analysis implementation
  - created main analysis script as provided by auguste rsv_downstream_analysis.py
  - added .yaml WIP - wait for auguste to send me the yaml format
  - added function to batman.sh rsv_vpipe_out_to_tsv WIP 

- add .gitignore to influenza_automation so that it does not upload the downstream analysis accidentally
  - also added it to influenza_downstream_analysis
  - PROBLEM: could not commit influenza_automation changes! needs checkin with matteo
- to influenza_downstream_automation branch did still some alterations:
  - the path to the yaml file was not defined properly - corrected

9 jan:
- mergend influenza downstream to flu_pranch via pull request
- had update meeting with anika and auguste
- agreed upon to have a static copy of influenza downstream until they publish
- created '/cluster/project/pangolin/influenza_pipeline/influenza_downstream_analysis' to store static copy of current automation branch inside
- linked all the files in every fragment in the downstream_analysis folder to this specific folder
- 

8 jan:
- add a check such that it waits unitl all the vpipes are done before it runs the script 
- question: is it enough to track it as before with only one status file per fragment? couln't these status files interfere with eachother?
- created pull request for influenza_downstream_analysis branch on git 
- added try and catch to the main wastewater_automation (carillon.sh) 
  - reactivated the backups
  - restarted the container

7 jan:
- worked on code documentation: carillon and quasimodo

6 jan:
work on influenza downstream analysis: Observations - to discuss

- pulled the development version from anikas branch and updated gitmodules accordingly
  - problem: in anikas file she calls the vpipe.config and reads the reference form there and then checks which fragment we are working on. Our reference is NC_045512.2.fasta - so no easy extranction of the fragment?
  - adaptation needed also to get samples tsv file. In our config this is a changing value called smples.catchup.tsv --> samples_file = samples.catchup.tsv 
    - this might still wirk?
  - we could extract the batch name directly from the sample.tsv file 
    - this we could do inside the .R script which would be a quick fix 
    - depending on what we also need to change, it might make sense to make it outside of the .R script to have it more reproducible?
- primerProtocol is hard coded in the .R script!
- File output is also hard coded - needs to be adapted to it contains the name of the batch
- in batman.sh i want to implement that the detect_AAMutations.R script runf for every fragment in influenza  
  - if we run vpipe on influenza do we run it on every fragment in parallel - yes
  - after these 4 vpipe runs we need to check if they completed before running detect_AAMutations.R
  - then we get 4 different alignments one per fragment?
  - on these alignmnets now we check for AA changeing muations which is done in the script detect_AAMutations.R
  - thus we need to run the script detect_AAMutations.R on each of the alignemnts to get an output table per fragment and batch --> that would make 4 output files


adding the batch to the output name
take the batch name form the samples.tsv file - first sort then take the latest one

DONE:
- created branch "auotmation" to make changes to the script
- changed that it takes the configs from the yaml file
- changed the output file name
- adapted batman.sh such that it loops though the fragments and runs for each


16 dec:
- made a version of carillon.sh script which has try and catch for remore batman

13 dec:
- created folder on wise bd for Influenza downstream analysis: /data/projects/influenza_downstream_analysis/pangolin/pangolin_src
- made new branch: origin/influenza_downstream_analysis
- added function to batman.sh vpipe_out_to_tsv: which should call Anikas script detect_AAMutations.R
  - added influenza_analysis_R.yml to conda_envs (renamed form the original file in AA_mutationAnalysis_IAV/IAV_analysis.yml)
  - added conda acitavte and deactivate to batman.sh function 
- added new secion in carillon.sh (after vpipe run) for postprocessing (line 350)
- added downstream_analysis_statusdir=${statusdir}/downstream_analysis ### to server.conf
- added error handling


12 dec:
- fgcz docker deployment 
- worked on RSV post processing script - orientation 

06 dec:
- opened bsse IT ticket to mount euler rsv folder to jupyterhub05
- created folder on wisedb pangolin_documentation and cloned vm_ww_viloca_automation branch into it

05 dec:
- in jupyterhub05 created file ww_RSV_postprocessing_to_TSV.ipynb: prepares teh RSV vpipe output for upload to covspect
- started to test the FGCZ sync automation 
