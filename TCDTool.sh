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

CMAKE_VER='2.8.12.2'
GIT_VER='1.8.4.2'
ACE_VER='6.2.5'
READLINE_VER='6.3'
OPENSSL_VERSION="1.0.1f"
echo
printf '%b\n' " ______"
printf '%b\n' "/\\____ \\    ___   _ __    ___     ___  __   __  __"
printf '%b\n' "\\/___/\\ \\ /' <>\`\\/\\\`'__\\/' <>\`\\ /' _ \`' _\`\\/\\ \\/\\ \\ "
printf '%b\n' "    _\\ \\ \\/\\  ___\\ \\ \\/ /\\  ___\\/\\ \\/\\ \\/\\ \\ \\ \\_\\ \\ "
printf '%b\n' "   /\\ \\_\\ \\ \\ \\__/\\ \\_\\ \\ \\ \\__/\\ \\_\\ \\_\\ \\_\\/\`____ \\"
printf '%b\n' "   \\ \\_____\\/\`____/\\ \\_\\ \\/\`____/\\ \\_\\ \\_\\ \\_\\/___/> \\ "
printf '%b\n' "    \`/____/ \`/___/  \\/_/  \`/___/  \\/_/\\/_/\\/_/  /\\___/ "
printf '%b\n' "  http://jeremymeile.ch             M E I L E   \\/__/ "
echo
echo -e  'TrinityCore Dependency Tool '$COL_BLUE'[TCDtool]'$COL_RESET''
echo -e  'Gives you all the necessary Open Source Tools for TrinityCore.'
echo -e  'Everything will be installed to /usr/local.'

    if [ $(sw_vers -productVersion | cut -c 1-4) = "10.3" ]
    then
    	echo
		echo -e  $COL_RED'[OSX 10.6 or higher is required!]'$COL_RESET''
		exit 1
    fi
    if [ $(sw_vers -productVersion | cut -c 1-4) = "10.4" ]
    then
    	echo
		echo -e  $COL_RED'[OSX 10.6 or higher is required!]'$COL_RESET''
		exit 1
    fi
    if [ $(sw_vers -productVersion | cut -c 1-4) = "10.5" ]
    then
    	echo
		echo -e  $COL_RED'[OSX 10.6 or higher is required!]'$COL_RESET''
		exit 1
    fi
echo
if
    sudo -v
then
    echo
else
    exit
fi
echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Looking for headers ...'
if [[ -d /usr/include ]]
then
    echo -e $COL_GREEN' OK'$COL_RESET
else
    echo -e $COL_RED' Not found, running "xcode-select --install"'$COL_RESET
    xcode-select --install
    exit 1
