#!/bin/bash

# USB 4G


TargetVendor=0x$(lsusb | grep -i huawei | awk '{print $6}' | awk -F ":" '{print $1}')

echo "$TargetVendor"
