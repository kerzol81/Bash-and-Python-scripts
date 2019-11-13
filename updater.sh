#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
NO_COLOR='\033[0m'

if [[ $EUID -ne 0 ]]; then
   printf "${RED}You must be root${NO_COLOR}\n" 
   exit 1
fi

ping -c 1 8.8.8.8 > /dev/null 2>&1

if [ $? -eq 2  ];then
	echo "${RED}No internet connection${NO_COLOR}\n"
	exit 0
else
	printf "${GREEN}Updating...${NO_COLOR}\n"
	sleep 3
	apt-get clean
	apt-get autoclean
	apt-get update
	apt-get --fix-broken install
	apt-get --download-only --yes upgrade
	apt-get autoremove
	printf "${GREEN}Done${NO_COLOR}\n"
fi
