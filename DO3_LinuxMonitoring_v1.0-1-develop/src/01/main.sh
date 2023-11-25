#!/bin/bash

input="$1"
reg='^[+-]?[0-9]+([.,][0-9]+)?$'

if [[ ! $input ]]; then
    echo 'We need one parameter'
else
    if [[ $# -gt 1 ]]; then
	echo 'We need only one parameter'
    elif [[ $input =~ $reg ]]; then
        echo 'Incorrect input'
    else
        echo "$input"
    fi
fi
