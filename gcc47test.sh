#!/bin/bash
if f=$(xcode-select --print-path)
then
echo
		if test -d $f'/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk'
		then
			export DEPLOYMENT_TARGET=10.6
			export OSX_SDK="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk"
			export OSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk"
			export MACOSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk"
		fi
		if test -d $f'/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk'
		then
			export DEPLOYMENT_TARGET=10.7
			export OSX_SDK="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk"
			export OSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk"
			export MACOSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk"
		fi
		if test -d $f'/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk'
		then
			export DEPLOYMENT_TARGET=10.8
			export OSX_SDK="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
			export OSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
			export MACOSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
			echo $f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk
		fi
		if test -d $f'/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk'
		then
			export DEPLOYMENT_TARGET=10.9
			export OSX_SDK="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
			export OSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
			export MACOSX_SYSROOT="$f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk"
			echo $f/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk
		fi
else
	echo -e 'Install and initialize XCode first!'
	exit 1
fi
echo 
INSTALL_PATH="/Applications/gcc47"
cd ~/Downloads
rm -d -f -r gmp-5.1.1
rm -d -f -r gmp-5.1.1.tar.bz2
curl -O ftp://ftp.gmplib.org/pub/gmp/gmp-5.1.1.tar.bz2
tar -jxvf gmp-5.1.1.tar.bz2
cd gmp-5.1.1
mkdir build
cd build
../configure --prefix=$INSTALL_PATH --enable-cxx
make -j $(sysctl -n hw.ncpu)
make install
cd ~/Downloads
rm -d -f -r mpfr-3.1.2
rm -d -f -r mpfr-3.1.2.tar.gz
curl -O http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.gz
tar -jxvf mpfr-3.1.2.tar.gz
cd mpfr-3.1.2
mkdir build
cd build
../configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH
make -j $(sysctl -n hw.ncpu)
make install
cd ~/Downloads
rm -d -f -r mpc-1.0.1
rm -d -f -r mpc-1.0.1.tar.gz
curl -O http://www.multiprecision.org/mpc/download/mpc-1.0.1.tar.gz
tar -jxvf mpc-1.0.1.tar.gz
cd mpc-1.0.1
mkdir build
cd build
../configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --with-mpfr=$INSTALL_PATH
make -j $(sysctl -n hw.ncpu)
make install
cd ~/Downloads
rm -d -f -r gcc-4.7.3
rm -d -f -r gcc-4.7.3.tar.bz2
curl -O http://gcc-uk.internet.bs/releases/gcc-4.7.3/gcc-4.7.3.tar.bz2 > /dev/null 2>/tmp/Acetool_errorMSG
tar -jxvf gcc-4.7.3.tar.bz2
cd gcc-4.7.3
mkdir build
cd build
../configure --enable-checking=release --program-suffix=-4.7 --enable-languages=c,c++,fortran --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --with-mpfr=$INSTALL_PATH --with-mpc=$INSTALL_PATH > /dev/null 2>/tmp/Acetool_errorMSG
make -j $(sysctl -n hw.ncpu)
make install > /dev/null