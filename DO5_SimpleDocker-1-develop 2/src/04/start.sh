#!/bin/bash
service nginx start
nginx -s reload
gcc server.c -lfcgi -o server
spawn-fcgi -p 8080 ./server
while true; do
        wait
done      