#!/bin/bash

#Launch apt update and apt upgrade and enter "Yes" when prompt
yes | apt update
yes | apt upgrade

#Write "/bin/false" in the shell file (this way, /bin/false is recognized as a valid shell
echo "/bin/false" >> /etc/shells

#create ftpgroup and users merry and pippin (with home and deactivated shell (/bin/false)
addgroup ftpgroup
echo -e "kalimac\nkalimac\nmerry\n\n\n\n\n" | adduser --home /home/merry --shell /bin/false merry
echo -e "secondbreakfast\nsecondbreakfast\npippin\n\n\n\n\n" | adduser --home /home/pippin --shell /bin/false pippin

#Add merry and pippin to ftpgroup
adduser merry ftpgroup
adduser pippin ftpgroup

#install proftpd and its mods ( including the one handling TLS )
yes | apt install proftpd-*

# remove original config files of proftpd
rm -f /etc/proftpd/tls.conf
rm -f /etc/proftpd/modules.conf
rm -f /etc/proftpd/proftpd.conf

# Copy prepared config files to the right directories
cp proftpd.conf /etc/proftpd/
cp modules.conf tls.conf /etc/proftpd/

#Create ssl directory in /etc/proftpd . This dir will contain TLS Key and Certificate
mkdir -p /etc/proftpd/ssl

#Create TLS Key and Certificate in right directories
echo -e "FR\nFrance\nMarseille\nLaPlateforme\nStart\nYann\nyannick.cousinatlaplateforme.io\n" | openssl req -new -x509 -keyout /etc/proftpd/ssl/proftpd.key.pem -days 365 -nodes -out /etc/proftpd/ssl/proftpd.cert.pem

#restart server
systemctl restart proftpd

