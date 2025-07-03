#!/bin/tcsh
# make release CHROOTDIR=/server PORTRELEASETAG=HEAD BUILDNAME=CURRENT_AMD64 RELEASETAG=RELENG_9_0
setenv chrootdir /server
setenv TARGET amd64
setenv TARGET_ARCH amd64
setenv MAKEOBJDIRPREFIX /server
make buildworld
make buildkernel KERNELCONF=GENERIC
make installworld DESTDIR=/server
make installkernel DESTDIR=/server KERNCONF=GENERIC INSTALL_NODEBUG=t
make distrib-dirs DESTDIR=/server
make distribution DESTDIR=/server
make install distribution DESTDIR=/server


cd /usr/src/release
nice make CHROOTDIR=${chrootdir} BUILDNAME=CURRENT_AMD64 NOPORTREADMES=yes NODOC=yes PORTSRELEASETAG=HEAD RELEASETAG=RELENG_9_0 LOCAL_PATCHES=/usr/src/patches CVSROOT=/usr/src


nice sh /usr/src/release/i386/mkisoimages.sh -b FreeBSD9 \
	/tmp/RELEASE_mini_AMD64.iso \
	/server \
	
