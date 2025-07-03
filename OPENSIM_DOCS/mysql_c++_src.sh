#!/bin/sh
#
export file=linux-2.6.37

if [ -d $file ]
then 
cd $file
./configure 
cd ..
else 
echo "Downloading Linux Kernel" $file
ftp ftp://ftp.oiram.net/pub/UNIX/FreeBSD/ports/distfiles/$file.tar.bz2
bzip2 -d $file.tar.gz
tar xvf $file.tar
rm $file.tar
fi


ftp://ftp1.be.proftpd.org/samba/pam_smb/pam_smb-1.1.7.tar.gz
ftp://ftp1.be.proftpd.org/mysql/Downloads/Connector-C++/mysql-connector-c++-1.0.5.tar.gz
ftp://ftp1.be.proftpd.org/mysql/Downloads/Connector-C/mysql-connector-c-6.0.2.tar.gz

