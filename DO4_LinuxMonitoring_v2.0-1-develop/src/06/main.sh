#!/bin/bash

if [[ $# -ne 0 ]]
then
    echo "Input error! Run the script without parameters"
else
    goaccess /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/04/*.log --log-format=COMBINED -o /home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/06/output.html
fi
#scp -P 22089 rosamonj@127.0.0.1:/home/rosamonj/DO4_LinuxMonitoring_v2.0-1/src/06/output.html /Users/rosamonj/Desktop/DO4_LinuxMonitoring_v2.0-1/src/06 этой командой перенесла html файл на локальную машину