#!/bin/bash
chmod +x ./functions.sh
source ./functions.sh

if [[ $# == 1 ]]; then
    if [[ $1 -ne "1" && $1 -ne "2" && $1 -ne "3" && $1 -ne "4" ]]; then
        echo "Wrong input parameters"
    else
        start_check $1
    fi
else
    echo "We need one parameter"
fi