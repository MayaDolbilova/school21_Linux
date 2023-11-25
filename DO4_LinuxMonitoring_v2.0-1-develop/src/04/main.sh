#!/bin/bash
chmod +x ./functions.sh
source ./functions.sh

if [[ $# == 0 ]]; then
    generate
else
    echo "Wrong input parameters"
fi
