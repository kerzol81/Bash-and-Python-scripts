#!/bin/sh

PID=$(pgrep arecord)

if [ "$PID" == "" ] ; then
        echo "1:200:$service is not running."
else
        echo "0:200:$service is running."
fi
