#!/bin/bash

# Usage: ./chech_dir.sh <dir-path>

if [ $# -eq 1 ] && [ -n $1 ] ; then
	for sciezka in $1/*; do
		if [ -d $sciezka ] ; then
			echo "$sciezka jest folderem"
			for sciezka2 in $sciezka/*; do
				if [ -d $sciezka2 ] ; then
					echo "$sciezka2 jest folderem"
				elif [ -f $sciezka2 ] ; then 
					echo "$sciezka2 jest plikiem"
				fi
			done
		elif [ -f $sciezka ] ; then
			echo "$sciezka jest plikiem"
			
		fi
	done	
else
	echo
	echo "Usage: ./chech_dir.sh <dir-path>"
	echo
fi
echo 
exit 0
