from checksumdir import dirhash
import time

dir = ' '


def currenttime():
    return str(time.strftime("%Y-%m-%d %H:%M:%S"))

def createfile(dir, hash):
    pass

def md5(dir):
    print('[+] Calculating MD5 hash on : ' + dir + ' directory, started at: ' + currenttime())
    md5hash = dirhash(dir, 'md5')
    md5hash = '[+] MD5 hash: ' + md5hash[:8] + ' ' + md5hash[8:16] + ' ' + md5hash[16:24] + ' ' + md5hash[24:]
    print(md5hash)
    createfile(dir, md5hash)

