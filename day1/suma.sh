#!/bin/bash

# Definicja funkcji
licz() {
	#Wczytanie liczb od uzytkownika
	read -p "Podaj pierwszą liczbe: " LICZBA1
	read -p "Podaj drugą liczbe: " LICZBA2
	echo "Wynik operacji $LICZBA1 + $LICZBA2 = " $(( $LICZBA1 + $LICZBA2 ))
}

licz

exit 0
