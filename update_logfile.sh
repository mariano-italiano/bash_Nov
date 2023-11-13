#!/bin/bash 
# Task: Podmiana zmiennej globalnej 

INPUT_LOGFILE=$LOGFILE
echo "Logfile ze skryptu $0 - $INPUT_LOGFILE"

LOGFILE=updated_log_file 
echo "Logfile ze skryptu $0 - $LOGFILE"
