#!/bin/bash

yes | apt update
yes | apt upgrade

echo -e "kalimac\nkalimac\nmerry\n\n\n\n\n" | adduser --home /home/merry --shell /bin/false merry
echo -e "secondbreakfast\nsecondbreakfast\npippin\n\n\n\n\n" | adduser --home /home/pippin --shell /bin/false pippin

yes | apt install proftpd-*
rm -f /etc/proftpd/tls.conf
rm -f /etc/proftpd/modules.conf
rm -f /etc/proftpd/proftpd.conf

cp proftpd.conf /etc/proftpd/
cp modules.conf tls.conf /etc/proftpd/

mkdir -p /etc/proftpd/ssl

echo -e "FR\nFrance\nMarseille\nLaPlateforme\nStart\nYann\nyannick.cousinatlaplateforme.io\n" | openssl req -x509 -newkey rsa:1024 -keyout /etc/proftpd/ssl/proftpd.key.pem -out /etc/proftpd/ssl/proftpd.cert.pem -nodes -days 365

systemctl restart proftpd

