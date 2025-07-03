#!/bin/sh
# FreeBSD automake world
# Remember to setenv ARCH amd64
export kernel_source=/usr/src

#export MAKEOBJDIRPREFIX=/release
export dst=/media/data
export K=R9
export newfs_opts=-UJj
export fdisk_opts=-BI
export newfs_dev=/dev/da0

# TARGET
if [ $ARCH == "amd64" ];
then
export TARGET=amd64
export TARGET_ARCH=amd64
fi

if [ $ARCH == "i386" ];
then
export TARGET=i386
export TARGET_ARCH=i386
fi

if [ $ARCH == "arm" ];
then
export TARGET=arm
export TARGET_ARCH=arm
# set TARGET_CPUTYPE=armv6
fi

if [ -n $ARCH ];
then
export ARCH=$(uname -m)
export TARGET=$ARCH
export TARGET_ARCH=$ARCH
fi


cd ${kernel_source}

if [ $1 == "kernel" ];
then
nice make -j2 buildkernel KERNCONF=$K KERNEL=$K
fi

if [ $1 == "installkernel" ];
then
nice make installkernel INSTALL_NODEBUG=true KERNCONF=$K DESTDIR=$dst
fi

if [ $1 == "world" ];
then 
nice make -j2 buildworld
fi

if [ $1 == "installworld" ];
then
nice make installworld DESTDIR=$dst
fi

if [ $1 == "clean" ];
then
nice make cleanworld cleandir cleandepend
fi

if [ $1 == "fdisk" ];
then
umount $dst >/dev/null
fdisk $fdisk_opts $newfs_dev
fi

if [ $1 == "format" ];
then
newfs $newfs_opts ${newfs_dev}s1a
mount ${newfs_dev}s1a $dst
fi
