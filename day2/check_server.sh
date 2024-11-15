#!/bin/bash

while read serwer; do
	ping -c2 $serwer > /dev/null
	if [ $? = 1 ]; then
		echo -e "\033[31mSerwer \033[33m$serwer\033[31m nie jest osiągalny\033[0m"
	else 
		echo -e "\033[32mSerwer \033[33m$serwer\033[32m jest osiągalny\033[0m"
	fi
done < servers.txt

