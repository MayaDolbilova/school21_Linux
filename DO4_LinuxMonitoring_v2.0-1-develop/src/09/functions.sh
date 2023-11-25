#!/bin/bash


function collect_everything() {
    sudo touch /usr/share/nginx/html/prometheus.html
    sudo chmod 777 /usr/share/nginx/html/prometheus.html
while true; do
    collect | sudo tee /usr/share/nginx/html/prometheus.html
    sleep 3
done
}

function collect() {
   used_cpu="$(ps -eo pcpu | awk '{s+=$1} END {print s}')"
   ram="$(free -b | awk 'NR==2{print $4}')"
   hdd=$(df -h / | awk '/\//{print $(NF-1)}' | sed 's/%//')


   cat <<EOF > /usr/share/nginx/html/prometheus.html
# HELP cpu_usage CPU usage in percent
# TYPE cpu_usage gauge
cpu_usage $used_cpu

# HELP memory_usage Memory usage in percent
# TYPE memory_usage gauge
memory_usage $ram

# HELP disk_usage Disk usage in percent
# TYPE disk_usage gauge
disk_usage $hdd
EOF
}
