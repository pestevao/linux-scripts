#!/bin/sh
# set -x
# Shell script to monitor or watch the disk space
# It will send an email to $ADMIN, if the (free available) percentage of space is >= ALERT%.
# -------------------------------------------------------------------------
# Set admin email so that you can get email.
ADMIN="admin1@example.com"
ADMIN_CC="admin2@example.com"
# set alert level 90% is default
ALERT=90
# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="devtmpfs|/auto/ripper|udev|proc"
#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
function main_prog() {
	while read output;
	do
		usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
		partition=$(echo $output | awk '{print $2}')
		if [ $usep -ge $ALERT ] ; then
			echo "ALERTA
----------

The partition \"$partition\" on the machine $(/usr/sbin/ifconfig | awk -F':' '/inet addr/&&!/127.0.0.1/{split($2,_," ");print _[1]}') - $(hostname) is running out of disk space.

At $(date +%Y-%m-%d) $(date +%H:%M) it was using $usep% of disk space.

FS TREE
====================

$(du -xb $partition | sort -rn | head -n 25 | numfmt --to=iec)

====================

Thank you." | \
			mail -r "sender@example.com" -s "ALERT $(hostname) - $usep% usage at $partition ($(date +%Y-%m-%d) $(date +%H:%M))" -c "$ADMIN_CC" $ADMIN
			# SUCESSFULLY GENERATED ALERT MAIL
		fi
	done
}

if [ "$EXCLUDE_LIST" != "" ] ; then
	df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
	df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi
