#!/bin/bash

COUNT=0
for folder in $(ls /var) ; do
	echo "COUNTER = $COUNT"
	if [[ "$folder" == *"log"* ]] ; then
		echo "log folder found"
		break;
	else
		echo "$folder is not a log folder"
		continue;
		COUNT=$(( COUNT + 1 ))
	fi
done
