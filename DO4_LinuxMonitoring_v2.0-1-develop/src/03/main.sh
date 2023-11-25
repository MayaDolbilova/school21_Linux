#!/bin/bash
chmod +x ./functions.sh
source ./functions.sh
if [[ $# -ne 1 ]]; then
    echo 'We need 1 parameter, 1 for cleaning from logs, 2 for cleaning by date and time and 3 for cleaning by names''mask'
    read argument
else
    argument=${1}

fi
echo "$argument"
if [[ $argument -ne "1" && $argument -ne "2" && $argument -ne "3" ]]; then
    echo 'You entered the wrong number, there are only three possible options under numbers 1, 2, 3'
else
    start_doing_things $argument
fi