#!/bin/bash

for (( i=1; i<31; i++ ))
do
	if (( i % 2 == 0 )); then
		continue
	fi
	if (( i == 21 )); then
		break
	fi
	echo $i
done
