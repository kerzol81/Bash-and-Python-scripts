from checksumdir import dirhash
import time

dir = 'C:\\Users\\zoli\\Desktop\\testdir'

print('[+] Calculating MD5 hash on : ' + dir + ' directory, started at: ' + str(time.strftime("%Y-%m-%d %H:%M:%S")))

md5hash = dirhash(dir, 'md5')

message = '[+] Directory: ' + dir + ' \n[+] MD5 hash: ' + md5hash[:8] + ' ' + md5hash[8:16] + ' ' + md5hash[16:24] + ' ' + md5hash[24:] \
          + ' \n[+] Creation time: ' + str(time.strftime("%Y-%m-%d %H:%M:%S"))

print('[+] Done!')
print(message)

