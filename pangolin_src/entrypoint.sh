#!/usr/bin/env bash

#######
echo "Setting up the credentials"
cp /run/secrets/bs-pangolin_login_euler /home/bs-pangolin/.ssh/bs-pangolin@euler.ethz.ch
cp /run/secrets/bs-pangolin_login_backups /home/bs-pangolin/.ssh/bs-pangolin@d@bs-bewi08
cp /run/secrets/fgcz_login ~/.ssh/fgcz-gstore.uzh.ch
cp /run/secrets/id_ed25519_wisedb /run/secrets/id_ed25519_wisedb_backups /app/resources/config /app/resources/known_hosts /app/resources/id_ed25519_wisedb.pub /app/resources/id_ed25519_wisedb_backups.pub /run/secrets/rsync.pass.euler /app/resources/id_ed25519_spsp_uploads.pub ~/.ssh
cp /run/secrets/sendcrypt_profile /home/bs-pangolin/.sendcrypt/profiles/default.env
cp /run/secrets/spsp_uploads_ssh_private_key /home/bs-pangolin/.ssh/id_ed25519_spsp_uploads

echo "Setting up the GPG keys for the SPSP uploads"
cp /run/secrets/spsp_gpg_key /home/bs-pangolin/.ssh/spsp_gpg_key
cp /run/secrets/bs_pangolin_gpg_key /home/bs-pangolin/.ssh/bs_pangolin_gpg_key
cp /run/secrets/bs_pangolin_gpg_key_password /home/bs-pangolin/.ssh/bs_pangolin_gpg_key_password
gpg --import /home/bs-pangolin/.ssh/spsp_gpg_key 
echo "ABC9FC14AAC952E7767FD14A48B70E724BAFE0A3:6:" | gpg --import-ownertrust

cat /home/bs-pangolin/.ssh/bs_pangolin_gpg_key_password | gpg --batch --yes --passphrase-fd 0  --import /home/bs-pangolin/.ssh/bs_pangolin_gpg_key
echo "B2E046C543F6FDD84C4A5A307ABF7E3B5AAAE4A6:6:" | gpg --import-ownertrust
/app/pangolin_src/quasimodo.sh
#sleep 10d
