#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Data: 	13.11.2023
# Wersja: 	v1.0.0
# Changelog
# 13.11.2023 - Pierwsza wersja skryptu

while getopts "f:s:d:" param
do
	case "${param}" in
		f) LOGFILE=${OPTARG};;
		s) BACKUP_SRC=${OPTARG};;
		d) BACKUP_DST=${OPTARG};;
	esac
done

if [[ -z LOGFILE || -z BACKUP_SRC || -z BACKUP_DST ]]; then 
	echo "Użycie skryptu:" 
	echo -e "\t ./backup.sh -f <logfile> -s <backup-src> -d <backup-dst>"
	echo 
	exit 0
fi

function init {

	if [[ -e $LOGFILE ]]; then
		read -p "Plik logu istnieje, nadpisać [y/n]? " USER_INPUT
	fi

	if [[ $USER_INPUT == "n" ]]; then
		exit 1
	fi

	if [[ -d $BACKUP_DST ]]; then
		read -p "Folder już istnieje - czy chcesz kontynuować [y/n]? " DECYZJA
		case "$DECYZJA" in
			"y" | "yes" | "Y" | "YES") echo "Kontynuujemy..." ;;
			"n" | "no" | "N" | "NO") exit 1 ;;
			*) echo "Nie wybrałeś poprawej odpowiedzi, uruchom program jeszcze raz"
			   exit 1 ;;
		esac
	fi

	# Informacja dla uzytkownika i tworzenie folderu
	rcCreateDir=0
	echo "Tworzenie folderu backup" && mkdir $BACKUP_DST 2>/dev/null || rcCreateDir=1

	# Informacja dla uzytkownika i kopiowanie
	rcCopyDir=0
	echo "Kopiowanie plików..." && cp -r $BACKUP_SRC $BACKUP_DST > $LOGFILE 2>&1 || rcCopyDir=1

}

init

echo 
echo "Wynik:"
if [[ $rcCreateDir -eq 0 ]]; then
	echo -e "Tworzenie katalogu $BACKUP_DST \t\t [ \033[32mSUCCESS\033[0m ]"
else
	echo -e "Tworzenie katalogu $BACKUP_DST \t\t [ \033[31mFAILED\033[0m  ]"
fi

if [[ $rcCopyDir -eq 0 ]]; then
	echo -e "Kopiowanie plików \t\t\t\t\t [ \033[32mSUCCESS\033[0m ]"
else
        echo -e "Kopiowanie plików \t\t\t\t\t [ \033[31mFAILED\033[0m  ]"
fi


exit 0
