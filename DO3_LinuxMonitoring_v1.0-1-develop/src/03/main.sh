#!/bin/bash
chmod +x functions.sh
source functions.sh

input=$#
if [[ $input -gt 4 ]] || [[ $input -lt 4 ]] ; then
    echo 'We need 4 parameters'
else
    choose_color $1 $2 $3 $4
fi
