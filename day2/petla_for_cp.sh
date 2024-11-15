#!/bin/bash

DIR_NAME=/tmp/petla_for
mkdir $DIR_NAME
for plik in $(ls $HOME/bash_Nov/day1) 
do
	cp $HOME/bash_Nov/day1/$plik $DIR_NAME/$plik.bak
	echo "Utworzono kopie pliku $plik"
done
