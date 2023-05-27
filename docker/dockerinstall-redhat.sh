#!/bin/bash

echo "please execute the script under sudo privilege"
sudo echo "sudo privilege verified, continue..."


# the following just integrate all scripts on page
# https://docs.docker.com/engine/install/centos/

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl start docker

sudo docker run hello-world

