#!/bin/bash

function licz_silnie(){
	if [ $1 -eq 1 ] ; then
		echo 1
	else
		local N=$(( $1 - 1 ))
		local WYNIK=$(licz_silnie $N)
		echo $(( $WYNIK * $1 )) 
	fi
}

if [ $# -eq 1 ] ; then
	SILNIA=$(licz_silnie $1)
	echo "Silnia z liczby $1 = $SILNIA"
else
	echo
	echo "Usage: $0 <liczba>"
	echo
	exit 0
fi
