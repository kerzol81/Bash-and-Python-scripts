import requests
from requests.auth import HTTPBasicAuth


def inhand_io_on(ip='192.168.2.1', username='adm', password='123456'):
    if not isinstance(ip, str):
        print('not string')
    try:
        payload ='_ajax=1&_web_cmd=%21%0Aio%20output%201%20on%0A'
        r = requests.post('http://{}/apply.cgi'.format(ip), auth=HTTPBasicAuth(username, password), data=payload, timeout=3)
        if r.status_code == 200:
            print('{} : IO ON'.format(ip))
        elif r.status_code == 401:
            print('{} : Auth error'.format(ip))
        else:
            print(r.status_code)

    except Exception as e:
        print(e)


def inhand_io_off(ip='192.168.2.1', username='adm', password='123456'):
    try:
        payload = '_ajax=1&_web_cmd=%21%0Aio%20output%201%20off%0A'
        r = requests.post('http://{}/apply.cgi'.format(ip), auth=HTTPBasicAuth(username, password), data=payload, timeout=3)
        if r.status_code == 200:
            print('{} : IO OFF'.format(ip))
        elif r.status_code == 401:
            print('{} : Auth error'.format(ip))
        else:
            print(r.status_code)
    except Exception as e:
        print(e)

def get_logo():
    a = "http://192.168.144.1/products/global/English-logo.png"
    r = requests.get(a)
    print(r.status_code)
