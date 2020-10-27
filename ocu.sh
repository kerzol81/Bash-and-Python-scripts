#!/bin/bash

# test !!!

i='/xxx/xxxxxxx/xxxxx/yyyyyyyyyyyyyyyyyyyyyyy.zzz' 

FILENAME=$(echo $i | awk -F '/' '{print $NF}')

if echo "$FILENAME" | egrep '^Rec[0-9]_[0-9]{8}_[0-9]{6}' >/dev/null
then
    DAY=$(echo $i | awk -F '/' '{print substr($NF,6,4)"-"substr($NF,10,2)"-"substr($NF,12,2)}')
    mkdir -p "$DAY"
    mv $FILENAME $DAY
fi
