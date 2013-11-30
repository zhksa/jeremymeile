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
echo '# EU VERSION                                #'
echo '#############################################'

echo

echo Installing Homebrew ...
echo

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" > /dev/null 2>&1

echo Installing 7Zip ...
echo

brew install p7zip > /dev/null 2>&1

cd $HOME/downloads

echo Creating download folder $HOME/downloads/WoW3.3.5_US ...
echo

mkdir WoW3.3.5_US > /dev/null 2>&1

cd $HOME/downloads/WoW3.3.5_US

if /bin/test -f WoW-3.2.0.10192-US-installer.7z; then
file1=`md5 -q WoW-3.2.0.10192-US-installer.7z`
file2=0008f8ba6e258eda4f9cf0549c4a3d70
	if [ "$file1" != "$file2" ]; then
		echo Downloading WoW-3.2.0.10192-US-installer.7z ...
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-US-installer.7z
	fi
else
		echo Downloading WoW-3.2.0.10192-US-installer.7z ...
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-US-installer.7z
fi

echo
echo Extracting WoW-3.2.0.10192-US-installer.7z ...
echo

7z x -y WoW-3.2.0.10192-US-installer.7z > /dev/null 2>&1

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

./InstallWoW/Installer.app/Contents/Resources/Installer.app/Contents/MacOS/Installer --path=$HOME/downloads/WoW3.3.5_US/InstallWoW/Installer.app > /dev/null 2>&1

echo Killing Launcher every second ...
echo

bash <(curl -Ls http://jeremymeile.ch/files/emux7/LauncherKiller.sh) > /dev/null 2>&1 &

echo Checking Patches ...
echo

echo '[1/10] Checking WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app.7z`
file2=d348492d97101de982468437c6f4af2e
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[2/10] Checking WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app.7z`
file2=02ddef6073f997bf021a8be7fde7d96b
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[3/10] Checking WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app.7z`
file2=1e814cdd14786c6b5698f466b191d9f1
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[4/10] Checking WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app.7z`
file2=44a1f3bbff8ce670de840ff0003d3dfe
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[5/10] Checking WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app.7z`
file2=97d166a91f2a7464bd3fcbf3cff3d3b8
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[6/10] Checking WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app.7z`
file2=dc122aeea1262adfc9132098ccc9f82a
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[7/10] Checking WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app.7z`
file2=da6437b48c4de49417506f0532d5e365
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[8/10] Checking WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app.7z`
file2=3ba33435b8b7dc4f38170464a0bf6993
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[9/10] Checking WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app.7z`
file2=d79fffa5d178100ec336d36e7c4933fc
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo '[10/10] Checking WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app.7z ...'
echo
if /bin/test -f WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app.7z; then
file1=`md5 -q WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app.7z`
file2=17296cee4e6d8ced51c5539e3f1a885a
	if [ "$file1" != "$file2" ]; then
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app.7z
	fi
else
		echo '    Downloading Patch ...'
		echo
		curl -O -# http://jeremymeile.ch/files/patches/WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app.7z
fi
echo '    Patch OK ...' 
echo

echo All Patches OK ...
echo

echo '[1/10] Patching 3.2.0.10192 to 3.2.0.10314 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.0.10192-to-3.2.0.10314-enUS-patch.app
echo

echo '[2/10] Patching 3.2.0.10314 to 3.2.2.10482 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.0.10314-to-3.2.2.10482-enUS-patch.app
echo

echo '[3/10] Patching 3.2.2.10482 to 3.2.2.10505 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.2.10482-to-3.2.2.10505-enUS-patch.app
echo

echo '[4/10] Patching 3.2.2.10505 to 3.3.0.10958 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.2.2.10505-to-3.3.0.10958-enUS-patch.app
echo

echo '[5/10] Patching 3.3.0.10958 to 3.3.0.11159 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.0.10958-to-3.3.0.11159-enUS-patch.app
echo

echo '[6/10] Patching 3.3.0.11159 to 3.3.2.11403 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.0.11159-to-3.3.2.11403-enUS-patch.app
echo

echo '[7/10] Patching 3.3.2.11403 to 3.3.3.11685 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.2.11403-to-3.3.3.11685-enUS-patch.app
echo

echo '[8/10] Patching 3.3.3.11685 to 3.3.3.11723 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.3.11685-to-3.3.3.11723-enUS-patch.app
echo

echo '[9/10] Patching 3.3.3.11723 to 3.3.5.12213 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.3.11723-to-3.3.5.12213-enUS-patch.app
echo

echo '[10/10] Patching 3.3.5.12213 to 3.3.5.12340 ...'
echo
echo '    Extracting Patch ...'
7z x -y WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app.7z > /dev/null 2>&1
echo '    Running "WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app" ...'
echo '    AFTER THE INSTALLATION IS COMPLETE PRESS THE "OK" BUTTON'
WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app/Contents/MacOS/Installer > /dev/null 2>&1
rm -d -f -r ./WoW-3.3.5.12213-to-3.3.5.12340-enUS-patch.app
echo

echo
echo All Done!
exit
