#!/bin/bash
chmod +x ./functions.sh
source ./functions.sh

if [[ $# == 0 ]]; then
   collect_everything
else
    echo "We dont't need any parameters"
    exit 1
fi