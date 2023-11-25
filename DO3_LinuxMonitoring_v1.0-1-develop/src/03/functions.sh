#!/bin/bash

print_func() {
    echo -e "${1}${2}HOSTNAME = ${3}${4}$(hostname)${DEFAULT_COLOR}"
    echo -e "${1}${2}TIMEZONE = ${3}${4}$(cat /etc/timezone) UTC $(date +'%-:::z')${DEFAULT_COLOR}"
    echo -e "${1}${2}USER = ${3}${4}$(whoami)${DEFAULT_COLOR}"
    echo -e "${1}${2}OS = ${3}${4}$(cat /etc/issue |awk '{print $1" "$2" "$3;exit}')${DEFAULT_COLOR}"
    echo -e "${1}${2}DATE = ${3}${4}$(date +"%d %b %Y %H:%M:%S")${DEFAULT_COLOR}"
    echo -e "${1}${2}UPTIME = ${3}${4}$(uptime -p)${DEFAULT_COLOR}"
    echo -e "${1}${2}UPTIME_SEC = ${3}${4}$(cat /proc/uptime | awk '{print $1}')${DEFAULT_COLOR}"
    echo -e "${1}${2}IP = ${3}${4}$(hostname -i)${DEFAULT_COLOR}"
    echo -e "${1}${2}MASK = ${3}${4}$(ip a | grep inet | grep brd | awk '{ print $4 }')${DEFAULT_COLOR}"
    echo -e "${1}${2}GATEWAY = ${3}${4}$(ip route | awk '/default/ {print $3}')${DEFAULT_COLOR}"
    echo -e "${1}${2}RAM_TOTAL = ${3}${4}$(free -m | awk '/^Mem:/{printf "%.3f GB", $2/1024}')${DEFAULT_COLOR}"
    echo -e "${1}${2}RAM_USED = ${3}${4}$(free -m | awk '/^Mem:/{printf "%.3f GB", $3/1024}')${DEFAULT_COLOR}"
    echo -e "${1}${2}RAM_FREE = ${3}${4}$(free -m | awk '/^Mem:/{printf "%.3f GB", $4/1024}')${DEFAULT_COLOR}"
    echo -e "${1}${2}SPACE_ROOT = ${3}${4}$(df  | head -4|tail -1| awk '{printf "%.2f MB", $2/1024}')${DEFAULT_COLOR}"
    echo -e "${1}${2}SPACE_ROOT_USED = ${3}${4}$(df  | head -4|tail -1| awk '{printf "%.2f MB", $3/1024}')${DEFAULT_COLOR}"
    echo -e "${1}${2}SPACE_ROOT_FREE = ${3}${4}$(df  | head -4|tail -1| awk '{printf "%.2f MB", $4/1024}')${DEFAULT_COLOR}"

}
re='(^[1-6]$)'
choose_color() {
  if ! [[ $1 =~ $re ]] || ! [[ $2 =~ $re ]] || ! [[ $3 =~ $re ]] || ! [[ $4 =~ $re ]]; then
        echo -e "We need a number from 1 to 6. Try once again."
  elif [[ $1 == $2 ]] || [[ $3 == $4 ]]; then
        echo -e "The color of the font and the background should not be the same. Try once again."
  else
        back_l=$(back_color $1)
        font_l=$(font_color $2)
        back_r=$(back_color $3)
        font_r=$(font_color $4)
        print_func $back_l $font_l $back_r $font_r
  fi
}


# 1 - white, 2 - red, 3 - green, 4 - blue, 5 – purple, 6 - black

#DEFAULT COLOR
DEFAULT_COLOR='\033[0m'
#FONT COLORS
WHITE_FONT='\033[37m'
RED_FONT='\033[31m'
GREEN_FONT='\033[32m'
BLUE_FONT='\033[36m'
PURPLE_FONT='\033[35m'
BLACK_FONT='\033[30m'
#BACKGROUND COLORS
WHITE_BG='\033[47m'
RED_BG='\033[41m'
GREEN_BG='\033[42m'
BLUE_BG='\033[46m'
PURPLE_BG='\033[45m'
BLACK_BG='\033[40m'

back_color() {
       case $1 in
        1) echo "$WHITE_FONT";;
        2) echo "$RED_FONT";;
        3) echo "$GREEN_FONT";;
        4) echo "$BLUE_FONT";;
        5) echo "$PURPLE_FONT";;
        6) echo "$BLACK_FONT";;
        *) echo "$DEFAULT_COLOR";;
    esac
}

font_color() {
    case $1 in
        1) echo "$WHITE_BG";;
        2) echo "$RED_BG";;
        3) echo "$GREEN_BG";;
        4) echo "$BLUE_BG";;
        5) echo "$PURPLE_BG";;
        6) echo "$BLACK_BG";;
        *) echo "$DEFAULT_COLOR";;
    esac
}
