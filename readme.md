

FTP JOBS :

Directories :

JOB 7 : 7INSTALL_FTP 
JOB 8 : 8UNINSTALL_FTP
JOB 9 : 9ADDUSER_CSV
POUR ALLER PLUS LOIN : BACKUP_FTP

Le script adduser_csv.sh (Job9) utilisant les id contenu dans Shell_Userlist.csv
et le script install_ftp.sh (Job7) créant les users merry et pippin (id 1001 et 1002)
les 2 premiers users du fichier csv ne seront pas créés si le script adduser_csv.sh
est lancé après le script install_ftp.sh.


Pour le Job 9, l'adresse du serveur sur lequel sera envoyé les backup correspond à une VM
créée pour l'occasion. Ainsi, il faut adapter cette adresse si l'IP a changé.
Dans un cas réel, il serait préférable que le serveur de backup ait une IP Fixe,
et même un user "Backup" ne servant qu'à récupérer les archives compressées.

Y.C.
