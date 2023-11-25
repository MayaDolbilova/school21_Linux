#!/bin/bash

function start_doing_things() {
    case $1 in
        1) amount_of_files=$(awk 'END{print NR}' ../02/log.txt)
        for (( i=1; i<$amount_of_files-3; i++ ))
        do
            path_name=$(awk 'NR == '$i' {print $1}' ../02/log.txt)
            sudo rm -vr "$path_name" 2>/dev/null
        done
        echo 'READY'
            ;;
        2) echo 'Please, enter the date in the format: DD-mm-YY'
        read start_date
        echo 'Please, enter the start time in the format: HH:MM:SS'
        read start_time
        start_time_sec=$(date -d "$start_time" +%s)
        echo 'Please, enter the end time in the format: HH:MM:SS'
        read end_time
        end_time_sec=$(date -d "$end_time" +%s)
        amount_of_files=$(awk 'END{print NR}' ../02/log.txt)
        for (( i=1; i<$amount_of_files-3; i++ ))
        do
                path='/'
                date=$(awk 'NR=='$i' {print $3}' ../02/log.txt)
                time=$(awk 'NR=='$i' {print $4}' ../02/log.txt)
                time_sec=$(date -d "$time" +%s)
                if [[ "$date" == "$start_date" ]]; then
                    if [[ $time_sec -ge $start_time_sec && $time_sec -le $end_time_sec ]]; then
                            path=$(awk 'NR=='$i' {print $1}' ../02/log.txt)
                            echo $path
                            sudo rm -r "$path" 2>/dev/null
                    fi
                fi
        done
        echo 'READY'
            ;;
        3) echo 'Please, enter the mask in the format: foldername_$(date '+%d%m%y') or filename_$(date '+%d%m%y').ext'
           read mask
           sudo rm -rf $(find / -type f -name "*$mask" 2>/dev/null)
           sudo rm -rf $(find / -type d -name "*$mask" 2>/dev/null)
            ;;
    esac
}
