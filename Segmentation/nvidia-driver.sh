BASE_URL=https://us.download.nvidia.com/tesla
DRIVER_VERSION=470.129.06
curl -fSsl -O $BASE_URL/$DRIVER_VERSION/NVIDIA-Linux-x86_64-$DRIVER_VERSION.run
sudo sh NVIDIA-Linux-x86_64-$DRIVER_VERSION.run
