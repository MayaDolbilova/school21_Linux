#!/bin/bash

function check_args() {
last_symb=$(echo "${1}" | tail -c 2)
reg_1='^[1-9][0-9]+?$'
reg_2='^[a-zA-Z]{1,7}$'
reg_3='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
reg_4='^[1-9][0-9]?[0]?kb$'
    if [[ $last_symb == "/" ]] || ! [[ -d $1 ]]; then
        echo "Wrong path"
    elif ! [[ $2 =~ $reg_1 ]]; then
        echo "a non-numeric value has been entered for folders"
    elif ! [[ $3 =~ $reg_2 ]]; then
        echo "incorrect name for folders"
    elif ! [[ $4 =~ $reg_1 ]]; then
        echo "a non-numeric value has been entered for files"
    elif ! [[ $5 =~ $reg_3 ]]; then
        echo "incorrect name for files"
    elif ! [[ $6 =~ $reg_4 ]]; then
        echo "incorrect size"
    else
      start_creating_files $1 $2 $3 $4 $5 $6
    fi
}

function start_creating_files() {
    total_memmory=$(df -hk | awk 'NR==4{print $4}')
    path=${1}
    countFolders=${2}
    letterFolders=${3}
    countFiles=${4}
    letterFiles=${5}
    size=$(echo $6 | awk -F"kb" '{print $1}')
    cd $path
    touch log.txt
    if [[ $total_memmory -lt 1048576 ]]; then
        echo "No space left!"
        echo "No space left! [$(date +"%d-%m-%y") $(date +"%H:%M:%S")]">>log.txt
    else
        make_dirs $path $countFolders $letterFolders
    fi
}

function make_dirs() {
    for (( number=0; number <$countFolders; number++ ))
    do
        dir_name=""
        if [[ ${#letterFolders} -lt 4 ]]; then
            short_names_dir $1 $2 $3 $number
        else
            long_names_dir $1 $2 $3 $number
        fi
    done
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
    mkdir $dir_name
    echo $1"/"$dir_name --- $(date +'%e.%m.%Y') ---  >> log.txt
    cd $dir_name
    if [[ $total_memmory -lt 1048576 ]]; then
            echo "No space left!"
            echo "No space left! [$(date +"%d-%m-%y") $(date +"%H:%M:%S")]">>log.txt
    else
            make_files $path $dir_name $countFiles $letterFiles $size
            cd ..
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
    mkdir $dir_name
    echo $path"/"$dir_name --- $(date +'%e.%m.%Y') ---  >> log.txt
    cd $dir_name
    if [[ $total_memmory -lt 1048576 ]]; then
            echo "No space left!"
            echo "No space left! [$(date +"%d-%m-%y") $(date +"%H:%M:%S")]">>log.txt
    else
            make_files $path $dir_name $countFiles $letterFiles $size
            cd ..
    fi

}

function make_files() {
    file_name_start="$(echo $letterFiles | awk -F "." '{print $1}')"
    file_name_end="$(echo $letterFiles | awk -F "." '{print $2}')"
    for (( number_files=0; number_files <$countFiles; number_files++ ))
    do
        file_name=""
        if [[ ${#file_name_start} -lt 4 ]]; then
            create_files_with_little_name
            echo $path"/"$dir_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb" >> ../log.txt
        else
            create_files_with_big_name
            echo $path"/"$dir_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb" >> ../log.txt
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
    fallocate -l $size"KB" ./$file_name

    if [[ $total_memmory -lt 1048576 ]]; then
        echo "No space left!"
        echo "No space left! [$(date +"%d-%m-%y") $(date +"%H:%M:%S")]">> ../log.txt
        exit 1
    fi
}

function create_files_with_big_name {
    for (( i=0; i<$number_files; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    file_name+="$(echo ${file_name_start:0:${#file_name_start}})"
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    fallocate -l $size"KB" ./$file_name

    if [[ $total_memmory -lt 1048576 ]]; then
        echo "No space left!"
        echo "No space left! [$(date +"%d-%m-%y") $(date +"%H:%M:%S")]">> ../log.txt
        exit 1
    fi
}
