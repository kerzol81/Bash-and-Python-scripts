#!/bin/bash

# ssh ability to the routers is a prerequisite step
# outter file containing the IPs is also

TODAY=$(date +%Y-%m-%d)
HOUR=$(date +%H)
FILENAME=$(date +%Y%m%d_%H%M)
BACKUPDIR="/home/$USER/MikrotikBackups"
ROTATE=30
USER="admin"
declare -a ROUTERS
#ROUTERS="10.0.0.1 10.0.0.10"

if [ "$1" == "debug" ]; then
  set -x
fi

if find . -type f -name routers.txt &> /dev/null; then
	readarray ROUTERS < routers.txt
else
	print '[!] No routers.txt file, exiting'
	exit 1
fi


for ROUTER in "$ROUTERS"; do
	if ping -c 1 "$ROUTER" &> /dev/null; then
		mkdir -p "$BACKUPDIR"
		mkdir -p "$BACKUPDIR/$TODAY/$ROUTER" 2>/dev/null
		chmod 750 "$BACKUPDIR"

		ssh -q "$USER"@"$ROUTER" "/export file=export_${FILENAME}"
		scp -q "$USER"@"$ROUTER":/export_${FILENAME}.rsc "$BACKUPDIR"/"$TODAY"/"$ROUTER"
		ssh "$USER"@"$ROUTER" "/file remove export_${FILENAME}.rsc"

		ssh "$USER"@"$ROUTER" "/system backup save name=backup_${FILENAME}" &>/dev/null
		sleep 2
		scp -q ""$USER"@""$ROUTER":/backup_${FILENAME}.backup $BACKUPDIR/$TODAY/$ROUTER/
		ssh "$USER"@"$ROUTER" "/file remove export_${FILENAME}.backup"

		find "$BACKUPDIR" -mindepth 1 -maxdepth 1 -type d -mtime +"$ROTATE" -exec rm -rf "{}" \;

	fi

done
