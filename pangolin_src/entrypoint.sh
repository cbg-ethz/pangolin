#!/usr/bin/env bash

echo "Setting up SendCrypt CLI"
cp /app/resources/default.sendcrypt-profile ~/.sendcrypt/profiles
keyfile=$(ls /run/secrets/ABC9FC14AAC952E7767FD14A48B70E724BAFE0A3.asc)
gpg --import secrets $keyfile
key=${keyfile%".asc"}
key=${key##*/}
## trust level with import-ownertrust is the desired trust level +1
echo "${key}:6:" | gpg --import-ownertrust

export keyfile=$(ls /run/secrets/494B38B5ACAC90BD1580CC19BE3D145420D2F095.gpg)
key=${keyfile%".gpg"}
export key=${key##*/}
export passphrase=$(cat /run/secrets/bs-pangolin_gpg_private_key_password)

/usr/bin/expect << 'EOF'
  spawn gpg --import-options restore --import $::env(keyfile)
  expect "Passphrase:"
  send "$::(passphrase)\r"
  exit
EOF

/usr/bin/expect << 'EOF'
  spawn gpg --edit-key $::env(key)
  send "trust\r"
  expect "Please decide how far you trust this user"
  send "5\r"
  expect "Do you really want to set this key to ultimate trust"
  send "y\r"
  exit
EOF

#######
echo "Setting up the credentials"
cp /run/secrets/bs-pangolin_login ${HOME}/.ssh/bs-pangolin@euler.ethz.ch
cp /run/secrets/fgcz_login ~/.ssh/fgcz-gstore.uzh.ch
cp /run/secrets/id_ed25519_wisedb /app/resources/config /app/resources/known_hosts /app/resources/id_ed25519_wisedb.pub /run/secrets/rsync.pass.euler ~/.ssh

sleep 10d