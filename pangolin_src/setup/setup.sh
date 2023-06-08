#!/usr/bin/env bash

set -eu

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ${SCRIPT_DIR}

if ! test -d ../miniconda3; then
    URL="https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh"
    SCRIPT=$(basename $URL)
    test -f ${SCRIPT} || wget $URL
    bash ${SCRIPT} -b -p ../miniconda3
fi


# activate conda from .bashrc

# >>> conda initialize >>>
export PATH="$HOME/pangolin/miniconda3/bin:$PATH"
echo $PATH
# <<< conda initialize <<<



conda config --set proxy_servers.http http://proxy.ethz.ch:3128
conda config --set proxy_servers.https http://proxy.ethz.ch:3128

conda install --yes -c conda-forge mamba
$HOME/pangolin/miniconda3/bin/pip config set global.proxy http://proxy.ethz.ch:3128 || { echo $PATH; which conda; ls -al $HOME/pangolin/miniconda3/bin; exit 1; }

for ENV in conda*.yaml; do
	echo create env for $ENV
	mamba env create -f $ENV
	echo
done
