#!/bin/bash

yes | apt install lftp


mkdir -p ~/Backup/
mkdir -p ~/conf
mkdir -p ~/data

cp /etc/proftpd/proftpd.conf ~/conf/
cp /etc/proftpd/tls.conf ~/conf/
cp /etc/proftpd/modules.conf ~/conf/

cp -r /home/ ~/data/

d=$(date +"%e-%m-%Y-%H-%M")
d=${d// /}
comparchive="backup-$d.tar.gz"
tar -zcf ~/Backup/$comparchive ~/conf/ ~/data


echo -e "set ssl:verify-certificate no\nput ~/Backup/$comparchive" | lftp merry:kalimac@10.10.39.137




