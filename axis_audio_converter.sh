#!/bin/bash

# Converts the input file to Axis Camera's appropriate audio format

f=$1

ffmpeg -i "$f" -acodec pcm_s16le -ac 1 -ar 8000  "$f".wav

exit 0
