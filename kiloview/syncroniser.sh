#!/bin/sh
set -x

MAC=$(ip a | grep ether | head -1 | awk '{print $2}' | sed 's/:/-/g')
CONFIG="/usr/bin/syncroniser.cfg"
KEY="/usr/bin/dropbear_rsa_host_key"
SRC="/media/sdmmc/mmcblk0p1/RECORD/"
DST="$MAC"
FREQ=60

sync(){  
        while true
                do
                        if test -f "$CONFIG"; then
                                . "$CONFIG"
                        fi
                        rsync --remove-source-files -azve "ssh -p $REMOTE_PORT -i $KEY" $SRC $REMOTE_USER@$REMOTE_IP:$DST
                        sleep $FREQ
                done
}

main(){
        sync  
}

main
