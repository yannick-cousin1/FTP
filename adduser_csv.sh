#!/bin/bash

sed 1,1d Shell_Userlist.csv | cat | while read line   # remove the first line then read each line
												# till the end of the file
do

	a1=$(echo "$line" | cut -d "," -f 1)
	a2=$(echo "$line" | cut -d "," -f 2)
	a3=$(echo "$line" | cut -d "," -f 3)
	a4=$(echo "$line" | cut -d "," -f 4)
	a5=$(echo "$line" | cut -d "," -f 5)							#Assign each field to a variable

	if [ "${a5%?}" = "User" ]							#If last field = "User"
	then
		useradd -u "$a1" -m "${a2// /}${a3// /}"				#create user with uid (a1) and username (a2+a3 without
		echo "${a2// /}${a3// /}:${a4// /}" | chpasswd
		adduser "${a2// /}${a3// /}" ftpgroup
		usermod -d "/home/${a2// /}${a3// /}" -s "/bin/false" "${a2// /}${a3// /}"				#spaces) and assign password (a4) to this user
	#	userdel -r "${a2// /}${a3// /}"

	elif [ "${a5%?}" = "Admin" ] 							#If last field = "Admin"
	then
		useradd -u "$a1" -m "${a2// /}${a3// /}"				#Do the same thing AND add this user to the group sudo
		echo "${a2// /}${a3// /}:${a4// /}" | chpasswd				#which allow it to use the sudo command
		adduser "${a2// /}${a3// /}" root
		usermod -d "/home/${a2// /}${a3// /}" -s "/bin/bash" "${a2// /}${a3// /}"					#(this group is in the sudoer file)
	#	userdel -r "${a2// /}${a3// /}"
	else
		echo "incorrect line"
	fi
done

