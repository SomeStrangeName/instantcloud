#!/bin/bash
set -x -e
sudo apt-get update
sudo apt-get install -y apt-transport-https dirmngr
# add docker repos
sudo touch /etc/apt/sources.list.d/docker.list 
sudo echo 'deb https://apt.dockerproject.org/repo debian-stretch main' >> /etc/apt/sources.list.d/docker.list
# set source list to Debian default values (no https is used!)
sudo echo 'deb http://ftp.de.debian.org/debian/ stretch main non-free contrib' > /etc/apt/sources.list
sudo echo 'deb-src http://ftp.de.debian.org/debian/ stretch main non-free contrib' >> /etc/apt/sources.list
sudo echo 'deb http://security.debian.org/ stretch/updates main contrib non-free' >> /etc/apt/sources.list
sudo echo 'deb-src http://security.debian.org/ stretch/updates main contrib non-free' >> /etc/apt/sources.list
sudo echo 'deb http://ftp.de.debian.org/debian/ stretch-updates main contrib non-free' >> /etc/apt/sources.list
sudo echo 'deb-src http://ftp.de.debian.org/debian/ stretch-updates main contrib non-free' >> /etc/apt/sources.list
# to load keys
# load docker key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# update to have docker pages in
sudo apt-get update
# ensure latest packages
sudo apt-get dist-upgrade -y
sudo apt-get install -y curl default-mysql-client vim git docker-engine docker-compose

sudo usermod -aG docker vagrant
sudo mkdir -p /data/nextcloud
sudo chown root.www-data /data/nextcloud
sudo chmod ug+rwx /data/nextcloud

mycnf=~/.my.cnf
dbuser="root"
dbpw=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c64 ; echo ''`
echo $dbpw
touch $mycnf
echo '[mysqldump]' > $mycnf
echo "user=${dbuser}" >> $mycnf
echo "password=${dbpw}" >> $mycnf

# should be replaced with a docker compose file
sudo mkdir -p /data/mysql
sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=${dbpw} -v /data/mysql:/var/lib/mysql -p 3306:3306 -d mariadb:latest
sudo docker run --name nextcloud --link mysql:mysql -v /data/nextcloud:/var/www/html -p 8080:80 -d nextcloud:latest
