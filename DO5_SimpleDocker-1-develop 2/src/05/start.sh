#!/bin/bash
service nginx start
spawn-fcgi -p 8080 ./server
nginx -s reload
while true; do
        wait
done