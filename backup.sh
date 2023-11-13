#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Data: 	13.11.2023
# Wersja: 	v1.0.0
# Changelog
# 13.11.2023 - Pierwsza wersja skryptu

# Definicja zmiennych
#LOGDIR="/home/$USER"
LOGFILE="backup_$(date +"%Y%m%d-%H%M%S").log"
BACKUP_SRC="/usr/bin/*"
BACKUP_DST="/home/$USER/backup"

function init {

	read -p "Podaj nazwe katalogu gdzie ma byc zapisany log file: " LOGDIR
	# Informacja dla uzytkownika i tworzenie folderu
	echo "Tworzenie folderu backup" && mkdir $BACKUP_DST 2>/dev/null || echo "Katalog juz istnieje"

	# Informacja dla uzytkownika i kopiowanie
	echo "Kopiowanie plików..." && cp $BACKUP_SRC $BACKUP_DST > $LOGDIR/$LOGFILE 2>&1 || echo "Coś poszło nie tak z kopiowaniem, szczególy w pliku $LOGDIR/$LOGFILE"

}

function finish {
	echo
	echo "Program $1 zakonczył swoje działanie"
	echo
}


init
finish $0

exit 0
