#!/bin/bash
# Data: 01.01.2024
# Autor: Marcin Kujawski
# Opis: Skrypt który zbiera informacje na temat wersji jądra systemu
# Użycie: ./lab1.sh -s <serwer IP>

# Pobranie IP serwera z parametrów skryptu
while getopts "s:" flag
  do
    case "${flag}" in
      s) serverIp=${OPTARG};;
    esac
  done

# Walidacja poprawnosci podania serverIP
if [ $# -eq 2 ] ; then


	# Pobranie użytkownika do logowania
	read -p "Podaj username dla $serverIp: " user
	
	# Połączenie z serwerem oraz wydobycie wersji jadra i hostname
	ssh ${user:-student}@$serverIp 'echo -e "Wersja jądra systemu\033[32m $HOSTNAME \033[0mto:\033[33m `uname -r`\033[0m"'

	echo
	exit 0
else
	echo
	echo "Usage: $0 -s <serverIP>"
	echo
fi
