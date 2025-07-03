#!/bin/sh
#
dd if=/dev/zero of=/dev/ad0 bs=1k count=1
fdisk -BI ad0
bsdlabel -B -w ad0s1 auto #Label it
bsdlabel -e ad0s1 #Edit the label
mkdir -p /1
#newfs /dev/ad0s1e 
newfs -EUJj -o time -r 2 -O 2 /dev/ad0s1a  #Journaling, Erasing, time load optimized
mount /dev/ad0s1e /1
# Add it to your Fstab
boot0cfg -B -v ad0

