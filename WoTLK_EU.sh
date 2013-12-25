#!/bin/bash
#############################################
# AUTHOR: JEREMY MEILE		           	    #
# JEREMYMEILE.CH                            #
# VERSION 2.0 ME RELEASE DATE AUG 10 2013   #
# DESC:  THIS SCRIPT INSTALLS WOW 3.3.5     #
#############################################
#REQUIREMENTS:
#  OS X 10.6 or newer
#############################################

echo 

echo '#############################################'
echo '# AUTHOR: JEREMY MEILE                      #'
echo '# JEREMYMEILE.CH                            #'
echo '# WRATH OF THE LICH KING INSTALLER SCRIPT   #'
echo '# US/MX VERSION                             #'
echo '#############################################'

echo

echo Installing Homebrew ...
echo

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" > /dev/null 2>&1

echo Installing 7Zip ...
echo

brew install p7zip > /dev/null 2>&1

cd $HOME/downloads

echo Creating download folder $HOME/downloads/WoW3.3.5_EU ...
echo

mkdir WoW3.3.5_EU > /dev/null 2>&1

cd $HOME/downloads/WoW3.3.5_EU

if /bin/test -f WoW-3.2.0.10192-EU-installer.7z; then
file1=`md5 -q WoW-3.2.0.10192-EU-installer.7z`
file2=01414d4e06ae851829888fc2664b0ed1
	if [ "$file1" != "$file2" ]; then
		echo Downloading WoW-3.2.0.10192-EU-installer.7z ...
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-EU-installer.7z
	fi
else
		echo Downloading WoW-3.2.0.10192-EU-installer.7z ...
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-EU-installer.7z
fi

echo
echo Extracting WoW-3.2.0.10192-EU-installer.7z ...
echo

7z x -y WoW-3.2.0.10192-EU-installer.7z > /dev/null 2>&1

echo Running Installer.app ...
echo
echo '      ################################################################'
echo '      #                                                              #'
echo '      # AFTER THE INSTALLATION IS COMPLETE DO NOT CLOSE THE          #'
echo '      # INSTALLER, PRESS "PLAY WRATH OF THE LICH KING" INSTEAD       #'
echo '      # IF YOU NOT DO THIS, THE PATCHER IS NOT ABLE TO RUN CORRECTLY #'
echo '      #                                                              #'
echo '      ################################################################'
echo

./InstallWoW/Installer.app/Contents/Resources/Installer.app/Contents/MacOS/Installer --path=$HOME/downloads/WoW3.3.5_EU/InstallWoW/Installer.app > /dev/null 2>&1

echo Killing Launcher every second ...
echo

bash <(curl -Ls http://jeremymeile.ch/files/emux7/LauncherKiller.sh) > /dev/null 2>&1 &

echo Checking Patches ...
echo

echo '[1/10] Checking WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app.7z`
file2=a1d989675e3b871e8ef9295c071527f8
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[2/10] Checking WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app.7z`
file2=05097213c30c7b0daa3298a743991dfc
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[3/10] Checking WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app.7z`
file2=3f91b9c8b3fc1719e09786a9d5a04eb5
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[4/10] Checking WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app.7z`
file2=feba53b8ce508f73e87a7909510d4bbe
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[5/10] Checking WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app.7z`
file2=99a6a0914f430908894c5efa1706bb79
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[6/10] Checking WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app.7z`
file2=fdc0641f9bcdf7bfefeb56d0302ac7d1
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[7/10] Checking WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app.7z`
file2=b7f2ff5f0af0b1ca193454bbceb8a324
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[8/10] Checking WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app.7z; then
file1=`md5 -q WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app.7z`
file2=c97013c8a097bd931b15bfef63fe61f2
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[9/10] Checking WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app.7z; then
file1=`md5 -q WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app.7z`
file2=9e0e61b4a2c72b66b8c6fbad83ed66c6
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[10/10] Checking WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app.7z; then
file1=`md5 -q WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app.7z`
file2=857602bdc40b91656f7bb3e529261eac
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo All Patches OK ...
echo

echo '[1/10] Patching 3.2.0.10192 to 3.2.0.10314 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.0.10192-to-3.2.0.10314-enGB-patch.app
echo

echo '[2/10] Patching 3.2.0.10314 to 3.2.2.10482 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.0.10314-to-3.2.2.10482-enGB-patch.app
echo

echo '[3/10] Patching 3.2.2.10482 to 3.2.2.10505 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.2.10482-to-3.2.2.10505-enGB-patch.app
echo

echo '[4/10] Patching 3.2.2.10505 to 3.3.0.10958 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.2.10505-to-3.3.0.10958-enGB-patch.app
echo

echo '[5/10] Patching 3.3.0.10958 to 3.3.0.11159 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.0.10958-to-3.3.0.11159-enGB-patch.app
echo

echo '[6/10] Patching 3.3.0.11159 to 3.3.2.11403 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.0.11159-to-3.3.2.11403-enGB-patch.app
echo

echo '[7/10] Patching 3.3.2.11403 to 3.3.3.11685 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.2.11403-to-3.3.3.11685-enGB-patch.app
echo

echo '[8/10] Patching 3.3.3.11685 to 3.3.3.11723 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.3.11685-to-3.3.3.11723-enGB-patch.app
echo

echo '[9/10] Patching 3.3.3.11723 to 3.3.5.12213 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.3.11723-to-3.3.5.12213-frFR-patch.app
echo

echo '[10/10] Patching 3.3.5.12213 to 3.3.5.12340 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.5.12213-to-3.3.5.12340-frFR-patch.app
echo

echo
echo All Done!
exit
