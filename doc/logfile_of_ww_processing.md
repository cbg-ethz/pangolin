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
- TODO: rename batch garbage_scripts to not have covid in name!!

9 April 2026

- mail for fgcz: while in theory the reads should be okay, the savest would be to only use the second sequencing results
- Thus, goal is to revert the merging and rerun the analysis
- plan:
  - stop all container
  - garbage the fused batch 20260320_o41461
  - take out the batches from fuselist and only add the first batch (o41461_Aviti_260320_AV166) to badlist in fgcz.conf (all autoamtions)
  - restart automations and confirm for each that the correct samples are in samples.recent.tsv
  - #TODO: cleanup the aviti_batches.tsv in covid autoamtion

Covid:
- stop the docker container
- added o41461_Aviti_260320_AV166 to bad list in fgcz.conf and removed the fuselist
- `bs-pangolin@eu-login-28:/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src$ ./batman.sh garbage 20260320_o41461`
- `kkirschen@wisedb:nas/kkirschen$ docker start sars_cov_2-sars_cov_2-1`
- confiremed that merged batch and blacklisted batch are not is saples.recent.tsv `bs-pangolin@eu-login-28:/cluster/project/pangolin/processes/sars_cov_2/working$ less samples.recent.tsv`
- run lollipop

influenza:
- IA_MP lofrec on samples B3_17_2026_03_20/20260402_2531558689 and F3_15_2026_03_08/20260320_o41461 take very long, will add them to the fgcz.conf to be excluded (MP is anyway not reproted)
- stoped docker container
- - added the fusebatch to garbage scripts
- `bs-pangolin@eu-login-19:/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src$ ./garbage_multiple_batches_vpipe_output.sh`
- added o41461_Aviti_260320_AV166 to bad list in fgcz.conf and removed the fuselist
- `/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src$ ./garbage_multiple_batches_vpipe_input.sh`
- created scripts to restore the garbaged batches:
  `./restore_vpipe_output_batch_from_garbage.sh`
  `./restore_vpipe_input_batch_from_garbage.sh`
- start the autoamtion

Influenza sinle batch rerun:
---
Error report
-	IA_N1 – failed 
-	Error group extract: D2_16_2026_02_28, H1_25_2026_02_27, A3_17_2026_03_05, F1_17_2026_02_27, C3_25_2026_03_05, C2_16_2026_02_25, D1_10_2026_02_27, H3_16_2026_03_08, C1_10_2026_02_25, F1_17_2026_02_27, E3_15_2026_03_04, E2_05_2026_03_05, H2_10_2026_03_07
-	Due to stale file handle (/cluster/project/pangolin/processes/influenza/IA_N1/vpipe_output/G2_10_2026_03_05/20260325_2531482360/extracted_data/extract_R2.err.log)
-	Error lofreq: B3_17_2026_03_20,
---

- garbaged all samples in IA_N1/vpipe_output from batch 20260325_2531482360 (/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src/20260409_garbage_batches_IA_N1.log)
- next run should rerun N1
- #TODO: if influnza does not restrt in time - manually trun off automation (so it does not accidetally retrgger vpipe), and manually run the N1 - vpipe script
- `kkirschen@wisedb:nas/kkirschen$ docker stop pangolin_iva-pangolin_influenza-1`
- copied smaples.recent.tsv form IA_H1 to IA_N1 to manually start vpipe
- run: `bs-pangolin@eu-login-19:/cluster/project/pangolin/processes/influenza/pangolin/working_vpipe$ sbatch vpipe_influenza_N1_aviti.sbatch` - did not work
- restarted the automation and run this way

rsv:
- stoped docker container
- added the fusebatch to garbage scripts
- `bs-pangolin@eu-login-12:/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src$ ./garbage_multiple_batches_vpipe_output.sh`
- added o41461_Aviti_260320_AV166 to bad list in fgcz.conf and removed the fuselist
- `bs-pangolin@eu-login-05:/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src$ ./garbage_multiple_batches_vpipe_input.sh`
- `kkirschen@wisedb:nas/kkirschen$ docker start pangolin_rsv-pangolin_rsv-1`

