import os
import time
from distutils.dir_util import copy_tree
import shutil

config = r'C:\Program Files (x86)\Ozeki\OzekiNG - SMS Gateway\Config'
users = r'C:\Program Files (x86)\Ozeki\OzekiNG - SMS Gateway\Users'
logs = r'C:\Program Files (x86)\Ozeki\OzekiNG - SMS Gateway\Logs'

backupDir = r'S:\SMSGatewayBackups'
maxdays = 3

def get_time():
    return time.strftime("%Y-%m-%d")


def get_exact_time():
    return time.strftime("%Y-%m-%d %H:%M:%S")

def backup(src, dst):
    os.chdir(dst)
    today = str(get_time())
    if not os.path.exists(today):
        os.mkdir(today)
    os.chdir(today)
    copy_tree(src, src.split('\\')[-1])
    os.chdir(backupDir)
    clean()

def get_oldest_folder(folder='.'):
    return min(os.listdir(folder), key=lambda f: os.path.getctime("{}/{}".format(folder, f)))

def clean():
    os.chdir(backupDir)
    if len(os.listdir(backupDir)) >= int(maxdays) + 1:
        shutil.rmtree(get_oldest_folder(backupDir), ignore_errors=True)
        print('[-] 1 backup day removed ' + time.strftime("%Y-%m-%d %H:%M:%S"))

def main():
    print('[*] OZEKI  SMS Server Backup script started ' + get_exact_time())
    backup(config, backupDir)
    backup(users, backupDir)
    backup(logs, backupDir)
    print('[+] Backup Done! ' + time.strftime("%Y-%m-%d %H:%M:%S"))

main()
