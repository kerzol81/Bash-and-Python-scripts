import os
import datetime

def get_mdate(f):
    """Returns file creation day in YYYY-MM-DD format"""
    try:
        t = os.path.getmtime(f)
    except FileNotFoundError:
        return False
    return (str(datetime.datetime.fromtimestamp(t)).split(' ')[0])