General:
- Done: change all garbage scripts to use mv!!!!!
- fgcz_sync automation: removed the fuse batches and added the failed sequencing batch to the badlist
- added batch 20260320_2531490855 to lollipop blacklist

- #TODO:create the restore scrips also for rsv

8 April 2026

general observation: euler is rather slow since at least yesterday
Covid:
- error: /cluster/project/pangolin/processes/sars_cov_2/pangolin/working/.snakemake/log/2026-04-08T084639.883505.snakemake.log
- vpipe_output/B1_05_2026_02_27/20260320_o41461/raw_uploads/raw_reads.err.log --> [mem_sam_pe] paired reads have different names: "AV233803:AV167:2531482360:1:10102:0424:0064", "AV233803:AV166:2531490855:1:10801:0595:0062"
  - usually this is a preprocessing error, this the sample B1_05_2026_02_27 was deleted form output to trigger rerun
  - vpipe_output/A1_05_2026_02_25/20260320_o41461/raw_uploads/raw_reads.err.log as well
- rerun the 2 samples 
  - error again same rule unfiltered_cram: /cluster/project/pangolin/processes/sars_cov_2/working/slurm-COVID-AVITI-vpipe-cons-62693578.err
  - rule log: `/cluster/project/pangolin/processes/sars_cov_2/pangolin/working/cluster_logs/unfiltered_cram/unfiltered_cram-62694452.err.log` --> [mem_sam_pe] paired reads have different names: "AV233803:AV167:2531482360:1:10102:0262:0007", "AV233803:AV166:2531490855:1:10801:0135:0025"
- need to delete the sample in vpipe_input! as the output is only a link to vpipe input and this no recpoying is forced if only the link is deleted!
  - `bs-pangolin@eu-login-30:/cluster/project/pangolin/processes/sars_cov_2/vpipe_output$ rm -rf A1_05_2026_02_25`
  - `bs-pangolin@eu-login-30:/cluster/project/pangolin/processes/sars_cov_2/vpipe_output$ rm -r B1_05_2026_02_27`
  - `bs-pangolin@eu-login-30:/cluster/project/pangolin/processes/sars_cov_2/vpipe_input$ rm -r A1_05_2026_02_25`
  - `bs-pangolin@eu-login-30:/cluster/project/pangolin/processes/sars_cov_2/vpipe_input$ rm -r B1_05_2026_02_27`
  - `kkirschen@wisedb:nas/kkirschen$ docker restart sars_cov_2-sars_cov_2-1`
/cluster/project/pangolin/processes/sars_cov_2/working/slurm-COVID-AVITI-vpipe-cons-62719983.err
```Bash
sacct: error: _open_persist_conn: failed to open persistent connection to host:slurmdbd-slurm-24-production.euler.hpc.ethz.ch:6829: Connection refused
sacct: error: Sending PersistInit msg: Connection refused
sacct: error: Problem talking to the database: Connection refused
sacct: error: _open_persist_conn: failed to open persistent connection to host:slurmdbd-slurm-24-production.euler.hpc.ethz.ch:6829: Connection refused
sacct: error: Sending PersistInit msg: Connection refused
sacct: error: Problem talking to the database: Connection refused
sacct: error: _open_persist_conn: failed to open persistent connection to host:slurmdbd-slurm-24-production.euler.hpc.ethz.ch:6829: Connection refused
sacct: error: Sending PersistInit msg: Connection refused
sacct: error: Problem talking to the database: Connection refused
sacct: error: _open_persist_conn: failed to open persistent connection to host:slurmdbd-slurm-24-production.euler.hpc.ethz.ch:6829: Connection refused
sacct: error: Sending PersistInit msg: Connection refused
sacct: error: Problem talking to the database: Connection refused
sacct: error: _open_persist_conn: failed to open persistent connection to host:slurmdbd-slurm-24-production.euler.hpc.ethz.ch:6829: Connection refused
sacct: error: Sending PersistInit msg: Connection refused
sacct: error: Problem talking to the database: Connection refused
sacct: error: _open_persist_conn: failed to open persistent connection to host:slurmdbd-slurm-24-production.euler.hpc.ethz.ch:6829: Connection refused
sacct: error: Sending PersistInit msg: Connection refused
sacct: error: Problem talking to the database: Connection refused
```
- still error in unfiltered cram: 
  - B1_05_2026_02_27/20260320_o41461: `[mem_sam_pe] paired reads have different names: "AV233803:AV167:2531482360:1:10102:0262:0007", "AV233803:AV166:2531490855:1:10801:0135:0025"` (/cluster/project/pangolin/processes/sars_cov_2/pangolin/working/cluster_logs/unfiltered_cram/unfiltered_cram-62720347.err.log)
  - A1_05_2026_02_25/20260320_o41461: `[mem_sam_pe] paired reads have different names: "AV233803:AV167:2531482360:1:10102:0281:0023", "AV233803:AV166:2531490855:1:10801:0324:0006"`(/cluster/project/pangolin/processes/sars_cov_2/pangolin/working/cluster_logs/unfiltered_cram/unfiltered_cram-62720348.err.log)

