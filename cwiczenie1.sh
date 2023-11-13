#!/bin/bash

# Sprawdzenie argumenty 
if [ $# -eq 2 ]; then
	IMIE=$1
	WIEK=$2
else
	echo "Usage: $0 <imie> <wiek>"
	echo
	exit 1
fi

# Wyswietlenie informacji
echo "Imie: $IMIE"
echo "Wiek: $WIEK"
echo
exit 0
