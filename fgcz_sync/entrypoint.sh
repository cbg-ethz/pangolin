#!/usr/bin/env bash

#######
echo "Setting up the credentials"
cp /run/secrets/bs-pangolin_login_euler /home/bs-pangolin/.ssh/bs-pangolin@euler.ethz.ch
cp /run/secrets/bs-pangolin_login_backups /home/bs-pangolin/.ssh/bs-pangolin@d@bs-bewi08
cp /run/secrets/fgcz_login ~/.ssh/fgcz-gstore.uzh.ch
cp /run/secrets/id_ed25519_fgcz_sync /run/secrets/id_ed25519_wisedb /app/resources/config /app/resources/id_ed25519_fgcz_sync.pub /app/resources/id_ed255119_wised.pub /run/secrets/rsync.pass.euler ~/.ssh
chmod 600 ~/.ssh/id_ed25519_fgcz_sync 
ssh-keyscan bs-bewi08.ethz.ch >> ~/.ssh/known_hosts
ssh-keyscan fgcz-gstore.uzh.ch >> ~/.ssh/known_hosts
ssh-keyscan euler.ethz.ch >> ~/.ssh/known_hosts

/app/fgcz_sync/quasimodo.sh
#sleep 10d
