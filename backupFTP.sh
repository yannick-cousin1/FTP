#!/bin/bash

mkdir -p ~/Backup/
mkdir -p ~/Backup/conf
mkdir -p ~/Backup/data

cp /etc/proftpd/proftpd.conf ~/Backup/conf/
cp /etc/proftpd/tls.conf ~/Backup/conf/
cp /etc/proftpd/modules.conf ~/Backup/conf/

cp -r /home/ ~/Backup/data/

d=$(date +"%e-%m-%Y-%H-%M")
comparchive="backup-$d.tar.gz"
tar -zcf ~/Backup/$comparchive ~/Backup/conf/ ~/Backup/data


