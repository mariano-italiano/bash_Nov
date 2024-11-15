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


	if [ -z $LOGFILE ] || [ -z $BACKUP_LOC ] || [ -z $BACKUP_DST ] ; then
		echo 
		echo "Parametry skryptu są podane niepoprawnie. "
		echo 
		echo "Usage: $0 -f <logfile> -s <backup_src> -d <backup_dst>"
	        echo
 		exit 0
	fi


	if [ -e $BACKUP_DST ]; then
		read -p "Katalog $BACKUP_DST już istnieje, czy chcesz kontynuować [y/n]? " DECYZJA
		case $DECYZJA in
			"n") echo "Przerywam działanie programu"
			     exit 0 
			;;
			"y") RCT1="SKIPPED" ;;
			*) echo "Musisz podać 'y' lub 'n' !"
			   exit 1 ;;
		esac
		
	
		#if [ $DECYZJA = "n" ] || [ $DECYZJA = "no" ] ; then
		#	echo "Przerywam działanie programu"
		#	exit 0
		#fi
		#if [ $DECYZJA = "y" ] || [ $DECYZJA = "yes" ] ; then
		#3	RCT1="SKIPPED"
		#fi
	else
		echo "Tworzenie katalogu $BACKUP_DST" && mkdir $BACKUP_DST 2>/dev/null
 	        if [ $? -eq 0 ]; then
        		RCT1="SUCCESS"
                else
                        RCT1="FAILED"
                fi

	fi

	
	echo "Kopiowanie plików z $BACKUP_LOC do $BACKUP_DST..." && cp -rp $BACKUP_LOC/* $BACKUP_DST 1> $LOGFILE 2>&1
	if [ $? -eq 0 ]; then
		#echo
		#echo -e "\033[32mBackup zakonczony sukcesem\033[0m"
		#echo
		RCT2="SUCCESS"

		COMPRESS=""
		while [ -z $COMPRESS ] ; do
			read -p "Czy dokonać kompresji $BACKUP_DST ? [y/n]: " ODP
			if [ $ODP = "y" ] || [ $ODP = "Y" ] || [ $ODP = "yes" ] || [ $ODP = "YES" ] ; then
				COMPRESS=1
				echo "Kompresuje backup"	
				tar -czf $BACKUP_DST.tar.gz $BACKUP_DST/* > /dev/null 2>&1
				if [ $? -eq 0 ]; then
					RCT3="SUCCESS"
				else
					RCT3="FAILED"
				fi

			elif [ $ODP = "n" ] || [ $ODP = "N" ] || [ $ODP = "no" ] || [ $ODP = "NO" ] ; then
				COMPRESS=0
				RCT3="SKIPPED"
				echo "Kompresja pominięta"
			else
				echo "Podałeś złą odpowiedź, musi być [y/n]!"
			fi
		done

		SCRIPT_COUNT=0
		for plik in $(ls $BACKUP_DST)
		do
			if [[ $plik = *".sh" ]] ; then
				SCRIPT_COUNT=$(( $SCRIPT_COUNT + 1 ))
			fi
		done
		for insecure_file in $(find $BACKUP_DST -perm /o+x) 
		do
			if [ -f $insecure_file ] ; then
				ls -la $insecure_file >> $BACKUP_DST/insecure.txt
			fi
		done
	else
		#echo
		#echo -e "\033[31mBackup zakończony z błędami. Sprawdź plik logów: $LOGFILE\033[0m"
		#echo
		RCT2="FAILED"
	fi
else
	echo
	echo "Usage: $0 -f <logfile> -s <backup_src> -d <backup_dst>"
	echo
	exit 0
fi

echo
if [ $RCT1 = "SUCCESS" ] ; then
	echo -e "TASK1 - Tworzenie katalogu backupowego 		[ \033[32m$RCT1\033[0m ]"
elif [ $RCT1 = "SKIPPED" ] ; then
	echo "TASK1 - Tworzenie katalogu backupowego		[ $RCT1 ]" 
else
	echo -e "TASK1 - Tworzenie katalogu backupowego 		[ \033[31m$RCT1\033[0m ]"
fi

if [ $RCT2 = "SUCCESS" ] ; then
	echo -e "TASK2 - Kopiowanie plików 	 		[ \033[32m$RCT2\033[0m ]"
else
	echo -e "TASK2 - Kopiowanie plików 	 		[ \033[31m$RCT2\033[0m ]"
	echo -e "\033[31mBackup zakończony z błędami. Sprawdź plik logów: $LOGFILE\033[0m"
	
fi
if [ $RCT3 = "SUCCESS" ] ; then
	echo -e "TASK3 - Kompresja backup folderu		[ \033[32m$RCT3\033[0m ]"
elif [ $RCT3 = "SKIPPED" ] ; then
	echo -e "TASK3 - Kompresja backup folderu		[ $RCT3 ]"
else
	echo -e "TASK3 - Kompresja backup folderu		[ \033[31m$RCT3\033[0m ]"
fi

	
echo
echo "Liczba skryptów w katalogu $BACKUP_DST: $SCRIPT_COUNT"
if [ -e $BACKUP_DST/insecure.txt ] ; then
	echo "Znaleziono pliki z niebezpiecznymi uprawnieniami. Sczegóły w pliku $BACKUP_DST/insecure.txt"
fi
echo
