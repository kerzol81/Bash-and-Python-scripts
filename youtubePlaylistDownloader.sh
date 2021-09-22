#!/bin/bash

option="-o %(playlist_index)s-%(title)s.%(ext)s"

echo "YouTube playlist downloader"
read -p '[+] Enter url: ' url

sleep 1

read -p '[+] Enter download directory: ' dir
mkdir -p "$dir" 
cd "$dir" || exit 1

youtube-dl "$option" "$url"

# wget https://raw.githubusercontent.com/kerzol81/Bash-and-Python-scripts/master/youtubePlaylistDownloader.sh -O /usr/local/bin/youtubePlaylistDownloader
# chmod 755 /usr/local/bin/youtubePlaylistDownloader
