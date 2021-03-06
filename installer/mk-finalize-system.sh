#!/bin/bash
#################################################
#       Title:  mk-finalize-system              #
#        Date:  2014-11-26                      #
#     Version:  1.0                             #
#      Author:  mbassiouny@vmware.com           #
#     Options:                                  #
#################################################
#	Overview
#		Finalize the system after the installation
#	End
#
set -o errexit		# exit if error...insurance ;
set -o nounset		# exit if variable not initalized
set +h			# disable hashall
source config.inc
source function.inc
PRGNAME=${0##*/}	# script name minus the path
LOGFILE=/var/log/"${PRGNAME}-${LOGFILE}"	#	set log file name
#LOGFILE=/dev/null		#	uncomment to disable log file
[ ${EUID} -eq 0 ] 	|| fail "${PRGNAME}: Need to be root user: FAILURE"

/sbin/ldconfig
/usr/sbin/pwconv
/usr/sbin/grpconv
/bin/systemd-machine-id-setup
/usr/bin/touch /etc/locale.conf
/bin/echo "LANG=en_US.UTF-8" > /etc/locale.conf


# Importing the pubkey
rpm --import /etc/pki/rpm-gpg/*

#TODO: This should be removed, systemd should be able to create this file
/usr/bin/touch /var/run/utmp
#/sbin/locale-gen.sh
exit 0
