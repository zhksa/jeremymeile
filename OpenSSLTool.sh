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
cd $HOME/Downloads
#curl -O http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
rm -d -f -r openssl_i386
rm -d -f -r openssl_x86_64
tar -xvzf openssl-$OPENSSL_VERSION.tar.gz
mv openssl-$OPENSSL_VERSION openssl_i386
tar -xvzf openssl-$OPENSSL_VERSION.tar.gz
mv openssl-$OPENSSL_VERSION openssl_x86_64

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Configurating source ...'
if
	cd openssl_i386
	./Configure darwin-i386-cc -shared --prefix=/Applications/TClibs/openssl > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Compiling source ...'
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
	make MACOSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk" install -j $(sysctl -n hw.ncpu) > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

rm -d -f -r /Applications/TClibs/openssl_i386
mv /Applications/TClibs/openssl /Applications/TClibs/openssl_i386
cd ../

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Configurating source ...'
if
	cd openssl_x86_64
	./Configure darwin64-x86_64-cc -shared --prefix=/Applications/TClibs/openssl > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

echo -ne $COL_BLUE'[OpenSSLTool] '$COL_RESET'Compiling source ...'
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
	make install -j $(sysctl -n hw.ncpu) > /dev/null 2>/tmp/OpenSSLTool_errorMSG
then
	echo -e $COL_GREEN' OK'$COL_RESET
else
	echo -e $COL_RED' error'$COL_RESET
	echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/OpenSSLTool_errorMSG)$COL_RESET
	rm -d -f -r /tmp/OpenSSLTool_errorMSG
fi

rm -d -f -r /Applications/TClibs/openssl_x86_64
mv /Applications/TClibs/openssl /Applications/TClibs/openssl_x86_64
cd ../
mkdir /Applications/TClibs/openssl
mkdir /Applications/TClibs/openssl/lib
cp -r /Applications/TClibs/openssl_x86_64/include /Applications/TClibs/openssl

cd /Applications/TClibs/openssl
patch -p0 < /Users/jeremymeile/opensslconf.patch

lipo -create /Applications/TClibs/openssl_i386/lib/libcrypto.a /Applications/TClibs/openssl_x86_64/lib/libcrypto.a -output /Applications/TClibs/openssl/lib/libcrypto.a
lipo -create /Applications/TClibs/openssl_i386/lib/libssl.a /Applications/TClibs/openssl_x86_64/lib/libssl.a -output /Applications/TClibs/openssl/lib/libssl.a
lipo -create /Applications/TClibs/openssl_i386/lib/libssl.*.dylib /Applications/TClibs/openssl_x86_64/lib/libssl.*.dylib -output /Applications/TClibs/openssl/lib/libssl.dylib
lipo -create /Applications/TClibs/openssl_i386/lib/libcrypto.*.dylib /Applications/TClibs/openssl_x86_64/lib/libcrypto.*.dylib -output /Applications/TClibs/openssl/lib/libcrypto.dylib

rm -d -f -r /Applications/TClibs/openssl_i386
rm -d -f -r /Applications/TClibs/openssl_x86_64
