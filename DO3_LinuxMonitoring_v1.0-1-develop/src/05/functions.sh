#!/bin/bash

amount_directory=$(find $1 -type d | wc -l)
top_five_directory=$(du -h $1 | sort -rh | head -5 | cat -n | awk '{print $1" - "$3", "$2}')
amount_files=$(find $1 -type f | wc -l)
conf_files=$(find $1 -type f -name '*.conf' | wc -l)
txt_files=$(find $1 -type f -name '*.txt' | wc -l)
exe_files=$(find $1 -type f -executable | wc -l)
log_files=$(find $1 -type f -name '*.log' | wc -l)
arch_files=$(find $1 -type f -name "*.zip" -o -name "*.7z" -o -name "*.rar" -o -name "*.tar" | wc -l)
symbol_link=$(find $1 -type l | wc -l)
top_ten_files=$(find $1 -type f -exec du -h {} + | sort -hr | head -10 | awk '{print $1" - "$3", "$2}')
top_ten_exe=
time_execution=
print_func() {
    echo -e "Total number of folders (including all nested ones) = ${amount_directory}"
    echo -e "TOP 5 folders of maximum size arranged in descending order (path and size):\n${top_five_directory}"
    echo -e "Total number of files = ${amount_files}"
    echo -e "Number of:\nConfiguration files (with the .conf extension) = ${conf_files}\nText files = ${txt_files}\nExecutable files = ${exe_files}\nLog files (with the extension .log) = ${log_files}\nArchive files = ${arch_files}\nSymbolic links = ${symbol_link}"
    echo -e "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    for ((i=1; i<=10; i++))
    do
        file=$(find $1* -type f -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d")
        if ! [[ -z $file ]]; then
            echo -n "$i - "
            echo -n "$(echo $file | awk '{print $2",", $1}'), "
            echo "$(echo $file | grep -m 1 -o -E "\.[^/.]+$" | awk -F . '{print $2}')"
        fi
    done
    echo -e "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
    for ((i=1; i<=10; i++))
    do
        file=$(find $1*  -type f -executable -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d")
        if ! [[ -z $file ]]; then
            echo -n "$i - "
            echo -n "$(echo $file | awk '{print $2",", $1}'), "
            path=$(echo $file | awk '{print $2}')
            hash=$(md5sum $path | awk '{print $1}')
            echo "$hash"
        fi
    done
}
