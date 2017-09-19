#!/usr/bin/env bash
# experimental script
#set -x

# videoserver settings:
AXIS_IP=$1
USERNAME=$2
PASSWORD=$3
ID=$

# email settings:
SMTP_SERVER=$5
TO=$6
FROM=$7
EMAIL_USERNAME=$8

# script settings:


function sendRestartMessage(){
	local MESSAGE="status: $AXIS_IP disconnected, restart $ID"
	swaks --to "$TO" --from "$FROM" --server "$SMTP_SERVER" --header "Subject: $ID disconnected" --body "$MESSAGE" >/dev/null
}

function sendOKMessage(){
	local MESSAGE="status: $AXIS_IP connected"
	swaks --to "$TO" --from "$FROM" --server "$SMTP_SERVER" --header "Subject: $ID connected" --body "$MESSAGE" >/dev/null
}

function writeToSyslog(){
	# writes to syslog
	logger "$ID" "is" "$STATE" 
	}

function parseSyslog(){
	# searching for the sring "is disconnected" in last 60 minutes of syslog file
	disconnected=$(awk "/^$(date --date="-60 min" "+%b %_d %H:%M")/{p++} p" /var/log/syslog | grep -c "$ID is disconnected")
	
	if [ "$disconnected" -gt 3 ];then
		echo "sending email"
	
	fi
}

function queryAPI(){
	curl -m 3 -X GET http://"$USERNAME":"$PASSWORD"@"$AXIS_IP"/axis-cgi/videostatus.cgi?status=1,2,3,4 >/dev/null
}

function restartAPI(){
	curl -m 3 -X GET http://"$USERNAME":"$PASSWORD"@"$AXIS_IP"/axis-cgi/restart.cgi
}

function main(){

STATE=""

queryAPI

if [ "$?" -ne 0 ]; then
	
		STATE="disconnected"
		echo "$ID" "state:" "$STATE"
		sendRestartMessage
		writeToSyslog
		restartAPI
else
		STATE="connected"
		echo "$ID" "state:" "$STATE"
		sendOKMessage
		writeToSyslog
fi

}

main