Influenza:
- IA_H1 - lofreq (B1_05_2026_02_27): /cluster/project/pangolin/processes/influenza/IA_H1/working/slurm-62688121.out
  - `/cluster/project/pangolin/processes/influenza/IA_H1/working/cluster_logs/lofreq/lofreq-62688203.err.log` --> Processed 599940 reads --> not so much, why does it not run???
- in a previous log file it seems that vpipe started 2x on the same sample --> FATAL(lofreq_filter.c|main_filter:953): Cowardly refusing to overwrite file '/cluster/project/pangolin/processes/influenza/IA_H1/vpipe_output/B1_05_2026_02_27/20260320_o41461/variants/SNVs/snvs.vcf'. Exiting... (`/cluster/project/pangolin/processes/influenza/IA_H1/working/cluster_logs/lofreq/lofreq-62676688.err.log`)
IA_N1:
- stale file handle: (B3_17_2026_03_20) `/cluster/project/pangolin/processes/influenza/IA_N1/working/cluster_logs/lofreq/lofreq-62680116.err.log`
- (B3_17_2026_03_20/20260402_2531558689)
- (F3_15_2026_03_08/20260320_o41461): FATAL(lofreq_indelqual.c|main_indelqual:390): Cowardly refusing to overwrite file '/cluster/project/pangolin/processes/influenza/IA_N1/vpipe_output/F3_15_2026_03_08/20260320_o41461/variants/SNVs/REF_aln_indelqual.bam'. Exiting... --> `/cluster/project/pangolin/processes/influenza/IA_N1/working/cluster_logs/lofreq/lofreq-62688321.err.log`
- `kkirschen@wisedb:nas/kkirschen$ docker stop pangolin_iva-pangolin_influenza-1`
- scancel all inlfuenza jobs
- moved the vpipe.conf file back to the working directory, as this is the fall back file i learned: `/cluster/project/pangolin/processes/influenza/pangolin/working_vpipe/vpipe.config`
- `kkirschen@wisedb:nas/kkirschen$ docker start pangolin_iva-pangolin_influenza-1`

- Influenza Main Job: `/cluster/project/pangolin/processes/influenza/working/slurm-62701154.out`
  ```Bash
  Starting main influenza A Aviti vpipe job with ID 62701154
  Submitted child IA_H1 job with ID 62701227
  Submitted child IA_H3 job with ID 62701229
  Submitted child IA_MP job with ID 62701230
  Submitted child IA_N1 job with ID 62701231
  Submitted child IA_N2 job with ID 62701232
  Waiting for child job 62701227 to finish...
  Child job 62701227 failed with status TIMEOUT
  Waiting for child job 62701229 to finish...
  slurm_load_jobs error: Invalid job id specified
  Child job 62701229 completed successfully
  Waiting for child job 62701230 to finish...
  slurm_load_jobs error: Invalid job id specified
  Child job 62701230 failed with status FAILED
  Waiting for child job 62701231 to finish...
  slurm_load_jobs error: Invalid job id specified
  Child job 62701231 failed with status FAILED
  Waiting for child job 62701232 to finish...
  slurm_load_jobs error: Invalid job id specified
  Child job 62701232 completed successfully
  One or more child jobs failed. Marking parent job as failed.

  ```
