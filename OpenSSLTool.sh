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
OpenSSL_VER='1.0.1e'
get_path(){
echo -e 'Welcome to '$COL_BLUE'[OpenSSLtool] '$COL_RESET'currently supported version ('${OpenSSL_VER}') ...'
while true
do
	echo -ne $COL_GREEN'Enter install path: '$COL_RESET
	read -p '' prefix
		if sudo test -d $prefix; then
			prefix=$prefix'/openssl'
			if [ `(echo $prefix)` = "/openssl" ]; then
				continue
			else
				echo -e 'Installing OpenSSL in: '$prefix
				break
			fi
		else
			echo -e 'Path does not exists'
			continue
		fi
done
}
echo
echo -e '#############################################'
echo -e '| JEREMYMEILE.CH                            |'
echo -e '|                                           |'
echo -e '| OpenSSL lib builder   '$COL_BLUE'[OpenSSLtool]'$COL_RESET'               |'
echo -e '#############################################'
echo

if
	sudo -v
then
	echo
else
	exit
fi
cd /usr/local
echo -ne $COL_BLUE'[OpenSSLtool] '$COL_RESET'Checking source ...'
if
	test -f ~/Downloads/openssl-${OpenSSL_VER}.tar.gz > /dev/null 2>/tmp/openssltool_errorMSG
then
	if [ `echo $(md5 -q ~/Downloads/openssl-${OpenSSL_VER}_1+universal.darwin_10.i386-x86_64.tbz2)` != "b29188a1b33e504424232c865512cf9f" ]
	then
		echo -e $COL_RED' Not found'$COL_RESET
		echo -ne $COL_BLUE'[OpenSSLtool] '$COL_RESET'Getting source ...'
		cd ~/Downloads
		sudo rm -d -f -r OpenSSL-${OpenSSL_VER}.tar.gz > /dev/null 2>/tmp/openssltool_errorMSG
		if
			curl -O -s http://lil.fr.packages.macports.org/openssl/openssl-${OpenSSL_VER}_1+universal.darwin_10.i386-x86_64.tbz2 > /dev/null 2>/tmp/openssltool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
		else
			echo -e $COL_RED' error'$COL_RESET
			echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/openssltool_errorMSG)$COL_RESET
			exit 1
		fi
	else
		echo -e $COL_GREEN' OK'$COL_RESET
	fi
else
	echo -e $COL_RED' Not found'$COL_RESET
	echo -ne $COL_BLUE'[OpenSSLtool] '$COL_RESET'Getting source ...'
	cd ~/Downloads
	rm -d -f -r OpenSSL-${OpenSSL_VER}.tar.gz
		if
			curl -O -s http://lil.fr.packages.macports.org/openssl/openssl-${OpenSSL_VER}_1+universal.darwin_10.i386-x86_64.tbz2 > /dev/null 2>/tmp/openssltool_errorMSG
		then
			echo -e $COL_GREEN' OK'$COL_RESET
		else
			echo -e $COL_RED' error'$COL_RESET
			echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/openssltool_errorMSG)$COL_RESET
			exit 1
		fi
fi

get_path
echo -ne $COL_BLUE'[OpenSSLtool] '$COL_RESET'Preparing source ...'
if
	cd ~/Downloads
	sudo rm -d -f -r ~/Downloads/openssl-${OpenSSL_VER}_1+universal.darwin_10.i386-x86_64 > /dev/null 2>/tmp/Acetool_errorMSG
	mkdir openssl-${OpenSSL_VER}_1+universal.darwin_10.i386-x86_64
	cd openssl-${OpenSSL_VER}_1+universal.darwin_10.i386-x86_64
	tar xfy ~/Downloads/openssl-${OpenSSL_VER}_1+universal.darwin_10.i386-x86_64.tbz2
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/Acetool_errorMSG)$COL_RESET
	exit 1
fi
	
		echo -ne $COL_BLUE'[OpenSSLtool] '$COL_RESET'Installing OpenSSL ...'
		if
			sudo cp -Rp /Users/jeremymeile/Downloads/openssl-1.0.1e_1+universal.darwin_10.i386-x86_64/opt/local $prefix
			sudo install_name_tool -id $prefix/lib/libcrypto.1.0.0.dylib $prefix/lib/libcrypto.1.0.0.dylib > /dev/null 2>/tmp/openssltool_errorMSG
			sudo install_name_tool -id $prefix/lib/libssl.1.0.0.dylib $prefix/lib/libssl.1.0.0.dylib > /dev/null 2>/tmp/openssltool_errorMSG
			sudo install_name_tool -change /opt/local/lib/libz.1.dylib /usr/lib/libz.1.dylib $prefix/lib/libcrypto.1.0.0.dylib > /dev/null 2>/tmp/openssltool_errorMSG
			sudo install_name_tool -change /opt/local/lib/libz.1.dylib /usr/lib/libz.1.dylib $prefix/lib/libssl.1.0.0.dylib > /dev/null 2>/tmp/openssltool_errorMSG
			sudo install_name_tool -change /opt/local/lib/libcrypto.1.0.0.dylib $prefix/lib/libcrypto.1.0.0.dylib $prefix/lib/libssl.1.0.0.dylib > /dev/null 2>/tmp/openssltool_errorMSG

		then
			echo -e $COL_GREEN' OK'$COL_RESET
		else
			echo -e $COL_RED' error'$COL_RESET
			echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/openssltool_errorMSG)$COL_RESET
		fi