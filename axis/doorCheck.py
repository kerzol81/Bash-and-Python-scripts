import requests
import time
import subprocess


def check_door():
    url = "http://192.168.0.90/axis-cgi/io/port.cgi"

    querystring = {"check": "1"}

    payload = ""
    headers = {'authorization': 'Basic xxxxxxxx=='}

    response = requests.request("GET", url, data=payload, headers=headers, params=querystring)

    return int(response.text.split("=")[1])


while True:
    state = check_door()
    if state is 0:
        print("open")
        subprocess.call(['notify-send', 'App Title', 'Message'])


    time.sleep(5)
