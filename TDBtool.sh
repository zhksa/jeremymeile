#!/bin/bash
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"
COL_GRAY=$ESC_SEQ"30;01m"
COL_WHITE=$ESC_SEQ"37;01m"


echo
printf '%b\n' " ______"
printf '%b\n' "/\\____ \\    ___   _ __    ___     ___  __   __  __"
printf '%b\n' "\\/___/\\ \\ /' <>\`\\/\\\`'__\\/' <>\`\\ /' _ \`' _\`\\/\\ \\/\\ \\ "
printf '%b\n' "    _\\ \\ \\/\\  ___\\ \\ \\/ /\\  ___\\/\\ \\/\\ \\/\\ \\ \\ \\_\\ \\ "
printf '%b\n' "   /\\ \\_\\ \\ \\ \\__/\\ \\_\\ \\ \\ \\__/\\ \\_\\ \\_\\ \\_\\/\`____ \\ "
printf '%b\n' "   \\ \\_____\\/\`____/\\ \\_\\ \\/\`____/\\ \\_\\ \\_\\ \\_\\/___/> \\ "
printf '%b\n' "    \`/____/ \`/___/  \\/_/  \`/___/  \\/_/\\/_/\\/_/  /\\___/ "
printf '%b\n' "  http://jeremymeile.ch             M E I L E   \\/__/ "
echo
echo -e  'TRINITYCORE DATABASE TOOL '$COL_BLUE'[TDBtool]'$COL_RESET''

echo
if
	sudo -v
then
	echo
else
	exit
fi

echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Looking for headers ...'
if [[ -d /usr/include ]]
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' Not found, running "xcode-select --install"'$COL_RESET
	xcode-select --install
	exit 1
fi
show_error(){
	echo -e $COL_RED' failed'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/TDBtool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/TDBtool_errorMSG
	return 1
	echo
}
Main_menu(){
if [[ -d $HOME/Applications/trinityserver/mysql/data ]]
then
echo -e '	Welcome to '$COL_BLUE'[TDBtool] '$COL_RESET' ...'
echo -e '	 '$COL_GREEN'[Create a new Database]'$COL_RESET' To remove the existing database and create a new one, press key '$COL_BLUE'[n/N]'$COL_RESET
echo -e '	 '$COL_MAGENTA'[Update the database]'$COL_RESET' To check the database and apply all updates, press key '$COL_BLUE'[u/U]'$COL_RESET
echo -e '	 '$COL_BLUE'[Backup the database]'$COL_RESET' To create a backup from the full database, press key '$COL_BLUE'[b/B]'$COL_RESET
echo -e '	 '$COL_YELLOW'[Internal IP]'$COL_RESET' To set realmlist to your internal ip address, press key '$COL_BLUE'[i/I]'$COL_RESET
echo -e '	 '$COL_YELLOW'[External IP]'$COL_RESET' To set realmlist to your external ip address, press key '$COL_BLUE'[e/E]'$COL_RESET
echo -e '	 '$COL_RED'[Exit the Script]'$COL_RESET' To exit the script, press key '$COL_BLUE'[q/Q]'$COL_RESET
	while true; do
		read -p 'To continue, make a choice and press enter: ' yn
		case $yn in
		[Nn]* ) sudo rm -d -f -r $HOME/Applications/trinityserver/mysql/data
				break ;;
		[Uu]* ) break ;;
		[Bb]* ) Backup_DB
				break ;;
		[Ii]* )	realmlist_set_internal
				break ;;
		[Ee]* )	realmlist_set_external
				break ;;
		[Qq]* ) echo "OK. Bye!"
				exit ;;
		* ) ;;
		esac
	done