- IA_H1: lofreq time limit (/cluster/project/pangolin/processes/influenza/IA_H1/working/slurm-62701227.out)
  - in this log it says canceled due to timelimit, however, if we look at the time it is runtime=4320 --> which is 3 days and the job only ran 3 hours!
  - The key point is:
    runtime=4320 means a time request of 72 hours
    but the cancellation shown is for 62701227, not 62701350
    So this log does not prove that lofreq exceeded its own runtime. It proves that some other submitted cluster job did.
  -----> We have *3 layers of jobs*
  - first layer is the influenza *main* job that spinns
    - the second layer the IA subtype jobs that spinns
      - the third layer, the single rules
  - we only increased the time of the single rules in the config file but not the time of the main jobs, so if they are reaching the time limit the rules are cancelled as well!
- #DONE: Increase the job submission time of the main and the child jobs to 3 days for influenza and rsv (changed the .sbatch files headers)

- commented out the temp_prefix in the segment yaml file to exclude issues with the new temp directory setup..

rsv:
- `/cluster/project/pangolin/processes/rsv/working/slurm-62616659.out` --> slurm_load_partitions: Unable to contact slurm controller (connect failure)
- `kkirschen@wisedb:nas/kkirschen$ docker stop pangolin_rsv-pangolin_rsv-1`
- `bs-pangolin@eu-login-30:/cluster/project/pangolin/processes/rsv/vpipe_input$ ls *20260320_2531490855*` --> batch files are still there
- rename:
  - `garbage_covid_batches.sh`--> `garbage_multiple_batches_vpipe_output.sh`
  - `vpipe_input_garbage_covid_batches.sh`-->`garbage_multiple_batches_vpipe_input.sh`
- in the garbage files above only include the batch 20260320_2531490855 and run (logfile 20260408)
- 
- `kkirschen@wisedb:nas/kkirschen$ docker start pangolin_rsv-pangolin_rsv-1`


- TODO: restart rav automation
  - in the rsv and iva config reactivate the tmp directory ? maybe?
  - restart the influenza docker 


7 April 2026:
- added orders to all fuselists in fgcz.conf file (fgcz sync , rsv, influenza, sars_cov2 autoamtion): `fuselist=o41461_Aviti_260320_AV166,o41461_Aviti_260325_AV167`
Sars_cov2:
- in sars_cov2 on wisedbVM changed: `carillon.sh limit=$(date --date='2 weeks ago' '+%Y%m%d') to limit=$(date --date='4 weeks ago' '+%Y%m%d')` such that the batches are merged
- added the merged batch `20260320_o41461` to `/cluster/project/pangolin/processes/sars_cov_2/working/avi_batches.tsv`
- `bs-pangolin@eu-login-40:/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src$ ./batman.sh garbage 20260325_2531482360`
- `bs-pangolin@eu-login-40:/cluster/project/pangolin/processes/sars_cov_2/pangolin/pangolin_src$ ./batman.sh garbage 20260320_2531490855`
- `kkirschen@wisedb:data/projects$ docker restart sars_cov_2-sars_cov_2-1`
- --> results in rerun

rsv:
- from the batch `o41461_Aviti_260325_AV167` it was still trying to run lofreq for some samples
  - RSVA: `B3_17_2026_03_07/20260325_2531482360` --> (14M reads... way too much to finish lofreq) `Processed 14769174 reads` (`/cluster/project/pangolin/processes/rsv/RSVA/working/cluster_logs/lofreq/lofreq-62402726.err.log`)
  - RSVB: `H2_10_2026_03_07/20260325_2531482360` lofreq did not finish --> 4M reads (`Processed 4227544 reads` `/cluster/project/pangolin/processes/rsv/RSVB/working/cluster_logs/lofreq/lofreq-62565123.err.log`)
    - `B3_17_2026_03_07/20260325_2531482360` - Processed 13722226 reads - `/cluster/project/pangolin/processes/rsv/RSVB/working/cluster_logs/lofreq/lofreq-62565121.err.log`
    - `H2_10_2026_03_07/20260325_2531482360` - Processed 4227544 reads - `/cluster/project/pangolin/processes/rsv/RSVB/working/cluster_logs/lofreq/lofreq-62565123.err.log`
    - `H2_10_2026_03_07/20260325_2531482360` - finished? snvs.vcf file is in folder
  - added sample `B3_17_2026_03_07` to exclude list:`/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src/config/fgcz.conf`

