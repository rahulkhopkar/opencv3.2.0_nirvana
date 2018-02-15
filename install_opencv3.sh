#!/bin/bash
# This is to install opencv3.2.0 on Ubuntu 16.04 LTS (Debian 8.8)
# Create a directory where you want the source code of opencv3.2.0 to reside, say your home directory ($ cd ~/)
# Update your Linux
sudo apt-get -y update
sudo apt-get -y upgrade
# -y option automatically answers "Yes" (for example, when a command asks "Y/n"? Press y to continue, n to stop)

#Install java
#sudo apt-get install -y ant default-jdk

#Install "cmake" and "build-essential" packages (tools) required to install opencv
#"cmake" helps you compile, build and run source code
#"git" is a popular version control tool, should be a part of standard Linux distribution
#"pkg-config" a helper tool used when compiling applications and libraries https://www.freedesktop.org/wiki/Software/pkg-config/
sudo apt-get install -y cmake build-essential #VERIFIED 20180202
#sudo apt-get install cmake build-essential

#To install Python 2.x replace "python3" by "python2"
#"dpkg-dev" installs Debian package development tools
#"gcc" installs GNU C compiler
#"g++" installs GNU C++ compiler
#"python3" installs python3
#"python3-numpy" installs the Numerical Python library
#"python3-scipy" installs Scientific python library
#"python3-matplotlib" installs matplotlib package for plotting
#"python3-dev" contains the header files needed to build Python extensions
#"python3-tk" installs Python's Tkinter GUI package built on Tcl/Tk
#"gfortran" installs GNU FORTRAN
#"libatlas-base-dev" installs GNU Linear Algebra Libraries"
sudo apt-get install -y dpkg-dev gcc g++ python3 python3-numpy python3-scipy python3-matplotlib python3-dev python3-tk gfortran libatlas-base-dev #VERIFIED 20170202
#sudo apt-get install dpkg-dev gcc g++ python3 python3-numpy python3-scipy python3-matplotlib python3-dev python3-tk gfortran libatlas-base-dev

#Install Dependencies
sudo apt-get install -y libtiff5 libpng12-dev libjpeg8-dev libjasper-dev #VERIFIED 20180202
#sudo apt-get install libtiff5 libpng12-dev libjpeg8-dev libjasper-dev


#Install Video libraries:
sudo apt-get install -y libavformat-dev libv4l-dev libswscale-dev libavcodec-dev libgtk2.0-dev
sudo apt-get install libavformat-dev libv4l-dev libswscale-dev libavcodec-dev libgtk2.0-dev ffmpeg


#Git Clone Additional Contributions in your current directory:
#VERIFIED 20180202

git clone https://github.com/opencv/opencv_contrib
cd opencv_contrib/
git checkout 3.2.0
cd ../

#Clone opencv 3.2.0 in your home directory (or wherever you want)
git clone https://github.com/opencv/opencv
cd opencv
git checkout 3.2.0
mkdir build
cd build

#Run this command only after you replace the ~/opencv/cmake/OpenCVCompilerOptions.cmake file with the one provided
#Delete line number 21 in this file as it has a "double else" in the "if block"

cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON - D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules -D WITH_OPENGL=ON -D WITH_QT=ON -D WITH_XINE=ON -D WITH_TBB=ON -D WITH_GDAL=ON -D FORCE_VTK=ON .. 2>&1 | tee ../opencv-3.2.0_cmake_log.txt

make -j8 2>&1 | tee ../opencv-3.2.0_make_log.txt

sudo make install 2>&1 | tee ../opencv-3.2.0_make_install_log.txt
sudo ldconfig

