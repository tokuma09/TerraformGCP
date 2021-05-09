#! /bin/bash

# この辺になにかバグがありそう
sudo apt update

sudo apt install -y \
apt-transport-https \
ca-certificates \
curl \
software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y docker-ce

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl restart docker

sudo groupadd docker
sudo usermod -aG docker $USER
sudo newgrp docker


sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir ~/key
echo $(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/GOOGLE_APPLICATION_CREDENTIALS" -H "Metadata-Flavor: Google") > ~/key/gcp_key.json

echo "export GOOGLE_APPLICATION_CREDENTIALS=~/key/gcp_key.json" >> ~/.bashrc


echo "export NEPTUNE_API_TOKEN=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/NEPTUNE_API_TOKEN" -H "Metadata-Flavor: Google")" >> ~/.bashrc

echo "export GITHUB_PAT=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/GITHUB_PAT" -H "Metadata-Flavor: Google")" >> ~/.bashrc


source ~/.bashrc
