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

# setup cuda stuff and install keras_cv
# https://github.com/huggingface/community-events/pull/132
conda create -n kerascv python=3.10 -y
conda activate kerascv
conda install nb_conda_kernels -y
ipython kernel install --user --name=kerascv
conda install -c conda-forge cudatoolkit=11.8.0 -y
python3 -m pip install nvidia-cudnn-cu11==8.6.0.163

echo "export XLA_FLAGS=--xla_gpu_cuda_data_dir=/usr/lib/cuda" >> ~/.bashrc
CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib" >> ~/.bashrc
source ~/.bashrc

conda activate kerascv
python -m pip install tensorflow==2.12.*
pip install keras_cv===0.4.2 tensorflow_datasets===4.8.1 pillow===9.4.0 imutils opencv-python matplotlib huggingface-hub pycocotools

# check, should be printing at least one gpu device
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU')); print(tf.__version__)"
