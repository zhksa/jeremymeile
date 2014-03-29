#!/bin/bash 
INSTALL_PATH="/usr/local"
cd ~/Downloads
rm -d -f -r gmp-5.1.3
rm -d -f -r gmp-5.1.3.tar.bz2
curl -O ftp://ftp.gmplib.org/pub/gmp/gmp-5.1.3.tar.bz2
tar -jxvf gmp-5.1.3.tar.bz2
cd gmp-5.1.3
mkdir build
cd build
export DEPLOYMENT_TARGET=10.8
export OSX_SDK="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export MACOSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
#export CC="/gcc/bin/gcc"
#export CXX="/gcc/bin/c++"
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
export DEPLOYMENT_TARGET=10.8
export OSX_SDK="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export MACOSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
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
export DEPLOYMENT_TARGET=10.8
export OSX_SDK="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export MACOSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
../configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --with-mpfr=$INSTALL_PATH
make -j $(sysctl -n hw.ncpu)
make install

cd ~/Downloads
rm -d -f -r gcc-4.7.3
rm -d -f -r gcc-4.7.3.tar.bz2
curl -O http://gcc-uk.internet.bs/releases/gcc-4.7.3/gcc-4.7.3.tar.bz2
tar -jxvf gcc-4.7.3.tar.bz2
cd gcc-4.7.3
rm -d -f -r build
mkdir build
cd build
export DEPLOYMENT_TARGET=10.8
export OSX_SDK="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
export MACOSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk"
../configure --enable-checking=release --program-suffix=-4.7 --enable-checking=release --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --with-mpfr=$INSTALL_PATH --with-mpc=$INSTALL_PATH
make -j $(sysctl -n hw.ncpu)
make install
../configure --enable-checking=release --program-suffix=-4.7 --enable-languages=c,c++,fortran,clang --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --with-mpfr=$INSTALL_PATH --with-mpc=$INSTALL_PATH
make -j $(sysctl -n hw.ncpu)
make install > /dev/null
