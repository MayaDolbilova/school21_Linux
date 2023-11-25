#!/bin/bash
chmod +x ./functions.sh
source ./functions.sh
start_time=$(date +'%Y-%m-%d %H:%M:%S')
start=$(date +%s)
if [[ $# -ne 3 ]]; then
    echo 'We need 3 parameteres'
else
    check_args $1 $2 $3
fi

end_time=$(date +'%Y-%m-%d %H:%M:%S')
end=$(date +%s)
chmod +w /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
echo "Script started at $start_time" >> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
echo "Script ended at $end_time" >> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
total_time=$(($end - $start))
echo "Script lasted for $total_time seconds" >> /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/02/log.txt
echo "Script started at $start_time"
echo "Script ended at $end_time"
echo "Script lasted for $total_time seconds"