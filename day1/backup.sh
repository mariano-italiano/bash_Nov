#!/bin/bash

# Autor: Marcin Kujawski
# Version: 1.0
# Description: Script to perform backup for specified folder 
# Usage: ./backup.sh <dst_dir> <backup_dir>

LOGFILE="$HOME/logfile.log"
BACKUP_LOC=/usr/bin/*
BACKUP_DST="$HOME/backup"

function createBackupDir (){
	echo "Tworzenie katalogu $BACKUP_DST" && mkdir $BACKUP_DST 2>/dev/null || echo "Katalog już istnieje" 
}

createBackupDir

echo "Kopiowanie plików z $BACKUP_LOC do $BACKUP_DST..." && cp -rp $BACKUP_DST/* $BACKUP_LOC 1> $LOGFILE 2>&1 || echo "Przy kopiowaniu plików coś poszło nie tak"

