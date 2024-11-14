#!/bin/bash

#Sprawdzanie argumentów
if [ $# -eq 2 ] ; then
	IMIE=$1 
	WIEK=$2
else
	echo
	echo "Usage: $0 <imie> <wiek>"
	echo
	exit 0
fi

# Wyswietlenie dla uzytkownika
echo "Imie: $IMIE"
echo "Wiek: $WIEK"
exit 0
