import sys

def isPrime(num):
    try:
        assert isinstance(num, int) and num > 0

    except AssertionError:
        print('[-] Error: enter a positive integer')
        sys.exit(1)

    if num == 0 or num == 1:
        print('[-] 1 or 0 ar not primes')

    else:
        for a in range(2, num):

            if num % a == 0:
                print('[-] ' + str(num) + ' is not prime')
                break
            else:
                print('[*] ' + str(num) + ' is prime')
                break
