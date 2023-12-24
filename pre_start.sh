#!/bin/bash

# Default env vars
export MODEL_MOUNTPOINT=/workspace
export PORT=3000

# Update, upgrade, install packages and clean up
apt-get update --yes && \
apt-get upgrade --yes && \
apt install --yes --no-install-recommends git git-lfs wget curl bash libgl1 software-properties-common openssh-server ffmpeg && \
add-apt-repository ppa:deadsnakes/ppa && \
apt install "python3.10-dev" -y --no-install-recommends && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

# Set up Python and pip
ln -s /usr/bin/python3.10 /usr/bin/python && \
rm /usr/bin/python3 && \
ln -s /usr/bin/python3.10 /usr/bin/python3 && \
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
python get-pip.py

pip install --upgrade --no-cache-dir pip

mkdir -p /usr/share/svd

cd /usr/share/svd

git clone https://github.com/Stability-AI/generative-models.git

cd /usr/share/svd/generative-models

pip install --upgrade --no-cache-dir -r requirements/pt2.txt && \ 
pip install --upgrade --no-cache-dir . && \
pip install --upgrade --no-cache-dir streamlit

export PYTHONPATH="//svd/generative-models"

git lfs install

export PORT=3000

mkdir checkpoints

cp /start.sh /start.sh

/start.sh