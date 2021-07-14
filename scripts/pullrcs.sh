#!/bin/sh
while true;do
    cd ~/rcfiles
    git pull
    sleep 86400 # 24*60*60 # once a day
done
