#!/bin/bash
set -x -e
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
