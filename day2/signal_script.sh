#!/bin/bash

CTRLC=0

function przechwyc_sygnal {
	CTRLC=$(( $CTRLC + 1 ))
	echo 
	if [ $CTRLC == 1 ] ; then
		echo "Zatrzymanie programu przez Ctrl+C"
	elif [ $CTRLC == 2 ] ; then
		echo "Ktos bardzo chce przerwać mój program"
	else
		echo "Ok poddaje sie koncze program"
		exit 1
	fi
}

trap przechwyc_sygnal SIGINT

while true
do
	echo "Spimy 5 sekund"
	sleep 5
done
