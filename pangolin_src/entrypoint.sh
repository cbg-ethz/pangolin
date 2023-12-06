#!/usr/bin/env bash

#######
echo "Setting up the credentials"
cp /run/secrets/bs-pangolin_login ${HOME}/.ssh/bs-pangolin@euler.ethz.ch
cp /run/secrets/fgcz_login ~/.ssh/fgcz-gstore.uzh.ch
cp /run/secrets/id_ed25519_wisedb /app/resources/config /app/resources/known_hosts /app/resources/id_ed25519_wisedb.pub /run/secrets/rsync.pass.euler ~/.ssh

#/app/pangolin_src/quasimodo.sh
sleep 10d
