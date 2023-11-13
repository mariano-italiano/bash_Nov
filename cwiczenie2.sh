#!/bin/bash

# Definicja funkcji
function sumuj(){
	A=$1
	B=$2

	echo "$A + $B = " $(($A + $B))
}

# Wczytanie inputu od usera
read -p "Podaj pierwsza liczbe: " LICZBA1
read -p "Podaj druga liczbe: " LICZBA2

sumuj $LICZBA1 $LICZBA2

exit 0
