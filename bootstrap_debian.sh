#!/bin/bash
echo "> Updating repository"
sudo apt-get update
echo "> Upgrading installed packages"
sudo apt-get -y dist-upgrade
echo "> Installing vim - I like it :)"
sudo apt-get -y install vim
echo "> Installing a mysql client"
sudo apt-get -y install default-mysql-client
echo "> Installing docker according to: https://docs.docker.com/engine/installation/linux/docker-ce/debian/"
echo "> Removing older docker versions if available"
sudo apt-get remove docker docker-engine docker.io
echo "> Installing packages to allow apt to use a repository over HTTPS:"
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
echo "> Add Docker’s official GPG key:"
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
echo "> Adding docker repository"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
echo "> Updating apt-get"
sudo apt-get update
sudo apt-get -y install docker-ce 
echo "> Cleaning up"
sudo apt-get clean
echo "> Testing docker"
sudo docker run hello-world
echo "> Installing docker compose 1.17.1 according to: https://docs.docker.com/compose/install/#install-compose"
sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
echo "> Apply executable permissions to the binary" 
sudo chmod +x /usr/local/bin/docker-compose
echo "> Test docker compose installation"
docker-compose --version

