echo \"**** syncing venv to workspace, please wait. This could take a while on first startup! ****\"
ln -s /runpod-volume/svd /workspace/svd
cd /workspace/svd
source /workspace/svd/venv/bin/activate

# Default env vars
export MODEL_MOUNTPOINT=/workspace
export PORT=3000

# Update, upgrade, install packages and clean up
apt-get update --yes
apt-get upgrade --yes
apt install --yes --no-install-recommends git git-lfs wget curl bash libgl1 software-properties-common openssh-server ffmpeg
add-apt-repository ppa:deadsnakes/ppa
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
export PYTHONPATH="/runpod-volume/svd/generative-models"

if [[ $RUNPOD_STOP_AUTO ]]
then
  echo \"Skipping auto-start of webui\"
else  echo \"Started webui through relauncher script\"
  cd /runpod-volume
  git clone https://github.com/thander/img2video temp
  mv temp/.git img2video/.git
  rm -rf temp
  cd img2video
  nohup python -u lucky_handler.py &
fi