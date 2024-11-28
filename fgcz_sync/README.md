1. Created new folder to store all the files important for the fgcz data sync
2. alternative function ring_fgcz_sync in quasimodo.sh (calls fgcz_sync.sh instread of calling the whole carillon.sh)
3. added fgcz_sync.sh script which containst the first part of the old carillon.sh (only the data sync part)
    - adapted the scriptdir
4. batman.sh sync_fgcz - added comments
5. set bfabricdir=${download} (defined in fgcz.conf) download dir is the bfabric-download directory outside of the automation repo to have it separate
6. changed path in server.conf to new euler folder

Euler:
- created folder /cluster/project/pangolin/fgcz_sync_automation
tried to pull git repo to euler (bs-pangolin) - did not work