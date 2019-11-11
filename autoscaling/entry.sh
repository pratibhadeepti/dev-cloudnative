#!/bin/bash

cd /home

chmod +x init_tools.sh

bash init_tools.sh

sudo pip install openstackclient

sleep 60 

while true
do
    bash cron.sh
    sleep 60
done
