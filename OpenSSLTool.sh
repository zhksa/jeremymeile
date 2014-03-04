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
OPENSSL_VERSION="1.0.1f"
get_path(){
echo -e 'Welcome to '$COL_BLUE'[OpenSSLTool] '$COL_RESET'currently supported version ('${OPENSSL_VERSION}') ...'
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
printf '%b\n' " ______"
printf '%b\n' "/\\____ \\    ___   _ __    ___     ___  __   __  __"
printf '%b\n' "\\/___/\\ \\ /' <>\`\\/\\\`'__\\/' <>\`\\ /' _ \`' _\`\\/\\ \\/\\ \\ "
printf '%b\n' "    _\\ \\ \\/\\  ___\\ \\ \\/ /\\  ___\\/\\ \\/\\ \\/\\ \\ \\ \\_\\ \\ "
printf '%b\n' "   /\\ \\_\\ \\ \\ \\__/\\ \\_\\ \\ \\ \\__/\\ \\_\\ \\_\\ \\_\\/\`____ \\ "
printf '%b\n' "   \\ \\_____\\/\`____/\\ \\_\\ \\/\`____/\\ \\_\\ \\_\\ \\_\\/___/> \\ "
printf '%b\n' "    \`/____/ \`/___/  \\/_/  \`/___/  \\/_/\\/_/\\/_/  /\\___/ "
printf '%b\n' "  http://jeremymeile.ch             M E I L E   \\/__/ "
echo
echo -e  'OpenSSL installer Script '$COL_BLUE'[OpenSSLTool]'$COL_RESET''
echo
echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Looking for headers ...'
if [[ -d /usr/include ]]
then
    echo -e $COL_GREEN' OK'$COL_RESET
else
    echo -e $COL_RED' Not found, running "xcode-select --install"'$COL_RESET
    xcode-select --install
    exit 1
fi
if
    sudo -v
then
    echo
else
    exit
fi
cd /usr/local
echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Checking source ...'
if
    test -f ~/Downloads/openssl-${OPENSSL_VERSION}.tar.gz > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
    if [ `echo $(md5 -q ~/Downloads/openssl-${OPENSSL_VERSION}.tar.gz)` != "f26b09c028a0541cab33da697d522b25" ]
    then
        echo -e $COL_RED' Not found'$COL_RESET
        echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Getting source ...'
        cd ~/Downloads
        sudo rm -d -f -r openssl-${OPENSSL_VERSION}.tar.gz > /dev/null 2>/tmp/OpenSSLTool_errorMSG
        if
            curl -O -s http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz > /dev/null 2>/tmp/OpenSSLTool_errorMSG
        then
            echo -e $COL_GREEN' OK'$COL_RESET
        else
            echo -e $COL_RED' error'$COL_RESET
            echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
            rm -d -f -r /tmp/OpenSSLTool_errorMSG
            exit 1
        fi
    else
        echo -e $COL_GREEN' OK'$COL_RESET
    fi
else
    echo -e $COL_RED' Not found'$COL_RESET
    echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Getting source ...'
    cd ~/Downloads
    rm -d -f -r openssl-${OPENSSL_VERSION}.tar.gz
        if
            curl -O -s http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz > /dev/null 2>/tmp/OpenSSLTool_errorMSG
        then
            echo -e $COL_GREEN' OK'$COL_RESET
        else
            echo -e $COL_RED' error'$COL_RESET
            echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
            rm -d -f -r /tmp/OpenSSLTool_errorMSG
            exit 1
        fi
fi
get_path
echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Preparing source ...'
if
    cd ~/Downloads
    sudo rm -d -f -r ~/Downloads/openssl_i386 > /dev/null 2>/tmp/OpenSSLTool_errorMSG
    sudo rm -d -f -r ~/Downloads/openssl_x86_64 > /dev/null 2>/tmp/OpenSSLTool_errorMSG
	tar -xvzf openssl-$OPENSSL_VERSION.tar.gz > /dev/null 2>/tmp/OpenSSLTool_errorMSG
	mv openssl-$OPENSSL_VERSION openssl_i386
	tar -xvzf openssl-$OPENSSL_VERSION.tar.gz > /dev/null 2>/tmp/OpenSSLTool_errorMSG
	mv openssl-$OPENSSL_VERSION openssl_x86_64
then
    echo -e $COL_GREEN' OK'$COL_RESET
else
    echo -e $COL_RED' error'$COL_RESET
    echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
    rm -d -f -r /tmp/OpenSSLTool_errorMSG
    exit 1
fi

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Configurating source ...'
if
	cd openssl_i386
	./Configure darwin-i386-cc -shared --prefix=$prefix > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Building source ...'
if
	make > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

cd ../

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Configurating source ...'
if
	cd openssl_x86_64
	./Configure darwin64-x86_64-cc -shared --prefix=$prefix > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Building source ...'
if
	make > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Installing source ...'
if
	sudo make install -j $(sysctl -n hw.ncpu) > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

cd ../

cd $prefix
sudo patch -p0 < <(curl "https://raw.github.com/jeremymeile/jeremymeile/master/patches/opensslconf.patch")

sudo lipo -create ~/Downloads/openssl_i386/libcrypto.a ~/Downloads/openssl_x86_64/libcrypto.a -output $prefix/lib/libcrypto.a
sudo lipo -create ~/Downloads/openssl_i386/libssl.a ~/Downloads/openssl_x86_64/libssl.a -output $prefix/lib/libssl.a
sudo lipo -create ~/Downloads/openssl_i386/libssl.*.dylib ~/Downloads/openssl_x86_64/libssl.*.dylib -output $prefix/lib/libssl.1.0.0.dylib
sudo lipo -create ~/Downloads/openssl_i386/libcrypto.*.dylib ~/Downloads/openssl_x86_64/libcrypto.*.dylib -output $prefix/lib/libcrypto.1.0.0.dylib