fi
}
MySQL_pw(){
echo -en $COL_WHITE' Please enter a new MySQL root password: '$COL_RESET
while true
	do
		read userPass
		if [ $userPass = "``" ]
		then
			continue
		else
			break
		fi
done
echo $userPass
}
Remove_dubs(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Deleting duplicated sql Files ...'
IFS=$'\n'
for f in $(sudo /usr/bin/find $HOME/Applications/trinityserver/sql -type f -exec /usr/bin/cksum {} \; | /usr/bin/sort); do
    sum=${f%% *}
    [[ $prev == $sum ]] && sudo /bin/rm "$(sudo /usr/bin/cut -d' ' -f3- <<< "$f")"
    prev=$sum
done
}
Check_files(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Initializing sql Files ...'
if
sudo /usr/bin/find -s $HOME/Applications/trinityserver | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/grep -e '\.sql' | /usr/bin/awk '{ printf "%s ", $0 }' | /usr/bin/sed '/^$/d' > /tmp/TDBtool_files
then
	if [ "`echo $(/bin/cat /tmp/TDBtool_files | /usr/bin/sed '/^$/d' | /usr/bin/sed -n '/characters_/p')`" != "" ]
	then
		if [ "`echo $(/bin/cat /tmp/TDBtool_files | /usr/bin/sed '/^$/d' | /usr/bin/sed -n '/world_/p')`" != "" ]
		then
			if [ "`echo $(/bin/cat /tmp/TDBtool_files | /usr/bin/sed '/^$/d' | /usr/bin/sed -n '/auth_/p')`" != "" ]
			then
				if [ "`echo $(/bin/cat /tmp/TDBtool_files | /usr/bin/sed '/^$/d' | /usr/bin/sed -n '/create_mysql.sql/p')`" != "" ]
				then
					return 0
				else
					return 1
				fi
			else
				return 1
			fi
		else
			return 1
		fi
	else
		return 1
	fi
else
	return 1
fi
rm /tmp/TDBtool_files
}
Check_MySQL(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Initializing MySQL directory ...'
	if
	test -x $HOME/Applications/trinityserver/mysql/support-files/mysql.server
	then
		if
		test -x $HOME/Applications/trinityserver/mysql/bin/mysqld_safe
		then
			if
			test -x $HOME/Applications/trinityserver/mysql/bin/mysql
			then
				if
				test -x $HOME/Applications/trinityserver/mysql/bin/mysqldump
				then
					return 0
				else
					return 1
				fi
			else
			return 1
			fi
		else
		return 1
		fi
	else
	return 1
	fi
}
Check_DB(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Initializing Database ...'
if [[ -d $HOME/Applications/trinityserver/mysql/data ]]; then
	if
	pw=$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD 2>/tmp/TDBtool_errorMSG)
	then
		if
		echo -e $COL_GREEN' OK'$COL_RESET
		MySQL_start
		then
			echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Testing Database ...'
			if
				result=$(sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$pw update_info -e "SELECT * FROM world;" 2>/tmp/TDBtool_errorMSG)
			then
				echo -e $COL_GREEN' OK'$COL_RESET
					echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Checking if a new Database is required ...'
					if [ "`echo $result | /usr/bin/awk 'END{print}'`" != "" ]
					then
						echo -e $COL_GREEN' NO'$COL_RESET
						return 0
					else
						echo -e $COL_GREEN' YES'$COL_RESET
						return 1
					fi
			else
				show_error
			fi
		else
			return 1
		fi
	else
		show_error
	fi
else
	echo -e $COL_RED' Not found'$COL_RESET
	return 1
fi
}
Check_MySQL_user(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Initializing _mysql user ...'
if
	K=$(/usr/bin/dscl . -list /Users | /usr/bin/grep -e 'mysql') 2>/tmp/TDBtool_errorMSG
then
	if [ "$K" = "_mysql" ]
	then
		echo -e $COL_GREEN' OK'$COL_RESET
		return 0
	else
		echo -e $COL_RED' NO _mysql user found'$COL_RESET
		Create_MySQL_user
	fi
else
	show_error
fi
}
Create_MySQL_user(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating _mysql user ...'
if
	UserIDNUM=$(($(/usr/bin/dscl . -list /Users UniqueID | /usr/bin/awk '{print $2}' | /usr/bin/sort -ug | /usr/bin/tail -1)+1)) 2>/tmp/TDBtool_errorMSG
	GroupIDNUM=$(($(/usr/bin/dscl . -list /Groups PrimaryGroupID | /usr/bin/awk '{print $2}' | /usr/bin/sort -ug | /usr/bin/tail -1)+1)) 2>/tmp/TDBtool_errorMSG
then
	if
		sudo /usr/bin/dscl . create /Users/_mysql > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . append /Users/_mysql RecordName mysql > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . create /Users/_mysql RealName "MySQL User" > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . create /Users/_mysql UniqueID $UserIDNUM > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . create /Users/_mysql PrimaryGroupID $GroupIDNUM > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . create /Users/_mysql UserShell /usr/bin/false > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
		return 0
	else
		show_error
	fi						
else
	show_error
fi
}
Check_MySQL_group(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Initializing _mysql group ...'
if
	K=$(/usr/bin/dscl . -list /Groups | /usr/bin/grep -e 'mysql') 2>/tmp/TDBtool_errorMSG
then
	if [ "$K" = "_mysql" ]
	then
		echo -e $COL_GREEN' OK'$COL_RESET
		return 0
	else
		echo -e $COL_RED' NO _mysql group found'$COL_RESET
		Create_MySQL_group
	fi
else
	show_error
fi
}
Create_MySQL_group(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating _mysql group ...'
if
	GroupIDNUM=$(($(/usr/bin/dscl . -list /Groups PrimaryGroupID | /usr/bin/awk '{print $2}' | /usr/bin/sort -ug | /usr/bin/tail -1)+1)) 2>/tmp/TDBtool_errorMSG
then
	if
		sudo /usr/bin/dscl . create /Groups/_mysql > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . append /Groups/_mysql RecordName mysql > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . create /Groups/_mysql PrimaryGroupID $GroupIDNUM > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo /usr/bin/dscl . create /Groups/_mysql RealName "MySQL Group" > /dev/null 2>/tmp/TDBtool_errorMSG	
	then
		echo -e $COL_GREEN' OK'$COL_RESET
		return 0
	else
		show_error
	fi						
else
	show_error
fi
}
MySQL_kill(){
if [ "`ps ax | /usr/bin/grep mysqld | /usr/bin/grep -v /usr/bin/grep | /usr/bin/awk '{ print $5 }' | /usr/bin/sed '/^$/d' | /usr/bin/grep mysqld`" != "" ]
	then
		echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Killing all active mysqld ...'
		if
		killall mysqld 2>/tmp/TDBtool_errorMSG
		sudo killall mysqld 2>/tmp/TDBtool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
			return 0
		else	
			show_error
		fi
fi
}
MySQL_stop(){
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Stopping MySQL ...'
	sleep 2
		if
		sudo $HOME/Applications/trinityserver/mysql/support-files/mysql.server stop > /dev/null 2>/tmp/TDBtool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
			return 0
		else	
			show_error
		fi
	sleep 2
}

