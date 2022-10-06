#!/bin/bash

#install sudo
yes | apt install sudo

#create ftpgroup
addgroup ftpgroup

#remove the first line cause we don't need it. Read the file line by line till the end
sed 1,1d Shell_Userlist.csv | cat | while read line

#assign each field to a variable
do

	a1=$(echo "$line" | cut -d "," -f 1)
	a2=$(echo "$line" | cut -d "," -f 2)
	a3=$(echo "$line" | cut -d "," -f 3)
	a4=$(echo "$line" | cut -d "," -f 4)
	a5=$(echo "$line" | cut -d "," -f 5)

#if last field = User
	if [ "${a5%?}" = "User" ]
	then
#adduser with id (a1) and username (a2+a3)
#set password (a4)
#add user to ftpgroup
#create home directory and forbid shell to user
		useradd -u "$a1" -m "${a2// /}${a3// /}"
		echo "${a2// /}${a3// /}:${a4// /}" | chpasswd
		adduser "${a2// /}${a3// /}" ftpgroup
		usermod -d "/home/${a2// /}${a3// /}" -s "/bin/false" "${a2// /}${a3// /}"
	#	userdel -r "${a2// /}${a3// /}"  #uncomment to delete all users

#else if last field = Admin
#add user with id (a1) and username (a2+a3)
#set password (a4)
#add user to sudo group
#create home directory and set bash shell
	elif [ "${a5%?}" = "Admin" ]
	then
		useradd -u "$a1" -m "${a2// /}${a3// /}"
		echo "${a2// /}${a3// /}:${a4// /}" | chpasswd
		adduser "${a2// /}${a3// /}" sudo
		usermod -d "/home/${a2// /}${a3// /}" -s "/bin/bash" "${a2// /}${a3// /}"
	#	userdel -r "${a2// /}${a3// /}"  #uncomment to delete all admin
	else
		echo "incorrect line"
	fi
done

