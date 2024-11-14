#!/bin/bash

# Autor: Marcin Kujawski
# Version: 1.0
# Description: Script to perform backup for specified folder 
# Usage: ./backup.sh <dst_dir> <backup_dir>

while getopts "f:s:d:" opt 
do
	case "${opt}" in
		f) LOGFILE=${OPTARG};;	
		s) BACKUP_LOC=${OPTARG};;	
		d) BACKUP_DST=${OPTARG};;	
	esac
done

if [ $# -eq 6 ] ; then

	DATE=$(date +"%d%m%Y-%H%M")
	LOGFILE=${LOGFILE:-$HOME/logfile_$DATE.log}
	function createBackupDir (){
		echo "Tworzenie katalogu $BACKUP_DST" && mkdir $BACKUP_DST 2>/dev/null || echo "Katalog już istnieje" 
	}
	
	createBackupDir
	
	echo "Kopiowanie plików z $BACKUP_LOC do $BACKUP_DST..." && cp -rp $BACKUP_LOC/* $BACKUP_DST 1> $LOGFILE 2>&1 || echo "Przy kopiowaniu plików coś poszło nie tak"
else
	echo
	echo "Usage: $0 -f <logfile> -s <backup_src> -d <backup_dst>"
	exit 0 	
	echo
fi

