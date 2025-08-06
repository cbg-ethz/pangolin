# Automation backups

This directory contains all the necessary code to run trigger the data backup to the Spectrum Scale Storage. This specific instance handles only the RSV surveillance WISE project.

## Structure

- The automation runs on `wisedb.nexus.ethz.ch`
- Separate, configurable triggers are available to start the backup of
  - raw data
  - vpipe results
  - viloca results
  - uploader logs
  - amplicon coverage results
- The backups are performed using parallelized rsync for large amounts of data (raw, vpipe, viloca) and single-threaded rsync for the rest
- the backup procedure is triggered from wisedb to bs-bewi08 using forced commands. The forced command then triggers rsync to copy data from Euler to bs-bewi08
