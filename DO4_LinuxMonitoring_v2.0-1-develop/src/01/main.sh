#!/bin/bash

chmod +x ./functions.sh
source ./functions.sh

if [[ $# -ne 6 ]]; then
    echo 'We need six parameteres'
else
    check_args $1 $2 $3 $4 $5 $6
fi
