#!/bin/bash
time_first=$(date +%s.%N)
chmod +x ./functions.sh
source ./functions.sh

if [[ $# -ne 1 ]]; then
    echo 'We need one parameter'
elif [[ ! -d $1 ]]; then
    echo 'We need directory as an argument'
else 
    print_func $1
    time_second=$(date +%s.%N)
    echo -e "Script execution time (in seconds) = " `echo "$time_second $time_first" | awk '{printf "%.3lf", $1-$2}'`
fi
