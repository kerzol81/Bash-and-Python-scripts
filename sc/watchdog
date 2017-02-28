import os
import time
import smtplib

folder = "."
before = dict([(f, None) for f in os.listdir(folder)])

def sendMail():
    fromaddr = 'xyz@gmail.com'
    toaddrs = 'xyz@gmail.com'
    msg = 'Subject: {}\n\n{}'.format(date, 'Uj fajl erkezett a :' + os.getcwd() + ' mappaba, fajl nev: ' + str(added))
    username = 'xyz@gmail.com'
    password = 'password'
    server = smtplib.SMTP('smtp.gmail.com:587')
    server.ehlo()
    server.starttls()
    server.login(username, password)
    server.sendmail(fromaddr, toaddrs, msg)
    server.quit()


while True:
      time.sleep(10)
      after = dict ([(f, None) for f in os.listdir(folder)])
      added = [f for f in after if not f in before]
      removed = [f for f in before if not f in after]
      if added:
          date = time.strftime("%Y-%m-%d %H:%M:%S")
          print(date + ' , Uj fajl erkezett a ' + os.getcwd() + ' mappaba, fajl nev: ' + str(added))
          before = after
          sendMail()
