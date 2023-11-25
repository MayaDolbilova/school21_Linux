#!/bin/bash

function generate() {
  amount_of_str=$(shuf -i 100-1000 -n1)
  day_1=$(shuf -i 1-23 -n1)
  day=$(expr "$day_1" + 0)
  month=$(date | awk '{ print $3 }')
  year=2023
  for (( i=1; i<6; i++)); do
    if [[ $day < 10 ]]; then
        day_fin=0$day
    else
        day_fin=$day
    fi
    touch log_number_$i.log
    for (( j=0; j<=$amount_of_str; j++)); do
       ip="$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1)"
       answer_codes=$(shuf answers.txt -n1)
       methods=$(shuf methods.txt -n1)
       fin_date="${day_fin}/${month}/${year}"
       date=$(date +'%H:%M:%S')
       url_agents=$(shuf url_agents.txt -n1)
       agents=$(shuf agents.txt -n1)
       time="[$(date -d $date +"%d/%b/%Y:")$(shuf -i 0-23 -n 1):$(shuf -i 0-59 -n 1):$(shuf -i 0-59 -n 1)] +0000] "
       str="$ip - - [$fin_date:$date +0000] \"$methods $url_agents HTTP/1.0\" $answer_codes \"-\" \"$agents\""
       echo $str >> log_number_$i.log

    done
    day=$((day + 1))
  done
}

#CODES ANSWER
#200 OK
#201 Created
#400 Bad Request
#401 Unauthorized
#403 Forbidden
#404 Not Found
#500 Internal Server Error
#501 Not Implemented
#502 Bad Gateway
#503 Service Unavailable