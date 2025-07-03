#!/bin/tcsh
# make release CHROOTDIR=/server PORTRELEASETAG=HEAD BUILDNAME=CURRENT_AMD64 RELEASETAG=RELENG_9_0
setenv chrootdir /server
setenv TARGET amd64
setenv TARGET_ARCH amd64
setenv MAKEOBJDIRPREFIX /server
make installworld DESTDIR=/server
make installkernel DESTDIR=/server KERNCONF=GENERIC INSTALL_NODEBUG=t
make distrib-dirs DESTDIR=/server
# make distribution DESTDIR=/server
# make install distribution DESTDIR=/server

	
