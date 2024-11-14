#!/bin/bash


echo 
# wyswietlenie napisu hello world dla uzytkownika podanego jako argument
echo "Hello World! dla $1"
echo

echo "Wszystkie podane argumenty: $#"
echo "Wartości argumentów: $*"
echo "Wartości argumentów jako tablica: $@"

exit 0
