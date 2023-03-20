#!/bin/bash

set -x

unzip "*.zip"

find . -name *.mp4 -exec cp {} /run/user/1000/gvfs/smb-share:server=192.168.50.100,share=video \;

rm -rf Takeout

rm *.zip