- stoped the automation of wisedb `kkirschen@wisedb:data/projects$ docker stop pangolin_rsv-pangolin_rsv-1` so it does not constantly try to rerun the incomplete sample
- scanceled the running rsv jobs on euler 
- garbage batches:
  - edited script `/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src/garbage_covid_batches.sh` to add the batches to garbage for both variants
  - `bs-pangolin@eu-login-36:/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src$ ./garbage_covid_batches.sh`
  - edited script: `/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src/vpipe_input_garbage_covid_batches.sh` to include the batches
  - `bs-pangolin@eu-login-36:/cluster/project/pangolin/processes/rsv/pangolin/pangolin_src$ ./vpipe_input_garbage_covid_batches.sh`
    - error in script as the mutation tables were not yet created and thus were not found to be deleted - acceptable error - proceeding
  - restart autoamtion on wise db vm
    - in container on wisedbVM changed: `carillon.sh limit=$(date --date='2 weeks ago' '+%Y%m%d') to limit=$(date --date='4 weeks ago' '+%Y%m%d')` such that the batches are merged
- failed; why?
  - in /cluster/project/pangolin/processes/rsv/working/samples.recent.tsv the two other batches are still added! why?
  - garbage input dir did not move the samples.BATCH.tsv file form the input directory, and vpipe will run on these files.
  - added section into: `garbage_vpipe_input.sh`:
```Bash
# Move batch metadata files into garbage so addsamples cannot recreate them
for meta_file in \
  "${vpipe_input_dir}/batch.${batch}.yaml" \
  "${vpipe_input_dir}/samples.${batch}.tsv" \
  "${vpipe_input_dir}/missing.${batch}.txt" \
  "${vpipe_input_dir}/projects.${batch}.tsv"
do
  if [[ -e "${meta_file}" ]]; then
    mv "${meta_file}" "${garbage_dir}/"
    echo "Moved metadata file to garbage: ${meta_file}"
  else
    echo "Metadata file not found, skipping: ${meta_file}"
  fi
done

```

influenza:
- from the batch `o41461_Aviti_260325_AV167` it was still trying to run lofreq for some samples
  - `B1_05_2026_02_27/20260325_2531482360` Stale file handle - Processed 592136 reads - `/cluster/project/pangolin/processes/influenza/IA_H1/working/cluster_logs/lofreq/lofreq-62573875.err.log`
  - `B1_05_2026_02_27/20260325_2531482360` --> it seems that the autoamtion tries to run the sample 2x in a row and thus fails, this should be sorted out once the batch is deleted and rerun with the combined sequences
- stopped the automation on wisedb: `kkirschen@wisedb:data/projects$ docker stop pangolin_iva-pangolin_influenza-1`
- scanceled the running influenza jobs on euler 
- garbage batches:
  - added similar script as above to influenza:
  - `/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src/garbage_multiple_batches_vpipe_input.sh`
  - `/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src/garbage_multiple_batches_vpipe_output.sh`
  - run:
    - `bs-pangolin@eu-login-40:/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src$ ./garbage_multiple_batches_vpipe_output.sh`
    - `bs-pangolin@eu-login-36:/cluster/project/pangolin/processes/influenza/pangolin/pangolin_src$ ./garbage_multiple_batches_vpipe_input.sh`
    - connection interrupted, needed to restart both scripts
  - added section into: `garbage_vpipe_input.sh`
  
