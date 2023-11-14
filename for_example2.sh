#!/bin/bash 
pliki=('Plik1' 'Plik2' 'Plik3') 

for plik in "${pliki[@]}"
do 
	cp $plik{,.bak} 
	echo "Utworzono kopię $plik" 
done

