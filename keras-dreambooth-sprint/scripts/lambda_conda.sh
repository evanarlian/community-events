#!/usr/bin/env bash

# install and setup miniconda non-interactively
# https://docs.anaconda.com/anaconda/install/silent-mode/
wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
eval "$(/home/ubuntu/miniconda3/bin/conda shell.bash hook)"
conda init
conda config --set auto_activate_base false
source ~/.bashrc
