#!/bin/bash

while getopts "f:c:" opt
do
	case $opt in
                 c) TEMP=$(echo "scale=2; ($OPTARG * (9 / 5) + 32 )" | bc)
		    echo "Temperatura w Fahrenheitach wynosi: $TEMP" ;;
                 f) TEMP=$(echo "scale=2; ($OPTARG - 32) * (5 / 9)" | bc)
                    echo "Temperatura w Celcjuszach wynosi: $TEMP" ;;
        esac

done

