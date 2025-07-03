#!/bin/sh
#
#portsupdate -af
#pkgdb -aFOfu
#freebsd-update fetch
#cvsup -g -L 2 /opt/cvsup
#
setenv MAKEOBJDIRPREFIX /release
setenv TARGET i386
setenv TARGET_ARCH i386
setenv TARGET_CPUTYPE armv6 #i386
# chflags -R noschg /usr/obj
# Configure /etc/make.conf
make -j2 -O2 buildworld
# WITHOUT_MODULES=linux sound acpi ntfs etc
# NO_MODULES=t
# NO_BIND=t
# MODULES_WITH_WORLD=yes
# NO_CVS=t
# NO_CXX=t
# NO_FORTRAN=t
# NO_GDB=t
# NO_DOCUPDATE=t
# NO_PORTSUPDATE=t
# NO_WWWUPDATE=t
# MODULES_OVERRIDE=sound acpi ntfs
# -DNO_CLEAN all
# -DNO_PROFILE=t
# NO_SHARE=t
# MALLOC_PRODUCTION=t
# MALLOC_PRODUCTION=yes  #ARMV6
# WITH_FDT=yes  #ARMV6
# NO_MAN=t
make -j2 -O2 buildkernel KERNCONF=R9_i386 MODULES_WITH_WORLD=false
pause
make installworld DESTDIR=/1
make instalkernel DESTDIR=/1 KERNCONF=GENERIC INSTALL_NODEBUG=t

pause
make distrib-dirs DESTDIR=/1
make distribution DESTDIR=/1
#make release RELEASETAG=R9 PORTSRELEASETAG=HEAD BUILDNAME=R9-INTEL-MP 
CHROOTDIR=/1

#install -c -o root -g wheel -m 555 /usr/src/etc/MAKEDEV.local 
# /usr/src/etc/MAKEDEV /2/dev
cp -av /dev /2
pause
echo "/dev/ad0s1	/ ufs rw	1 1" >/1/etc/fstab
echo "ifconfig_DEFAULT=DHCP" > /1/etc/rc.conf
echo "hostname=cauldron" >> /1/etc/rc.conf
