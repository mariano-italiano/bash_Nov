#!/bin/bash

if [[ -e $1 ]]; then
	echo "Plik $1 istnieje"
else
	echo "Plik $1 nie istnieje"
fi

exit 0

