#!/bin/bash
#
#Init development environment for linux 0.11.
#
#Copyright 2020.03.18 Vincent Zhu

APP='vim build-essential bin86 git'

# Check Distribution is Ubuntu
OS=`cat /etc/os-release | grep '^ID=' | cut -d\" -f2`
[ $OS != 'ubuntu' ] && echo -e \
"\e[0;31mError: This script can only run on ubuntu!\e[0m" && exit 1

# Do detail staff.
sudo apt-get update

for x in ${APP} ;
do
	sudo apt-get install -y $x
done


# Install gcc-3.4
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/gcc-3.4-base_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./gcc-3.4-base_3.4.6-6ubuntu3_amd64.deb

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/gcc-3.4_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./gcc-3.4_3.4.6-6ubuntu3_amd64.deb 

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/cpp-3.4_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./cpp-3.4_3.4.6-6ubuntu3_amd64.deb 

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/g++-3.4_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./g++-3.4_3.4.6-6ubuntu3_amd64.deb

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/libstdc++6-dev_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./libstdc++6-dev_3.4.6-6ubuntu3_amd64.deb

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/g77-3.4_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./g77-3.4_3.4.6-6ubuntu3_amd64.deb

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/libg2c0_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./libg2c0_3.4.6-6ubuntu3_amd64.deb

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/libg2c0-dev_3.4.6-6ubuntu3_amd64.deb
sudo dpkg --force-depends -i ./libg2c0-dev_3.4.6-6ubuntu3_amd64.deb

rm -rf ./*3.4*_amd64.deb*

# Solve problem:
# /usr/include/features.h:367:25: fatal error: sys/cdefs.h: No such file or directory

sudo apt-get install -y gcc-multilib
sudo apt-get install -y g++-multilib

# Solve problem:
# libSM.so.6: cannot open shared object file: No such file or directory
sudo apt-get install -y libsm6:i386
sudo apt-get install -y libx11-6:i386
sudo apt-get install -y libxpm4:i386

# Solve gdb error
sudo apt-get install -y libncurses5:i386
sudo apt-get install -y libexpat1:i386




