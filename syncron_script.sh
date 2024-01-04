#!/bin/bash
set -x
source config

BASENAME=$(basename "$0")
LOGPATH="/usr/local/bin/log/" && mkdir -p "$LOGPATH"
PIDPATH="/usr/local/bin/pid/" && mkdir -p "$PIDPATH"
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
      echo "$(date "+%F %H:%M:%S") Invalid option: -${OPTARG} EXIT (1)"
      exit 1
      ;;
  esac
done

PID="$PIDPATH$(basename "$0")_$IP_$FOLDER.pid"
LOG="$LOGPATH$(basename "$0")_$IP_$FOLDER.log"

echo "$(date "+%F %H:%M:%S") RUN"  >> "$LOG" 2>&1
# SLEEP 1-10 sec
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

# override root passwords on axis devices 
if [ -z "$PASSWORD" ]
    then
        PASS="root"
    else
        PASS="$PASSWORD"
fi

# data server DST mount
if ! mountpoint "$DST" >/dev/null 2>&1
    then
        if ! mount -t cifs -o rw,vers=3.0,user=$DATA_SERVER_USER,pass=$DATA_SERVER_PASS //$DATA_SERVER_IP/$DATA_SHARED_DIR "$DST"
            then
                echo "$(date "+%F %H:%M:%S") DATA SERVER ERROR, EXIT (3)" >> "$LOG" 2>&1 && rm -rf "$PID" || exit 3
        fi
fi

# arrange files
for file in $(find "$DST$FOLDER"/tmp -type f); do
        DAY=$(echo $file | awk -F "/" '{print substr($NF,0,4)"-"substr($NF,5,2)"-"substr($NF,7,2)}')
        mkdir -p "$DST$FOLDER/$DAY"
        mv "$file" "$DST$FOLDER/$DAY"
done

# sync
mkdir -p "$SRC$FOLDER"
if ! mountpoint "$SRC$FOLDER" >/dev/null 2>&1
    mkdir -p "$DST$FOLDER"/tmp
    then
        sshfs root@"$IP":/var/spool/storage/SD_DISK "$SRC$FOLDER" -o reconnect -o StrictHostKeyChecking=no -o ssh_command="sshpass -p $PASS ssh -c aes128-ctr" &&\
        rsync $RSYNC_OPTS --exclude '*.xml' --exclude '*.db' "$SRC$FOLDER" "$DST$FOLDER"/tmp | tee -a "$LOG" 2>&1
    else
        rsync $RSYNC_OPTS --exclude '*.xml' --exclude '*.db' "$SRC$FOLDER" "$DST$FOLDER"/tmp | tee -a "$LOG" 2>&1
fi

# arrange new files
for file in $(find "$DST$FOLDER"/tmp -type f); do
        DAY=$(echo $file | awk -F "/" '{print substr($NF,0,4)"-"substr($NF,5,2)"-"substr($NF,7,2)}')
        mkdir -p "$DST$FOLDER/$DAY"
        mv "$file" "$DST$FOLDER/$DAY"
done

# clean
umount "$SRC$FOLDER"
rmdir "$SRC$FOLDER"
find "$DST$FOLDER" -empty -type f -delete
rm -rf "$PID"

echo "$(date "+%F %H:%M:%S") DONE EXIT (0)" >> "$LOG" 2>&1

exit 0