fi
f=$(xcode-select --print-path)
show_error(){
    echo -e $COL_RED' failed'$COL_RESET
    echo -e $COL_RED'    error '$COL_WHITE$(/bin/cat /tmp/TCDtool_errorMSG)$COL_RESET
    rm -d -f -r /tmp/TCDtool_errorMSG
    return 1
    echo
}
GetAce(){
echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Downloading "'$COL_MAGENTA'ace' ${ACE_VER}$COL_RESET'" ...'
    if
        cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r ACE-${ACE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r ACE_wrappers > /dev/null 2>/tmp/TCDtool_errorMSG
        curl -O -s http://download.dre.vanderbilt.edu/previous_versions/ACE-${ACE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
    then
        echo -e $COL_GREEN' OK'$COL_RESET
        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Extracting "'$COL_MAGENTA'ace' ${ACE_VER}$COL_RESET'" ...'
            if
                cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
                tar -xjf ACE-${ACE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
            then
                echo -e $COL_GREEN' OK'$COL_RESET
                echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Building "'$COL_MAGENTA'ace' ${ACE_VER}$COL_RESET'" ...'
                    if
                        cd ~/Downloads/ACE_wrappers > /dev/null 2>/tmp/TCDtool_errorMSG
    if [ $(sw_vers -productVersion | cut -c 1-4) = "10.9" ]
    then
        osx="mountainlion"
            export MACOSX_DEPLOYMENT_TARGET=10.8
            export DEPLOYMENT_TARGET=10.8
            export OSX_SDK="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
            export OSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
            export MACOSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
            export CFLAGS="-mmacosx-version-min=10.8 -isysroot $f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
            export CXXFLAGS="-mmacosx-version-min=10.8 -isysroot $f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
    fi
    if [ $(sw_vers -productVersion | cut -c 1-4) = "10.8" ]
    then
        osx="mountainlion"
            export MACOSX_DEPLOYMENT_TARGET=10.8
            export DEPLOYMENT_TARGET=10.8
    fi
    if [ $(sw_vers -productVersion | cut -c 1-4) = "10.7" ]
    then
        osx="lion"
            export MACOSX_DEPLOYMENT_TARGET=10.7
            export DEPLOYMENT_TARGET=10.7
    fi
    if [ $(sw_vers -productVersion | cut -c 1-4) = "10.6" ]
    then
        osx="snowleopard"
            export MACOSX_DEPLOYMENT_TARGET=10.6
            export DEPLOYMENT_TARGET=10.6
    fi
                        echo 'export ACE_ROOT=$(pwd)' > bash_profile
                        echo 'export ACE_ROOT=$ACE_ROOT' >> bash_profile
                        echo 'export PATH=$ACE_ROOT/bin:$PATH' >> bash_profile
                        echo 'export DYLD_LIBRARY_PATH=$ACE_ROOT/lib' >> bash_profile
                        source bash_profile
                        echo '#include "ace/config-macosx-'$osx'.h"' > ./ace/config.h
                        echo 'debug = 0' > ./include/makeinclude/platform_macros.GNU
                        echo 'shared_libs = 1' >> ./include/makeinclude/platform_macros.GNU
                        echo 'static_libs = 1' >> ./include/makeinclude/platform_macros.GNU
                        echo 'install_rpath = 0' >> ./include/makeinclude/platform_macros.GNU
                        echo 'include ${ACE_ROOT}/include/makeinclude/platform_macosx_'$osx'.GNU' >> ./include/makeinclude/platform_macros.GNU
                        echo 'INSTALL_PREFIX = /usr/local' >> ./include/makeinclude/platform_macros.GNU
                        cd ~/Downloads/ACE_wrappers/ace
                        patch -s -f -p0 < <(curl -s https://raw.github.com/jeremymeile/jeremymeile/master/ace_ACE.patch) 2>/tmp/TCDtool_errorMSG
                        make -j $(sysctl -n hw.ncpu) > /dev/null 2>/tmp/TCDtool_errorMSG
                    then
                        echo -e $COL_GREEN' OK'$COL_RESET
                        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Installing "'$COL_MAGENTA'ace' ${ACE_VER}$COL_RESET'" ...'
                            if
                                sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }
                                sudo ACE_ROOT=$ACE_ROOT make install > /dev/null 2>/tmp/TCDtool_errorMSG
                                cat /usr/local/include/ace/config-macosx-leopard.h | sed -n '/if defined(__APPLE_CC__) && (__APPLE_CC__ < 1173)/!p' | sed -n '/Compiler must be upgraded/!p' | sed -n '/ __APPLE_CC__ /!p' > /tmp/config-macosx-leopard.h
                        		sudo cp /tmp/config-macosx-leopard.h /usr/local/include/ace/config-macosx-leopard.h
                            then
                                echo -e $COL_GREEN' OK'$COL_RESET
                                return 0
                            else
                                show_error
                                return 1
                            fi      
                    else
                        show_error
                        return 1
                    fi  
            else
                show_error
                return 1
            fi
    else
        show_error
        return 1
    fi                      
}
GetReadline(){
echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Downloading "'$COL_MAGENTA'readline' ${READLINE_VER}$COL_RESET'" ...'
    if
        cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r readline-${READLINE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r readline-${READLINE_VER} > /dev/null 2>/tmp/TCDtool_errorMSG
        curl -O -s ftp://ftp.cwru.edu/pub/bash/readline-${READLINE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
    then
        echo -e $COL_GREEN' OK'$COL_RESET
        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Extracting "'$COL_MAGENTA'readline' ${READLINE_VER}$COL_RESET'" ...'
            if
                cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
                tar -xjf readline-${READLINE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
            then
                echo -e $COL_GREEN' OK'$COL_RESET
                echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Building "'$COL_MAGENTA'readline' ${READLINE_VER}$COL_RESET'" ...'
                    if
                        cd readline-${READLINE_VER}
                        mkdir -p build
                        cd build
                        ../configure --enable-multibyte --enable-static --enable-shared > /dev/null 2>/tmp/TCDtool_errorMSG
                        make -j $(sysctl -n hw.ncpu) > /dev/null 2>/tmp/TCDtool_errorMSG
                    then
                        echo -e $COL_GREEN' OK'$COL_RESET
                        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Installing "'$COL_MAGENTA'readline' ${READLINE_VER}$COL_RESET'" ...'
                            if
                                sudo make install > /dev/null 2>/tmp/TCDtool_errorMSG
                            then
                                echo -e $COL_GREEN' OK'$COL_RESET
                                return 0
                            else
                                show_error
                                return 1
                            fi      
                    else
                        show_error
                        return 1
                    fi  
            else
                show_error
                return 1
            fi
    else
        show_error
        return 1
    fi                      
}
GetCMake(){
echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Downloading "'$COL_MAGENTA'cmake' ${CMAKE_VER}$COL_RESET'" ...'
    if
        cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r cmake-${CMAKE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r cmake-${CMAKE_VER} > /dev/null 2>/tmp/TCDtool_errorMSG
        curl -O -s http://www.cmake.org/files/v2.8/cmake-${CMAKE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
    then
        echo -e $COL_GREEN' OK'$COL_RESET
        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Extracting "'$COL_MAGENTA'cmake' ${CMAKE_VER}$COL_RESET'" ...'
            if
                cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
                tar -xjf cmake-${CMAKE_VER}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
            then
                echo -e $COL_GREEN' OK'$COL_RESET
                echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Building "'$COL_MAGENTA'cmake' ${CMAKE_VER}$COL_RESET'" ...'
                    if
                        cd ~/Downloads/cmake-${CMAKE_VER} > /dev/null 2>/tmp/TCDtool_errorMSG
						./bootstrap > /dev/null 2>/tmp/TCDtool_errorMSG
                        make -j $(sysctl -n hw.ncpu) > /dev/null 2>/tmp/TCDtool_errorMSG
                    then
                        echo -e $COL_GREEN' OK'$COL_RESET
                        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Installing "'$COL_MAGENTA'cmake' ${CMAKE_VER}$COL_RESET'" ...'
                            if
                                sudo sudo make install > /dev/null 2>/tmp/TCDtool_errorMSG
                            then
                                echo -e $COL_GREEN' OK'$COL_RESET
                                return 0
                            else
                                show_error
                                return 1
                            fi      
                    else
                        show_error
                        return 1
                    fi  
            else
                show_error
                return 1
            fi
    else
        show_error
        return 1
    fi                      
}
GetGit(){
echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Downloading "'$COL_MAGENTA'git' ${GIT_VER}$COL_RESET'" ...'
    if
        cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r git-${GIT_VER}-intel-universal-snow-leopard.dmg > /dev/null 2>/tmp/TCDtool_errorMSG
        curl -O -s https://git-osx-installer.googlecode.com/files/git-${GIT_VER}-intel-universal-snow-leopard.dmg > /dev/null 2>/tmp/TCDtool_errorMSG
    then
        echo -e $COL_GREEN' OK'$COL_RESET
        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Extracting "'$COL_MAGENTA'git' ${GIT_VER}$COL_RESET'" ...'
            if
                hdiutil attach -quiet ~/Downloads/git-${GIT_VER}-intel-universal-snow-leopard.dmg > /dev/null 2>/tmp/TCDtool_errorMSG
            then
                echo -e $COL_GREEN' OK'$COL_RESET
                echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Installing "'$COL_MAGENTA'git' ${GIT_VER}$COL_RESET'" ...'
                    if
                        sudo installer -pkg /Volumes/Git\ ${GIT_VER}\ Snow\ Leopard\ Intel\ Universal/git-${GIT_VER}-intel-universal-snow-leopard.pkg -target / > /dev/null 2>/tmp/TCDtool_errorMSG
                        hdiutil detach -quiet /Volumes/Git\ ${GIT_VER}\ Snow\ Leopard\ Intel\ Universal > /dev/null 2>/tmp/TCDtool_errorMSG
                    then
                        echo -e $COL_GREEN' OK'$COL_RESET
                    else
                        show_error
                        return 1
                    fi  
            else
                show_error
                return 1
            fi
    else
        show_error
        return 1
    fi                      
}
GetOpenSSL(){
echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Downloading "'$COL_MAGENTA'openssl' ${OPENSSL_VERSION}$COL_RESET'" ...'
    if
        cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r openssl-${OPENSSL_VERSION} > /dev/null 2>/tmp/TCDtool_errorMSG
        rm -d -f -r openssl-${OPENSSL_VERSION}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
        curl -O -s http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
    then
        echo -e $COL_GREEN' OK'$COL_RESET
        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Extracting "'$COL_MAGENTA'openssl' ${OPENSSL_VERSION}$COL_RESET'" ...'
            if
                cd ~/Downloads > /dev/null 2>/tmp/TCDtool_errorMSG
                tar -xjf openssl-${OPENSSL_VERSION}.tar.gz > /dev/null 2>/tmp/TCDtool_errorMSG
            then
                echo -e $COL_GREEN' OK'$COL_RESET
                echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Building "'$COL_MAGENTA'openssl' ${OPENSSL_VERSION}$COL_RESET'" ...'
                    if
                        cd ~/Downloads/openssl-${OPENSSL_VERSION} > /dev/null 2>/tmp/TCDtool_errorMSG
                		./Configure --prefix=/usr/local --openssldir=/usr/local darwin64-x86_64-cc enable-ec_nistp_64_gcc_128 shared zlib-dynamic enable-cms > /dev/null 2>/tmp/TCDtool_errorMSG
                    	make depend > /dev/null 2>/tmp/TCDtool_errorMSG
                    	make > /dev/null 2>/tmp/TCDtool_errorMSG
						make test > /dev/null 2>/tmp/TCDtool_errorMSG
                    then
                        echo -e $COL_GREEN' OK'$COL_RESET
                        echo -ne $COL_BLUE'[TCDtool] '$COL_RESET'Installing "'$COL_MAGENTA'openssl' ${OPENSSL_VERSION}$COL_RESET'" ...'
                            if
                                sudo make install > /dev/null 2>/tmp/TCDtool_errorMSG
                            then
                                echo -e $COL_GREEN' OK'$COL_RESET
                                return 0
                            else
                                show_error
                                return 1
                            fi      
                    else
                        show_error
                        return 1
                    fi  
            else
                show_error
                return 1
            fi
    else
        show_error
        return 1
    fi                      
}
GetAce
GetCMake
GetOpenSSL
GetReadline
GetGit