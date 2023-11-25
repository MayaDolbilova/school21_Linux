#!/bin/bash


print_func() {
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(cat /etc/timezone) UTC $(date +'%-:::z')"
    echo "USER = $(whoami)"
    echo "OS = $(cat /etc/issue |awk '{print $1" "$2" "$3;exit}')"
    echo "DATE = $(date +"%d %b %Y %H:%M:%S")"
    echo "UPTIME =  $(uptime -p)"
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
    echo "IP = $(hostname -i)"
    echo "MASK = $(ip a | grep inet | grep brd | awk '{ print $4 }')"
    echo "GATEWAY = $(ip route | awk '/default/ {print $3}')"
    echo "RAM_TOTAL = $(free -m | awk '/^Mem:/{printf "%.3f GB", $2/1024}')"
    echo "RAM_USED = $(free -m | awk '/^Mem:/{printf "%.3f GB", $3/1024}')"
    echo "RAM_FREE = $(free -m | awk '/^Mem:/{printf "%.3f GB", $4/1024}')"
    echo "SPACE_ROOT = $(df  | head -4|tail -1| awk '{printf "%.2f MB", $2/1024}')"
    echo "SPACE_ROOT_USED = $(df  | head -4|tail -1| awk '{printf "%.2f MB", $3/1024}')"
    echo "SPACE_ROOT_FREE = $(df  | head -4|tail -1| awk '{printf "%.2f MB", $4/1024}')"

}

