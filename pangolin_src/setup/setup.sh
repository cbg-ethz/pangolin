#!/usr/bin/env bash

set -eu

if ! test -d /app/miniconda3; then
    URL="https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh"
    SCRIPT=$(basename $URL)
    test -f ${SCRIPT} || wget $URL
    bash ${SCRIPT} -b -p /app/miniconda3
fi


# activate conda from .bashrc
# >>> conda initialize >>>
export PATH="/app/miniconda3/bin:$PATH"
echo $PATH
# <<< conda initialize <<<
conda init

conda install --yes -c conda-forge mamba

for ENV in /app/setup/conda*.yaml; do
	echo create env for $ENV
	mamba env create -f $ENV
	echo
done



echo Installing and setting up SendCryptCli for submission to SPSP
bash -c "$(wget -qO- https://gitlab.sib.swiss/clinbio/sendcrypt/sendcrypt-cli/-/raw/main/tools/install.sh)"
echo -e 'export PATH="$HOME/.sendcrypt:$PATH"' >> ~/.bashrc
source ~/.bashrc


