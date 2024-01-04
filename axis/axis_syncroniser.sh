#!/bin/bash
set -x
source config

LOGPATH="/usr/local/bin/log/" && mkdir -p "$LOGPATH" || echo "ERROR: WRITE to $LOGPATH" && exit 0
PIDPATH="/usr/local/bin/pid/" && mkdir -p "$PIDPATH" || echo "ERROR: WRITE to $LOGPATH" && exit 0
DST="/mnt/dest/"
SRC="/mnt/source/"
RSYNC_OPTS="-v --timeout=30 -az --no-perms --no-owner --no-group --remove-source-files"

OPTSTRING=":i:p:d:"

while getopts ${OPTSTRING} opt; do
  case ${opt} in
    i)
      IP=${OPTARG}
      ;;
    p)
      PASSWORD=${OPTARG}
      ;;
    d)
      FOLDER=${OPTARG}
      ;;
    ?)
      echo "$(date "+%F %H:%M:%S") ERROR: invalid option: -${OPTARG} EXIT (1)"
      exit 1
      ;;
  esac
done

PID="$PIDPATH$(basename "$0")_$IP_$FOLDER.pid"

LOG="$LOGPATH$(basename "$0")_$IP_$FOLDER.log"
echo "$(date "+%F %H:%M:%S") RUN"  >> "$LOG" 2>&1

SLEEP_TIME=$((1 + $RANDOM % 10))
echo "$(date "+%F %H:%M:%S") SYNC STARTS IN $SLEEP_TIME SEC"  >> "$LOG" 2>&1
sleep "$SLEEP_TIME"

if [ -f "$PID" ]
    then
        echo "$(date "+%F %H:%M:%S") OTHER INSTANCE IS RUNNING, EXIT (0)" >> "$LOG" 2>&1
        exit 0
else
    touch "$PID"
fi

# override AXIS default password
if [ -z "$PASSWORD" ]
    then
        PASS="root"
    else
        PASS="$PASSWORD"
fi

# data server DST
if ! mountpoint "$DST" >/dev/null 2>&1
    then
        if ! mount -t cifs -o rw,vers=3.0,user=$DATA_SERVER_USER,pass=$DATA_SERVER_PASS //$DATA_SERVER_IP/$DATA_SHARED_DIR "$DST"
            then
                echo "$(date "+%F %H:%M:%S") DATA SERVER (HA-500) ERROR, EXIT (3)" >> "$LOG" 2>&1 && rm -rf "$PID" || exit 3
        fi
fi

# arrange files
for file in $(find "$DST$FOLDER"/tmp -type f); do
        DAY=$(echo $file | awk -F "/" '{print substr($NF,0,4)"-"substr($NF,5,2)"-"substr($NF,7,2)}') || echo "$(date "+%F %H:%M:%S") ERROR: FINDING THE DAY" >> "$LOG" 2>&1
        mkdir -p "$DST$FOLDER/$DAY" || echo "$(date "+%F %H:%M:%S") ERROR: CREATING DAILY FOLDER" >> "$LOG" 2>&1
        mv "$file" "$DST$FOLDER/$DAY" || echo "$(date "+%F %H:%M:%S") ERROR: MOVING FILES INTO DAILY FOLDER" >> "$LOG" 2>&1
done

# sync
mkdir -p "$SRC$FOLDER"
if ! mountpoint "$SRC$FOLDER" >/dev/null 2>&1
    mkdir -p "$DST$FOLDER"/tmp
    then
        sshfs root@"$IP":/var/spool/storage/SD_DISK "$SRC$FOLDER" -o reconnect -o StrictHostKeyChecking=no -o ssh_command="sshpass -p $PASS ssh -c aes128-ctr" &&\
        rsync "$RSYNC_OPTS" --exclude '*.xml' --exclude '*.db' "$SRC$FOLDER" "$DST$FOLDER"/tmp | tee -a "$LOG" 2>&1
    else
        rsync "$RSYNC_OPTS" --exclude '*.xml' --exclude '*.db' "$SRC$FOLDER" "$DST$FOLDER"/tmp | tee -a "$LOG" 2>&1
fi

# clean
umount "$SRC$FOLDER" || echo "$(date "+%F %H:%M:%S") ERROR: UNMOUNTING SRC FOLDER" >> "$LOG" 2>&1
rmdir "$SRC$FOLDER" || echo "$(date "+%F %H:%M:%S") ERROR: REMOVING SRC FOLDER" >> "$LOG" 2>&1
rm -rf "$PID" || echo "$(date "+%F %H:%M:%S") ERROR: REMOVING PID" >> "$LOG" 2>&1
rm -r "$DST$FOLDER".[1-9]* || echo "$(date "+%F %H:%M:%S") ERROR: REMOVING HIDDEN FILES" >> "$LOG" 2>&1
find "$DST$FOLDER" -empty -type f -delete || echo "$(date "+%F %H:%M:%S") ERROR: REMOVING EMPTY FILES" >> "$LOG" 2>&1
find "$DST$FOLDER" -empty -type d -delete || echo "$(date "+%F %H:%M:%S") ERROR: REMOVING EMPTY FOLDERS" >> "$LOG" 2>&1

echo "$(date "+%F %H:%M:%S") DONE, EXIT (0)" >> "$LOG" 2>&1

exit 0