```Bash
# Move batch metadata files into garbage so addsamples cannot recreate them
for meta_file in \
  "${vpipe_input_dir}/batch.${batch}.yaml" \
  "${vpipe_input_dir}/samples.${batch}.tsv" \
  "${vpipe_input_dir}/missing.${batch}.txt" \
  "${vpipe_input_dir}/projects.${batch}.tsv"
do
  if [[ -e "${meta_file}" ]]; then
    mv "${meta_file}" "${garbage_dir}/"
    echo "Moved metadata file to garbage: ${meta_file}"
  else
    echo "Metadata file not found, skipping: ${meta_file}"
  fi
done
```

- rerun `./garbage_multiple_batches_vpipe_input.sh`
- only added batch 20260320_2531490855 and rerun the script
- on wisedb VM restarted the influenza automation and changed `carillon.sh limit=$(date --date='2 weeks ago' '+%Y%m%d') to limit=$(date --date='4 weeks ago' '+%Y%m%d')` such that the batches are merged and processed


Done: rename rsv batch garbage_scripts to not have covid in name!!!
Done:
- for rsv the batch 20260320_2531490855 was reprocessed becasue in the input garbaging script in only ran the first batch!
  - needs to be deleted and downstream analysis rerun for rsv:
  - run both garbaging scripts with only batch 20260320_2531490855



2 April 2026

- (linked rsync.conf file to the version stored on git)
```Bash
#commands in homedirectory bs-pangolin
rm rsyncd.conf # menoved old link: rsyncd.conf -> /cluster/home/bs-pangolin/rsyncd.conf_new
ln -s /cluster/project/pangolin/processes/fgcz_sync/pangolin/fgcz_sync/config/rsyncd.conf rsyncd.conf
```

- updated the `sars-cov` rsync case to use the git-managed config file directly with
  `--config "${clusterdir_old}/${clusterdir}/${sourcefiles_location}/config/rsyncd.conf"`
- this means the rsync daemon no longer depends on `~/rsyncd.conf` or the default `/etc/rsyncd.conf`
- added notes to the backup documentation describing how the FGCZ raw-data rsync backup works and where the config is loaded from

30 March 2026 

**SPSP upload issue:**
- changed settings in server.conf (covid autoamtion): donotsubmit_uploader=0
- in belfry changed the path on line 386 from` belfry@euler.ethz.ch::${working}/samples` to `belfry@euler.ethz.ch::${working}` 
- changed the same inside the container !
- Then the issue occured that file mermissions on raw_data on the wisedb are not the one form the container
- Tried changeing the ownership but were not able to
- contacted system admin to look into it

Log of changing folder ownership:
- change raw_data/working/samples directory ownership on wisedb so it is writable for the spsp uploads:
```Bash
ssh wisedb
cd /raw_data/working
# first test
find samples -user mcarrara 
find samples -user mcarrara | wc -l
> 1246

#now change ownership:
cd #got to home
sudo find /raw_data/working/samples -user mcarrara -exec chown kkirschen {} +
cd /raw_data/working/samples
sudo find . -user mcarrara -exec chown kkirschen {} +

``` 

`sudo`: runs the command with elevated privileges, so ownership changes are allowed
`find .` :starts searching in the current directory . and all subdirectories
`-user mcarrara`: matches only entries owned by the user mcarrara

`-exec chown kkirschen {} +`
for all matched entries, run:
`chown kkirschen <matched files...>`

Here:
`{}` is replaced by the matched paths
`+` means find passes many files at once to chown, which is faster than one-by-one


Alternative:

  change owner and group:
  `chown -R user:group directory`

  Only Change owner:
  `chown -R alice myfolder`
  `chgrp -R group directory`

```Bash
kkirschen@wisedb:raw_data/working$ sudo chown kkirschen samples
[sudo] password for kkirschen:
chown: cannot access 'samples': Permission denied

```




23 March 2026:

- note form fgcz about sequencing troubles in order 41461

16 March 2026:

- Performed regular processing tasks.
- Discussed how to proceed with samples showing unexpectedly increased read depth, and considered alternatives to excluding them from the analysis.
- Tested dynamic resources in the profile. Conclusion: this is not supported in Snakemake 7.32.4.
- Increased LoFreq resources to allow runs of up to 3 days and 32 GB RAM.
- #TODO: This should remain an intermediate solution only and be reduced again after this season.
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
