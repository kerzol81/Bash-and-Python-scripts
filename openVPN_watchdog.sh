#!/bin/bash
# OpenVPN watchdog 
# Start it with cron @reboot

ISLANDS=( 10 20 30 40 50 60 )
WAIT=300

while true;
do
	for i in "${ISLANDS[@]}";do
		STATUS=$(systemctl status openvpn@$i | grep -o "inactive")

        	if [ "$STATUS" == "inactive" ];then
                	systemctl stop openvpn@$i.service
                	sleep 5
                	systemctl start openvpn@$i.service
                	logger "OpenVPN watchdog: $i island has been restarted"
        	fi
	done

sleep "$WAIT"

done
