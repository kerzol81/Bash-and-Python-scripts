from checksumdir import dirhash
import time

dir = '/testdir'


def currenttime():
    return str(time.strftime("%Y-%m-%d %H:%M:%S"))


def md5(dir):
    print('[+] Calculating MD5 hash on : ' + dir + ' directory, started at: ' + currenttime())
    md5hash = dirhash(dir, 'md5')
    md5hash = '[+] MD5 hash: ' + md5hash[:8] + ' ' + md5hash[8:16] + ' ' + md5hash[16:24] + ' ' + md5hash[24:]
    print(md5hash)
    f = open(dir + '_hash_' + str(time.strftime("%Y-%m-%d_%H-%M-%S")) + '.txt', 'w')
    text = 'Directory: ' + dir + '\n' + md5hash[4:] + '\nDate: ' + currenttime()
    f.write(text)
    f.close()

def sha256(dir):
    print('[+] Calculating SHA256 hash on : ' + dir + ' directory, started at: ' + currenttime())
    sha256hash = dirhash(dir, 'sha256')
    sha256hash = '[+] SHA256 hash: ' + sha256hash[:8] + ' ' + sha256hash[8:16] + ' ' + sha256hash[16:24] + ' ' + sha256hash[24:32] + ' ' + sha256hash[32:40] + ' ' + sha256hash[40:48] + ' ' + sha256hash[48:56] + ' ' + sha256hash[56:64]
    print(sha256hash)
    f = open(dir + '_hash_' + str(time.strftime("%Y-%m-%d_%H-%M")) + '.txt', 'w')
    text = 'Directory: ' + dir + '\n' + sha256hash[4:] + '\nDate: ' + currenttime()
    f.write(text)
    f.close()

sha256(dir)
