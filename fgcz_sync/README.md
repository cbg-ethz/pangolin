1. Created new folder to store all the files important for the fgcz data sync
2. alternative function ring_fgcz_sync in quasimodo.sh (calls fgcz_sync.sh instread of calling the whole carillon.sh)
3. added fgcz_sync.sh script which containst the first part of the old carillon.sh (only the data sync part)
    - adapted the scriptdir
4. batman.sh sync_fgcz - added comments
5. set bfabricdir=${download} (defined in fgcz.conf) download dir is the bfabric-download directory outside of the automation repo to have it separate 
6. changed path in server.conf to new euler folder


7. added entrypoint.sh 
8. deleted cowabunga.sh
9. deleted ring_carillon and exchanged the call to ring_fgcz_sync in quasimodo.sh
10. cloned repo to euler /cluster/project/pangolin/fgcz_sync_automation with https
11. changed name of docker container in the docker-compose



In Docker file:
- i now defined that the folder where everything is stores should be called 'fgcz_sync' instrad of pangolin_src --> make sure that it is correctly changed everywhere necessary
- in batman.sh sync_fgcz there are many dependencies: can i leave the scriptdir as is since it it on euler?
- in belfry.sh there are 4x /app/pangolin_src in the functons: callpushrsync, callpullrsync_fordb, callpullrsync_viloca and callpullrsync_rsync
    - do we still need these functions?
    - 

left todo:
- clone to euler
- adapt the virus automations to get the data from the right place?
    - we already get them form the rigth place
    - there is a variable to skip the sync in server.conf, just set this to fgcz

- in the Dockerfile define that the files form the folder we are currently in  is coppied to the image e.g.
COPY --chown=bs-pangolin:bs-pangolin . /app/pangolin_src

        - in entrypoint change path
        - some secrets in the directory need to be updated

Question:
- where to find ${remote_backup} pull_fgcz_data (fgcz_sync.sh)





