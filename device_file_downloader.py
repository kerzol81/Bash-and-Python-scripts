from ftplib import FTP
import os
import sys
import time

def download(ip, username, password, device_id='TEST'):
    """
    Downloads files from server into daily folders --> the day when the file was created

    :param ip: '10.0.0.10'
    :param username: 'root'
    :param password: 'root'
    :param device_id: 'test1'
    :return: None
    """
    delete_remote_files = True   # set it to false to keep the remote files on server
    remote_path = "/data/"
    local_path = device_id

    try:
        print('[*] FTP into ID: {}'.format(device_id))
        ftp = FTP(ip)
        ftp.login(username, password)
        ftp.cwd(remote_path)
        remote_files = ftp.nlst()
        remote_files.remove('.')
        remote_files.remove('..')
        remote_files.remove('.tmp')
        data = {}

        if len(remote_files) == 0:
            print('[-] There are no files the device')
            ftp.quit()
        if not os.path.exists(local_path):
            os.makedirs(local_path)

        for file in sorted(remote_files):
            data['remote_filename'] = file
            data['file_creation_day'] = str(ftp.sendcmd("MDTM {}".format(file))).split(' ')[1][0:8]
            if not os.path.exists(data['file_creation_day']):
                os.makedirs(data['file_creation_day'])
            os.chdir(device_id + '/' + data['file_creation_day'])

            if find_local(data['remote_filename']) is None:
                print('[+] Downloading: {} > {}'.format(data['remote_filename'], data['file_creation_day']))
                ftp.retrbinary('RETR ' + data['remote_filename'], open(data['remote_filename'], 'wb').write)
                if delete_remote_files:
                    ftp.delete(data['remote_filename'])
            os.chdir('..')
        print("[*] Closing connection")
        ftp.close()

    except Exception as e:
        print(e)
        sys.exit(1)


def find_local(file):
    for root, dirs, files in os.walk('.'):
        if file in files:
            return os.path.join(root, file)
