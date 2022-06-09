# Overview
Once you have an EC2 instance running, follow these steps to make sure it is configured correctly and ready to run code.

---

## SSH-ing
To SSH into the instance, use this command: `ssh -i id.cer ec2-user@instance_ip_address`. The file `id.cer` should be the file downloaded on creating the key pair when launching the instance. It may also be a `.pem` file depending on what you chose.

## GPU Driver
```sh
nvidia-smi
```
You can test that the GPU driver has loaded correctly with the line above. 

If you get an error, install new drivers with the commands below. This may depend on the GPU you are using. For example, the p2.xlarge instances use the Telsa K80 which requires downgrading to version `470.129.06`. You can find other GPU drivers here: https://www.nvidia.com/Download/index.aspx?lang=en-us
```sh
BASE_URL=https://us.download.nvidia.com/tesla
DRIVER_VERSION=470.129.06
curl -fSsl -O $BASE_URL/$DRIVER_VERSION/NVIDIA-Linux-x86_64-$DRIVER_VERSION.run
sudo sh NVIDIA-Linux-x86_64-$DRIVER_VERSION.run
```

## Installing Conda
Some images do not come preconfigured with conda installed. To do this, run these commands:
```sh
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
rm Miniconda3-latest-Linux-x86_64.sh
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
```

You will need to exit and ssh back into the server to enable conda.

## Downgrading to specific CUDA Toolkit versions
One reason we install conda is that you can install specific CUDA Toolkit versions through it. If performing segmentation with the keras-segmentation library, it is possible to run into errors unless you run the line below ([See this GitHub issue](https://github.com/tensorflow/tensorflow/issues/44777#issuecomment-1015130779)).
```sh
conda install cudatoolkit=11.0.221 cudnn=8.0.4 -c nvidia -y
```

## Configuring Jupyter
To configure the Jupyter SSL certificates, run these lines:
```sh
mkdir ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/mykey.key -out ssl/mycert.pem
```

Then set the workspace password.
```sh
jupyter notebook password
```

You should now be able to launch the Jupyter server and reach it at https://instance_ip_address:8888. **NOTE:** Chrome may reject the SSL certificate. You can type `thisisunsafe` to continue anyway.

```sh
jupyter lab --port=8888 --ip=0.0.0.0 --no-browser --certfile=~/ssl/mycert.pem --keyfile=~/ssl/mykey.key
```

## Creating environment for segmentation
The keras-segmentation library is pretty picky about its dependecies versions. Create a new environment for this with these commands:
```sh
conda create -n seg-model-env python=3.7 tensorflow-gpu=2.4.1 keras=2.4.3 -y

# install libraries into seg-model-env
pip install --upgrade git+https://github.com/divamgupta/image-segmentation-keras protobuf==3.20.1 -y
```
