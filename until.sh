#!/bin/bash 
# Pętla Until 

LICZBA=0 
until [ $LICZBA -gt 10 ] ; 
do 
	echo "Odliczam: $LICZBA" 
	sleep 1 
	LICZBA=$(( $LICZBA + 1 )) 
done
