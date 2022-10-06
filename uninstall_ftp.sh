#!/bin/bash

#Stop proftpd daemon
systemctl stop proftpd

#delete users and ftpgroup
deluser --remove-home --remove-all-files merry
deluser --remove-home --remove-all-files pippin
delgroup ftpgroup

#uninstall proftpd and conf files
apt remove --purge --autoremove proftpd-*

#clean cache
apt clean




