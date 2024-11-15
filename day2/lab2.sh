#!/bin/bash
# Data: 01.01.2024
# Autor: Marcin Kujawski
# Opis: Prosty kalkulator arytmetyczny
# Użycie: ./lab2.sh

# Pobranie czasu wystartowania skryptu
start=`date +%s.%N`

# Wczytanie liczb
read -p "Podaj pierwszą liczbę: " a
read -p "Podaj drugą liczbę: " b
read -p "Podaj operację [+, -, /, *]: " operacja

if [ -z $a ] || [ -z $b ] ; then
	echo "Jedna z liczb nie została podana"
else

	# Wykonanie operacji arytmetycznej i wyświetlenie wyniku
	echo -n "WYNIK: "
	case $operacja in
	        "+") op_start=`date +%s.%N`
		     echo "scale=2; $a+$b" | bc
		     op_end=`date +%s.%N` ;;
	        "-") op_start=`date +%s.%N`
		     echo "scale=2; $a-$b" | bc 
		     op_end=`date +%s.%N` ;;
	        "/") if [ $b -gt 0 ] ; then
			     op_start=`date +%s.%N`
			     echo "scale=2; $a/$b" | bc 
			     op_end=`date +%s.%N` 
		     else
		     	     echo "Nie dzielimy przez 0!"
		             exit 1
		     fi
		     ;;
	        "*") op_start=`date +%s.%N`
		     echo "scale=2; $a*$b" | bc 
		     op_end=`date +%s.%N` ;;
	
	        *)      echo "Wybrałeś niedozwolony znak operacji!" 
			exit 1;;
	esac
	
	# Pobranie czasu zakończenia skryptu
	koniec=`date +%s.%N`
	echo
	
	# Obliczenie długości trwania i wyświetlenie wartości na zółto
	czasWykonania=$( echo "$koniec - $start" | bc -l )
	czasObliczen=$( echo "$op_end - $op_start" | bc -l )
	echo -e "Czas wykonania programu:\033[33m $czasWykonania \033[0msekund"
	echo -e "Czas wykonania obliczeń:\033[33m $czasObliczen \033[0msekund"
	echo
fi
exit 0


