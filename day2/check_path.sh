#!/bin/bash

if [ $# -eq 1 ] ; then
	FILE=$1

	if [ -d $FILE ] ; then
		echo "Podany plik $FILE jest katalogiem. Brak możliwości wyświetlenia"
		exit 0
	else
		if [ -e $FILE ] ; then
			echo "Plik $FILE istnieje"
			if [ -s $FILE ] ; then
				echo "Treść pliku: "
				echo
				cat $FILE
			else
				echo "Nie wyświetlam pliku bo nic w nim nie ma"
			fi
		else
			echo "Plik $FILE nie istnieje"
		fi
	fi
else
	echo "Usage: $0 <file-path>"
	exit 0
fi

exit 0

