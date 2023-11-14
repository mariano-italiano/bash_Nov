#!/bin/bash 
# Pętla While 

LICZBA=0
while [ $LICZBA -ge 0 ] ; 
do 
	if [[ $LICZBA == 20 ]]; then
		echo "Odliczam: $LICZBA"
		break;
	else
		sleep 1
		LICZBA=$(( $LICZBA + 1 )) 
	fi
done
