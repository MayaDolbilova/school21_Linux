#!/bin/bash

function start_check() {
    log_files=$(find ../04 -name "log*.log")
    case $1 in
        1) touch log_sort_answers.txt
        for file in $log_files
        do
                echo "$(awk '{print}' $file | sort -k9)" >> log_sort_answers.txt
        done
        sort -o log_sort_answers.txt -k9 log_sort_answers.txt
        ;;
        2) touch unique_ip.txt
        for file in $log_files
        do
                echo "$(awk '{print $1}' $file | sort | uniq | sort -n)" >> unique_ip.txt
        done
        sort -o unique_ip.txt unique_ip.txt | uniq
        ;;
        3) touch all_mistakes.txt
        for file in $log_files
        do
                echo "$(awk '($9 >= 400) {print}' $file)" >> all_mistakes.txt
        done
        ;;
        4) touch unique_ip_mistakes.txt
        for file in $log_files
        do
                echo "$(awk '($9 >= 400) {print $1}' $file | sort | uniq | sort -n)" >> unique_ip_mistakes.txt
        done
        sort -o unique_ip_mistakes.txt unique_ip_mistakes.txt | uniq
        ;;
    esac
}