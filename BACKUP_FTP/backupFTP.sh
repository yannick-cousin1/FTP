#!/bin/bash

#install CLI FTP client that support FTP over TLS/SSL
yes | apt install lftp

#Create directories to put files to save
mkdir -p ~/Backup/
mkdir -p ~/conf
mkdir -p ~/data

#Copy files to save in thoses dirs
cp /etc/proftpd/proftpd.conf ~/conf/
cp /etc/proftpd/tls.conf ~/conf/
cp /etc/proftpd/modules.conf ~/conf/
cp -r /home/ ~/data/

#put the date with hour and minutes in a variable
d=$(date +"%e-%m-%Y-%H-%M")
#erase spaces
d=${d// /}

#name of the compressed archive in a variable
comparchive="backup-$d.tar.gz"

#archive and compress 
tar -zcf ~/Backup/$comparchive ~/conf/ ~/data

#send the compressed archive with lftp. IP adress and users/password must be set according to the server you want to use to store your backups
echo -e "set ssl:verify-certificate no\nput ~/Backup/$comparchive" | lftp merry:kalimac@10.10.39.137




