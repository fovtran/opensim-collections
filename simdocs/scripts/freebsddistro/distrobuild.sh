#!/bin/tcsh
# make release CHROOTDIR=/server PORTRELEASETAG=HEAD BUILDNAME=CURRENT_AMD64 RELEASETAG=RELENG_9_0
setenv chrootdir /server
setenv TARGET amd64
setenv TARGET_ARCH amd64
setenv MAKEOBJDIRPREFIX /server

nice sh /usr/src/release/i386/mkisoimages.sh -b FreeBSD9 \
	/tmp/RELEASE_mini_AMD64.iso \
	/server \
	