MySQL_start(){
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Starting MySQL ...'
	sleep 2
		if
		sudo $HOME/Applications/trinityserver/mysql/support-files/mysql.server start > /dev/null 2>/tmp/TDBtool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
			return 0
		else
			show_error
		fi
	sleep 2
}
MySQL_restart(){
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Restarting MySQL ...'
	sleep 2
		if
		sudo $HOME/Applications/trinityserver/mysql/support-files/mysql.server restart > /dev/null 2>/tmp/TDBtool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
			return 0
		else
			show_error
		fi
	sleep 2
}
Get_TDB(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Looking for TrinityDB ...'
sleep 2
tdbfile=`sudo /usr/bin/find -s $HOME/Applications/trinityserver/sql | /usr/bin/grep -e '\.sql' | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/TDB_full/p' | /usr/bin/awk 'END{print}'`
if [ "$tdbfile" = "" ]
then
	echo -e $COL_RED' Not found'$COL_RESET
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Downloading latest TrinityDB ...'
		if
			sudo chown -R $USER $HOME/Applications/trinityserver/*
			sudo chown -R mysql $HOME/Applications/trinityserver/mysql/data
			curl -s http://www.trinitycore.org/f/files/getdownload/546-tdb-full-updates/ > $HOME/Applications/trinityserver/sql/base/tdb.7z 2>/tmp/TDBtool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
				echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Extracting TrinityDB ...'
				if
					cd $HOME/Applications/trinityserver/sql/base; 7z x -y $HOME/Applications/trinityserver/sql/base/tdb.7z > /dev/null 2>/tmp/TDBtool_errorMSG
				then
					echo -e $COL_GREEN' OK'$COL_RESET
					Get_TDB
				else
					show_error
				fi
		else
			show_error
		fi
else				
	echo -e ' "'$COL_MAGENTA$tdbfile$COL_RESET'"'$COL_GREEN' Found'$COL_RESET
fi
sleep 2
}
world_update(){
			if
				f=`sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "SELECT * FROM world ORDER BY file DESC LIMIT 1;" | /usr/bin/sed '/^$/d' | /usr/bin/awk 'END{print}' 2>/tmp/TDBtool_errorMSG`
					if [ "$f" = "file" ]; then
						show_error
					fi
											if [ "$(echo $f | /usr/bin/sed -n '/99_world_db/p')" = "" ]; then
												if [ "$(/usr/bin/find -d $HOME/Applications/trinityserver/sql -name $f)" = "" ]; then
													echo -e $COL_RED' failed'$COL_RESET
													echo -e $COL_RED'    error '$COL_WHITE'Can not find '$f'. Maybe the file has been renamed in the past commits. Please check the "update_info" database with an SQL Editor and correct the file names.'$COL_RESET
													return 1
													echo
												fi
											fi
			then
						file=$(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql | awk 'BEGIN {print "'$C'"} {print $0}' | /usr/bin/grep -e '\.sql' | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/_world_/p' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/sort -n | /usr/bin/awk '/'$f'/{f=1;next}f' | /usr/bin/sed '/^$/d' | /usr/bin/head -1 2>/tmp/TDBtool_errorMSG)
								if [ "$curvar" = "0" ]; then
									maxvar=$(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql | awk 'BEGIN {print "'$C'"} {print $0}' | /usr/bin/grep -e '\.sql' | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/_world_/p' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/sort -n | /usr/bin/awk '/'$f'/{f=1;next}f' | /usr/bin/sed '/^$/d' | /usr/bin/wc -l | /usr/bin/sed 's/[^0-9]//g' 2>/tmp/TDBtool_errorMSG)
								fi
										if [ "$file" = "" ]; then
											if [ "$first" = "0" ]; then
												echo -e $COL_GREEN' Up to date '$COL_RESET$COL_WHITE'['$f']'$COL_RESET
												return 0
											fi
										else
											if [ "$first" = "0" ]; then
												echo
												first='1'
											fi
											echo -ne '       --> '
											echo -ne $COL_MAGENTA $(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/head -1)$COL_RESET
											curvar=$[curvar+1]
											echo -ne ' ['$curvar'/'$maxvar']'
											echo -ne ' ...'
												if
													sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk '{ print "source",$0 }' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password world 2>/tmp/TDBtool_errorMSG
												then
													echo -e $COL_GREEN' OK'$COL_RESET
														B=$(/usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/head -1)
															if
																#sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "DELETE FROM world;"
																sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "INSERT INTO world VALUES ('$B');"
															then
																world_update
															else	
																echo ' FAILED TO APPLY INFORMATION TO UPDATE_DB'
																	Backup_restore
																exit 1
															fi
												else
													show_error
													Backup_restore
													exit 1
												fi
										fi
			else
				show_error
			fi
}
auth_update(){
			if
				f=`sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "SELECT * FROM auth ORDER BY file DESC LIMIT 1;" | /usr/bin/sed '/^$/d' | /usr/bin/awk 'END{print}' 2>/tmp/TDBtool_errorMSG`
					if [ "$f" = "file" ]; then
						show_error
					fi
											if [ "$(echo $f | /usr/bin/sed -n '/99_world_db/p')" = "" ]; then
												if [ "$(/usr/bin/find -d $HOME/Applications/trinityserver/sql -name $f)" = "" ]; then
													echo -e $COL_RED' failed'$COL_RESET
													echo -e $COL_RED'    error '$COL_WHITE'Can not find '$f'. Maybe the file has been renamed in the past commits. Please check the "update_info" database with an SQL Editor and correct the file names.'$COL_RESET
													return 1
													echo
												fi
											fi					
			then
						file=$(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql | awk 'BEGIN {print "'$C'"} {print $0}' | /usr/bin/grep -e '\.sql' | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/_auth_/p' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/sort -n | /usr/bin/awk '/'$f'/{f=1;next}f' | /usr/bin/sed '/^$/d' | /usr/bin/head -1 2>/tmp/TDBtool_errorMSG)
								if [ "$curvar" = "0" ]; then
									maxvar=$(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql | awk 'BEGIN {print "'$C'"} {print $0}' | /usr/bin/grep -e '\.sql' | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/_auth_/p' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/sort -n | /usr/bin/awk '/'$f'/{f=1;next}f' | /usr/bin/sed '/^$/d' | /usr/bin/wc -l | /usr/bin/sed 's/[^0-9]//g' 2>/tmp/TDBtool_errorMSG)
								fi
										if [ "$file" = "" ]; then
											if [ "$first" = "0" ]; then
												echo -e $COL_GREEN' Up to date '$COL_RESET$COL_WHITE'['$f']'$COL_RESET
												return 0
											fi
										else
											if [ "$first" = "0" ]; then
												echo
												first='1'
											fi
											echo -ne '       --> '
											echo -ne $COL_MAGENTA $(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/head -1)$COL_RESET
											curvar=$[curvar+1]
											echo -ne ' ['$curvar'/'$maxvar']'
											echo -ne ' ...'
												if
													sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk '{ print "source",$0 }' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password auth 2>/tmp/TDBtool_errorMSG
												then
													echo -e $COL_GREEN' OK'$COL_RESET
														B=$(/usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/head -1)
															if
																#sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "DELETE FROM auth;"
																sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "INSERT INTO auth VALUES ('$B');"
															then
																auth_update
															else	
																echo ' FAILED TO APPLY INFORMATION TO UPDATE_DB'
																	Backup_restore
																exit 1
															fi
												else
													show_error
													Backup_restore
													exit 1
												fi
										fi
			else
				show_error
			fi
}
characters_update(){
			if
				f=`sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "SELECT * FROM characters ORDER BY file DESC LIMIT 1;" | /usr/bin/sed '/^$/d' | /usr/bin/awk 'END{print}' 2>/tmp/TDBtool_errorMSG`
					if [ "$f" = "file" ]; then
						show_error
					fi
											if [ "$(echo $f | /usr/bin/sed -n '/99_world_db/p')" = "" ]; then
												if [ "$(/usr/bin/find -d $HOME/Applications/trinityserver/sql -name $f)" = "" ]; then
													echo -e $COL_RED' failed'$COL_RESET
													echo -e $COL_RED'    error '$COL_WHITE'Can not find '$f'. Maybe the file has been renamed in the past commits. Please check the "update_info" database with an SQL Editor and correct the file names.'$COL_RESET
													return 1
													echo
												fi
											fi
			then
						file=$(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql | awk 'BEGIN {print "'$C'"} {print $0}' | /usr/bin/grep -e '\.sql' | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/_characters_/p' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/sort -n | /usr/bin/awk '/'$f'/{f=1;next}f' | /usr/bin/sed '/^$/d' | /usr/bin/head -1 2>/tmp/TDBtool_errorMSG)
								if [ "$curvar" = "0" ]; then
									maxvar=$(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql | awk 'BEGIN {print "'$C'"} {print $0}' | /usr/bin/grep -e '\.sql' | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/_characters_/p' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/sort -n | /usr/bin/awk '/'$f'/{f=1;next}f' | /usr/bin/sed '/^$/d' | /usr/bin/wc -l | /usr/bin/sed 's/[^0-9]//g' 2>/tmp/TDBtool_errorMSG)
								fi
										if [ "$file" = "" ]; then
											if [ "$first" = "0" ]; then
												echo -e $COL_GREEN' Up to date '$COL_RESET$COL_WHITE'['$f']'$COL_RESET
												return 0
											fi
										else
											if [ "$first" = "0" ]; then
												echo
												first='1'
											fi
											echo -ne '       --> '
											echo -ne $COL_MAGENTA $(sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/head -1)$COL_RESET
											curvar=$[curvar+1]
											echo -ne ' ['$curvar'/'$maxvar']'
											echo -ne ' ...'
												if
													sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk '{ print "source",$0 }' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password characters 2>/tmp/TDBtool_errorMSG
												then
													echo -e $COL_GREEN' OK'$COL_RESET
														B=$(/usr/bin/find -d $HOME/Applications/trinityserver/sql -name $file | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/head -1)
															if
																#sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "DELETE FROM characters;"
																sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$mysql_password update_info -e "INSERT INTO characters VALUES ('$B');"
															then
																characters_update
															else	
																echo ' FAILED TO APPLY INFORMATION TO UPDATE_DB'
																	Backup_restore
																exit 1
															fi
												else
													show_error
													Backup_restore
													exit 1
												fi
										fi
			else
				show_error
			fi
}
DB_update(){
mysql_password=$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD)
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running world updates ...'
		if
			first='0'
			maxvar='0'
			curvar='0'
			world_update
		then
				echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running auth updates ...'
			if
				first='0'
				maxvar='0'
				curvar='0'
				auth_update
			then
				echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running characters updates ...'
				if
					first='0'
					maxvar='0'
					curvar='0'
					characters_update
				then
					return 0
				fi
			return 1
			fi
		else
		return 1
		fi
}
Backup_restore(){
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Looking for Backups ...'
bkfile=`sudo /usr/bin/find -s $HOME/Applications/trinityserver | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/TDB_backup/p' | /usr/bin/grep -e '\.7z' | /usr/bin/awk 'END{print}'`
if [ "$bkfile" = "" ]
then
	echo -e $COL_RED' No backups available'$COL_RESET
	MySQL_stop
	exit 1
else
	echo -e ' "'$COL_MAGENTA$bkfile$COL_RESET'"'$COL_GREEN' Found'$COL_RESET
fi
f=`echo $bkfile | /usr/bin/awk '{gsub(".7z", "");print}'`
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Extracting "'$COL_MAGENTA$f$COL_RESET'" ...'
	cd $HOME/Applications/trinityserver/DB_backups
	if
		sudo 7z x -y $(sudo /usr/bin/find -s $HOME/Applications/trinityserver | /usr/bin/sed -n '/TDB_backup/p' | /usr/bin/grep -e '\.7z' | /usr/bin/awk 'END{print}') > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
		Backup_restore
		exit 1
	fi
MySQL_start
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Restore Database from "'$COL_MAGENTA$f$COL_RESET'" ...'
	if
		sudo /usr/bin/find -s $HOME/Applications/trinityserver | /usr/bin/awk '{ print "source",$0 }' | /usr/bin/sed -n '/TDB_backup/p' | /usr/bin/grep -e '\.sql' | /usr/bin/awk 'END{print}' | /usr/bin/awk '{gsub(".7z", "");print}' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) > /dev/null 2>/tmp/TDBtool_errorMSG
		then
		echo -e $COL_GREEN' OK'$COL_RESET
	else
		show_error
		Backup_restore
		exit 1
	fi
MySQL_stop
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Reload root password ...'
	if
		sudo cp $HOME/Applications/trinityserver/DB_backups/MYSQL_PASSWORD $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD > /dev/null 2>&1
		then
		echo -e $COL_GREEN' OK'$COL_RESET
		sudo rm -d -f -r $(sudo /usr/bin/find -s $HOME/Applications/trinityserver | /usr/bin/awk '{ print "source",$0 }' | /usr/bin/sed -n '/TDB_backup/p' | /usr/bin/grep -e '\.sql' | /usr/bin/awk 'END{print}') > /dev/null 2>/tmp/TDBtool_errorMSG
		sudo rm -d -f -r $HOME/Applications/trinityserver/DB_backups/MYSQL_PASSWORD > /dev/null 2>/tmp/TDBtool_errorMSG
	else
		show_error
		Backup_restore
		exit 1
	fi
MySQL_start
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Testing MySQL ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) world -e "SELECT * FROM item_template;" > /dev/null 2>/tmp/TDBtool_errorMSG
		then
		echo -e $COL_GREEN' OK'$COL_RESET
	else
		show_error
		Backup_restore
		exit 1
	fi
MySQL_stop
}
Backup_DB(){
if
	Check_MySQL
then
	echo -e $COL_GREEN' OK'$COL_RESET
if
	Check_DB
then
	MySQL_start
		echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating Database backup ...'
		backup_file=TDB_backup_$(/bin/date "+%Y-%m-%d-%H-%M-%S").sql
	if /bin/mkdir -p $HOME/Applications/trinityserver/DB_backups > /dev/null 2>/tmp/TDBtool_errorMSG; then
		echo -n ''
		else
			echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/TDBtool_errorMSG)$COL_RESET
			MySQL_stop
			exit 1
	fi
	if sudo /bin/test -f $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD
		then
			if
			sudo $HOME/Applications/trinityserver/mysql/bin/mysqldump -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) --all-databases > $HOME/Applications/trinityserver/DB_backups/$backup_file 2>/tmp/TDBtool_errorMSG
			then
				echo -e $COL_GREEN' OK'$COL_RESET
			else	
				show_error
				rm -d -f -r $HOME/Applications/trinityserver/DB_backups/$backup_file > /dev/null 2>/tmp/TDBtool_errorMSG
				exit 1
			fi
	else
			echo
			echo '  MYSQL ROOT PW NOT FOUND! ENTER YOUR PASSWORD PLEASE.'
			if
			$HOME/Applications/trinityserver/mysql/bin/mysqldump -u root -p --all-databases > $HOME/Applications/trinityserver/DB_backups/$backup_file > /dev/null 2>/tmp/TDBtool_errorMSG
			then
				echo -e $COL_GREEN' OK'$COL_RESET
			else	
				show_error
				rm -d -f -r $HOME/Applications/trinityserver/DB_backups/$backup_file > /dev/null 2>/tmp/TDBtool_errorMSG
				exit 1
			fi
	fi
	if
		/bin/test -f $HOME/Applications/trinityserver/DB_backups/$backup_file
	then
		echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Compressing Database backup ...'
		if
		sudo 7z a -t7z -mx1 $HOME/Applications/trinityserver/DB_backups/$backup_file.7z $HOME/Applications/trinityserver/DB_backups/$backup_file $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD > /dev/null 2>/tmp/TDBtool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
		else	
			show_error
		fi
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Cleaning ...'
	if
	rm -d -f -r $HOME/Applications/trinityserver/DB_backups/$backup_file > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
	fi
#MySQL_stop
#MySQL_kill
#exit 1
DB_update
exit
fi
else
show_error
fi
}
realmlist_set_internal(){
Check_DB
MySQL_start
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Getting internal ip address ...'
if
	 INTERNAL=$(ipconfig getifaddr en1) > /dev/null 2>/tmp/TDBtool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Setting realmlist to "'$INTERNAL'" ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) auth -e "UPDATE realmlist SET address = '$INTERNAL';" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else
		show_error
	fi
else
	show_error
fi
MySQL_stop
exit
}
realmlist_set_external(){
Check_DB
MySQL_start
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Getting external ip address ...'
if
	 EXTERNAL=$(curl -s http://checkip.dyndns.org | grep -Eo '([0-9]*\.){3}[0-9]*') > /dev/null 2>/tmp/TDBtool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Setting realmlist to "'$EXTERNAL'" ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) auth -e "UPDATE realmlist SET address = '$EXTERNAL';" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else
		show_error
	fi
else
	show_error
fi
MySQL_stop
exit
}
#functions_end

Main_menu
MySQL_kill
if
	Check_files
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo
	echo -e $COL_RED$'Some sql files missing!'$COL_RESET
	echo -e $COL_RED$'Make sure that $HOME/Applications/trinityserver/sql/ exists.'$COL_RESET
	echo
	MySQL_stop
	exit 1
fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Looking for 7z ...'
if
	7z > /dev/null 2>&1
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		echo -e $COL_RED' error'$COL_RESET
		echo
		echo -e $COL_RED'Can not find the 7z command line tool!'$COL_RESET
		echo -e $COL_RED'You can run the following commands to install 7z:'$COL_RESET
		echo -e '     ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"'
		echo -e '     brew install p7zip'
		echo
		MySQL_stop
		exit 1		
fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Looking for Base64 ...'
if
	base64 -h > /dev/null 2>&1
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		echo -e $COL_RED' error'$COL_RESET
		echo
		echo -e $COL_RED'Can not find the base64 command line tool!'$COL_RESET
		echo -e $COL_RED'You can run the following commands to install 7z:'$COL_RESET
		echo -e '     ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"'
		echo -e '     brew install base64'
		echo
		MySQL_stop
		exit 1		
fi
MySQL_stop
Check_MySQL_user
Check_MySQL_group
if Remove_dubs
then
	echo -e $COL_GREEN' OK'$COL_RESET
else	
show_error
fi
Backup_DB
MySQL_stop
	echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating new Database ...'
	sleep 2
	sudo rm -d -f -r $HOME/Applications/trinityserver/mysql/data
	sudo rm -d -f -r ~/my.cnf 
	sudo rm -d -f -r ~/etc/my.cnf 
	sudo rm -d -f -r ./my.cnf 
		if
		cd $HOME/Applications/trinityserver/mysql ; sudo $HOME/Applications/trinityserver/mysql/scripts/mysql_install_db --explicit_defaults_for_timestamp --no-defaults --cross-bootstrap --user=mysql --force --datadir=$HOME/Applications/trinityserver/mysql/data > /dev/null 2>/tmp/TDBtool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
		else	
			show_error
		fi
MySQL_stop
MySQL_start
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Generating MySQL root password ...'
pw_file=MYSQL_PASSWORD
	if
		myPW=$(/bin/cat /dev/urandom | base64 | tr -dc A-Za-z0-9_ | /usr/bin/head -c8 2>/tmp/TDBtool_errorMSG)
		echo $myPW > /tmp/MYSQL_PASSWORD 2>/tmp/TDBtool_errorMSG
		sudo cp /tmp/MYSQL_PASSWORD $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD 2>/tmp/TDBtool_errorMSG
		rm -d -f -r /tmp/MYSQL_PASSWORD 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Drop "test" database ...'
	if
		$HOME/Applications/trinityserver/mysql/bin/mysql -u root -e "DROP DATABASE IF EXISTS test;" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Delete Unknown user ...'
	if
		$HOME/Applications/trinityserver/mysql/bin/mysql -u root -e "DELETE FROM mysql.user WHERE User = '';" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Set new root password ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -e "UPDATE mysql.user SET Password = PASSWORD('$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD)') WHERE User = 'root';" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
		sudo rm -d -f -r $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD
		exit 1
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Flush privileges ...'
	if
		$HOME/Applications/trinityserver/mysql/bin/mysql -u root -e "FLUSH PRIVILEGES;" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating update_info database ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) -e "CREATE DATABASE update_info DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating "world" table ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "CREATE TABLE world (file text);" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating "auth" table ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "CREATE TABLE auth (file text);" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Creating "character" table ...'
	if
		sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "CREATE TABLE characters (file text);" > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running "'$COL_MAGENTA'create_mysql.sql'$COL_RESET'" ...'

	if
		sudo /usr/bin/find -s $HOME/Applications/trinityserver/sql -name create_mysql.sql | /usr/bin/awk '{ print "source",$0 }' | /usr/bin/awk 'END{print}' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
	else	
		show_error
		Backup_restore
		exit 1
	fi
Get_TDB					
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running "'$COL_MAGENTA$tdbfile$COL_RESET'" ...'
	if
		sudo /usr/bin/find -d $HOME/Applications/trinityserver/sql -name $tdbfile | /usr/bin/awk '{ print "source",$0 }' | /usr/bin/awk 'END{print}' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) world 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
		A=$(echo $tdbfile | /usr/bin/grep -o '\(201[0-9]\{1\}_[0-9]\{2\}_[0-9]\{2\}\)')
					if [ "$A" = "" ]
						then
						echo -e $COL_RED' error: no tdbfile'$COL_RESET
						return 1
					fi
		echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Adding update info ...'
			if
					B='_99_world_db.sql'
					C=$A$B
					sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "DELETE FROM world;"
					sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "INSERT INTO world VALUES ('$C');"
			then
					echo -e $COL_GREEN' OK'$COL_RESET
			else	
				show_error
				Backup_restore
				exit 1
			fi
	else	
			show_error
			Backup_restore
			exit 1
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running "'$COL_MAGENTA'characters_database.sql'$COL_RESET'" ...'
	if
		sudo /usr/bin/find -s $HOME/Applications/trinityserver/sql -name characters_database.sql | /usr/bin/awk 'END{print}' | /usr/bin/awk '{ print "source",$0 }' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) characters > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
			B=$(/usr/bin/find -d $HOME/Applications/trinityserver/sql | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/grep -e '\.sql' | /usr/bin/sed -n '/_characters_/p' | /usr/bin/sort -n | /usr/bin/sed '/^$/d' | /usr/bin/sed '$!d')
			echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Adding update info ...'
					if
						sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "DELETE FROM characters;"
						sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "INSERT INTO characters VALUES ('$B');"
					then
						echo -e $COL_GREEN' OK'$COL_RESET
					else	
						show_error
						Backup_restore
						exit 1
					fi
				else	
			show_error
			Backup_restore
			exit 1
	fi
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running "'$COL_MAGENTA'auth_database.sql'$COL_RESET'" ...'
	if
		sudo /usr/bin/find -s $HOME/Applications/trinityserver/sql -name auth_database.sql | /usr/bin/awk 'END{print}' | /usr/bin/awk '{ print "source",$0 }' | sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) auth > /dev/null 2>/tmp/TDBtool_errorMSG
	then
		echo -e $COL_GREEN' OK'$COL_RESET
			B=$(/usr/bin/find -d $HOME/Applications/trinityserver/sql | /usr/bin/awk -F/ '{print $NF}' | /usr/bin/sed -n '/201[0-9]\{1\}_[0-9][0-9]\{1\}_[0-9][0-9]/p' | /usr/bin/grep -e '\.sql' | /usr/bin/sed -n '/_auth_/p' | /usr/bin/sort -n | /usr/bin/sed '/^$/d' | /usr/bin/sed '$!d')
			echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Adding update info ...'
					if
						sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "DELETE FROM auth;"
						sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) update_info -e "INSERT INTO auth VALUES ('$B');"
					then
						echo -e $COL_GREEN' OK'$COL_RESET
					else	
						show_error
						Backup_restore
						exit 1
					fi
				else	
					show_error
					Backup_restore
					exit 1
	fi
DB_update
if
/bin/test -d $HOME/Applications/trinityserver/sql/Transmogrification
then
		echo -e $COL_BLUE'[TDBtool] '$COL_RESET'TransmogrificationNPC found ...'
		if /bin/test -f $HOME/Applications/trinityserver/sql/Transmogrification/characters.sql; then
			echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running "'$COL_MAGENTA'characters.sql'$COL_RESET'" ...'
				if
					sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) characters < $HOME/Applications/trinityserver/sql/Transmogrification/characters.sql > /dev/null 2>/tmp/TDBtool_errorMSG
				then
					echo -e $COL_GREEN' OK'$COL_RESET
				else	
					show_error
				fi
		fi
		if /bin/test -f $HOME/Applications/trinityserver/sql/Transmogrification/world_texts.sql; then
		
			echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running "'$COL_MAGENTA'world_texts.sql'$COL_RESET'" ...'
				if
					sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) world < $HOME/Applications/trinityserver/sql/Transmogrification/world_texts.sql > /dev/null 2>/tmp/TDBtool_errorMSG
				then
					echo -e $COL_GREEN' OK'$COL_RESET
				else	
					show_error
				fi
		fi
		if /bin/test -f $HOME/Applications/trinityserver/sql/Transmogrification/world_NPC.sql; then
		
			echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Running "'$COL_MAGENTA'world_NPC.sql'$COL_RESET'" ...'
				if
					sudo $HOME/Applications/trinityserver/mysql/bin/mysql -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) world < $HOME/Applications/trinityserver/sql/Transmogrification/world_NPC.sql > /dev/null 2>/tmp/TDBtool_errorMSG
				then
					echo -e $COL_GREEN' OK'$COL_RESET
				else	
					show_error
				fi
		fi
fi
MySQL_restart
echo -ne $COL_BLUE'[TDBtool] '$COL_RESET'Optimizing all Databases ...'
if
sudo $HOME/Applications/trinityserver/mysql/bin/mysqlcheck -u root -p$(sudo /bin/cat $HOME/Applications/trinityserver/mysql/data/MYSQL_PASSWORD) -o --all-databases > /dev/null 2>/tmp/TDBtool_errorMSG
then
echo -e $COL_GREEN' OK'$COL_RESET
else
show_error
fi
MySQL_stop
MySQL_kill
exit
