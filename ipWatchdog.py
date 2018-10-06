"""
A friend of mine has asked me to write a quick solution to check if the his external IP has changed or not.
If the IP has changed, he'll recevie an email with the changed IP's URL to his home DVR.
It works, however it is a dirty and fast solution without much error checking.
"""

from requests import get
from time import sleep
import smtplib

freq = 1200  # sec

def getExternalIP():
    try:
        ip = get('https://api.ipify.org').text
        return ip
    except:
        pass


def sendEmail():
    fromemail= 'from@gmail.com'
    password = '*************'

    toemail = 'to@gmail.com'

    message = 'http://{}/your_dvr_url.html'.format(getExternalIP())

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login(fromemail, password)
    server.sendmail(fromemail, toemail, message)
    server.quit()


while True:
    before = getExternalIP()
    sleep(freq)
    after = getExternalIP()
    if before != after:
        sendEmail()
    else:
        continue
