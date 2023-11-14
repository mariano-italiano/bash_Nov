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

if [ -z $LOGFILE ] || [ -z $BACKUP_SRC ] || [ -z $BACKUP_DST ] ; then 
	echo "Użycie skryptu:" 
	echo -e "\t ./backup.sh -f <logfile> -s <backup-src> -d <backup-dst>"
	echo 
	exit 0
fi

CTRLC=0

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

	if [[ rcCopyDir -gt 0 ]] ; then
		for plik in $(cat $LOGFILE | cut -d "'" -f 2)
		do
			if [[ $plik == *"locate" ]] ; then
                                break;
                        elif [[ $plik == *"su"* ]] ; then 
				echo "Plik z brakiem uprawnien do czytania: $plik" >> ~/missing_permisions.txt
				continue; 
			fi 
		done
	fi

	while [ -z $KOMPRESJA ] ; do
		read -p "Czy dokonać kompresji $BACKUP_DST ? [y/n]: " ODP 
		if [ $ODP = "y" ] || [ $ODP = "yes" ] ; then 
			KOMPRESJA=1 
			echo "Kompresuje backup..." 
			tar -czf $BACKUP_DST.tar.gz $BACKUP_DST/* > /dev/null 2>&1 
		elif [ $ODP = "n" ] || [ $ODP = "no" ] ; then 
			KOMPRESJA=0 
			echo "Kompresja pominięta" else echo "Podałeś złą odpowiedź!" 
		else
			echo "Podałeś niepoprawną odpowiedź!"
		fi
	done
}

function cleanup { 
	CTRLC=$(( $CTRLC + 1 )) 
	echo 
	if [[ $CTRLC = 1 ]] ; then 
		read -p "Wcisnąłeś Ctrl+C, czy chcesz zakończyć działanie programu? [y/n]: " WYJSCIE
		if [ $WYJSCIE = 'y' ] ; then 
			if [[ -d $BACKUP_DST ]]; then
				sudo rm -rf $BACKUP_DST
			fi
			if [[ -e $LOGFILE ]]; then
				sudo rm -rf $LOGFILE
			fi
			if [[ -e $BACKUP_DST.tar.gz ]]; then
				sudo rm -rf $BACKUP_DST.tar.gz
			fi
			exit
		else 
			CTRLC=0 
		fi 
	fi 
}

trap cleanup SIGINT

init

echo 
echo "Wynik:"
if [[ $rcCreateDir -eq 0 ]]; then
	echo -e "Tworzenie katalogu $BACKUP_DST \t\t\t [ \033[32mSUCCESS\033[0m ]"
else
	echo -e "Tworzenie katalogu $BACKUP_DST \t\t\t [ \033[31mFAILED\033[0m  ]"
fi

if [[ $rcCopyDir -eq 0 ]]; then
	echo -e "Kopiowanie plików \t\t\t\t\t [ \033[32mSUCCESS\033[0m ]"
else
        echo -e "Kopiowanie plików \t\t\t\t\t [ \033[31mFAILED\033[0m  ]"
fi


exit 0
