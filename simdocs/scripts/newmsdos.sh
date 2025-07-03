#!/bin/sh
fdisk -I /dev/da0
newfs_msdos /dev/da0

