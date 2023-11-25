#!/bin/bash

function check_args() {
reg_1='^[a-zA-Z]{1,7}$'
reg_2='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
reg_3='^[1-9][0-9]?[0]?Mb$'
if ! [[ $1 =~ $reg_1 ]]; then
    echo "Incorrect letters for folders' names"
elif ! [[ $2 =~ $reg_2 ]]; then
    echo "Incorrect letters for files' names"
elif ! [[ $3 =~ $reg_3 ]]; then
    echo "Incorrect size"
else
    start_making_thing $1 $2 $3
fi
}

function start_making_thing() {
    letterFolders=${1}
    letterFiles=${2}
    size=$(echo $3 | awk -F"Mb" '{print $1}')
    touch log.txt
    total_memmory=$(df -hk | awk 'NR==4{print $4}')
    amountof_folders=$(( 1 + $RANDOM % 100 ))
    not_create='\/[s]?bin|\/lost\+found|\/root'
    for (( number=0; number<$amountof_folders; number++ ))
    do
        if [[ $total_memmory -lt 1048576 ]]; then
            echo "No space left!"
            echo "No space left! $(date +"%d-%m-%y") $(date +"%H:%M:%S")">>/home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
            break
        fi
        cd /
        path="/"
        dir_name=""

        create_folders $1 $2 $3
    done
}

function create_folders() {
    path="/"
    count_dirs=$(echo $(ls -l -d */ 2>/dev/null | wc -l ))
    random_number=$(echo $(( ($RANDOM % ($count_dirs - 1)) + 1 )))
    path+="$( ls -l -d */ | awk '{print $9}' | sed -n "$random_number"p )"
    if ! [[ $path =~ $not_create ]]; then
        cd $path
        if [[ ${#1} -lt 5 ]]; then
            short_names_dir
        else
            long_names_dir
        fi
    else
        create_folders
    fi
}

function short_names_dir() {

    count=${#letterFolders}
    for (( i=0; i<5-count+$number; i++ ))
    do
        dir_name+="$(echo ${letterFolders:0:1})"
    done
    dir_name+="$(echo ${letterFolders:1:${#letterFolders}})"
    dir_name+="_"
    dir_name+=$(date +"%d%m%y")
    sudo mkdir $dir_name 2>/dev/null
    echo $path"/"$dir_name --- $(date +"%d-%m-%y") $(date +"%H:%M:%S") ---  >> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
    cd $dir_name 2>/dev/null
    if [[ $total_memmory -lt 1048576 ]]; then
            echo "No space left!"
            echo "No space left! $(date +"%d-%m-%y") $(date +"%H:%M:%S")">>/home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
    else
            make_files $path $dir_name $letterFiles $size
            cd .. 2>/dev/null
    fi
}

function long_names_dir() {
    for (( i=0; i<$number; i++ ))
    do
        dir_name+="$(echo ${letterFolders:0:1})"
    done
    dir_name+="$(echo ${letterFolders:1:${#letterFolders}})"
    dir_name+="_"
    dir_name+=$(date +"%d%m%y")
    sudo mkdir $dir_name 2>/dev/null
    echo $path"/"$dir_name --- $(date +"%d-%m-%y") $(date +"%H:%M:%S") ---  >> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
    cd $dir_name 2>/dev/null
    if [[ $total_memmory -lt 1048576 ]]; then
            echo "No space left!"
            echo "No space left! $(date +"%d-%m-%y") $(date +"%H:%M:%S")">>/home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
    else
            make_files $path $dir_name $letterFiles $size
            cd .. 2>/dev/null
    fi

}
function make_files() {
    file_name_start="$(echo $letterFiles | awk -F "." '{print $1}')"
    file_name_end="$(echo $letterFiles | awk -F "." '{print $2}')"
    count_files=$(echo $(( $RANDOM % 20 )))
    for (( number_files=0; number_files <$count_files; number_files++ ))
    do
        file_name=""
        if [[ ${#file_name_start} -lt 5 ]]; then
            create_files_with_little_name
            echo $path"/"$dir_name"/"$file_name --- $(date +"%d-%m-%y") $(date +"%H:%M:%S") --- $size "Kb" >> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
        else
            create_files_with_big_name
            echo $path"/"$dir_name"/"$file_name --- $(date +"%d-%m-%y") $(date +"%H:%M:%S") --- $size "Kb" >> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
        fi
    done
}

function create_files_with_little_name {
    count=${#file_name_start}
    for (( i=0; i<5-count+$number_files; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    file_name+="$(echo ${file_name_start:1:${#file_name_start}})"
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    sudo fallocate -l $size"MB" $file_name 2>/dev/null

    if [[ $total_memmory -lt 1048576 ]]; then
        echo "No space left!"
        echo "No space left! $(date +"%d-%m-%y") $(date +"%H:%M:%S")">> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
        exit 1
    fi
}

function create_files_with_big_name {
    for (( i=0; i<$number_files; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    file_name+="$(echo ${file_name_start:1:${#file_name_start}})"
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    sudo fallocate -l $size"MB" $file_name 2>/dev/null
    if [[ $total_memmory -lt 1048576 ]]; then
        echo "No space left!"
        echo "No space left! $(date +"%d-%m-%y") $(date +"%H:%M:%S")">> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
        exit 1
    fi
}
                                                