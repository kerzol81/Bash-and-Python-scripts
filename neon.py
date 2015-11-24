#!/usr/bin/pthon

import time
import os


def neon(s):
  x = 0
  while x <= len(s):
  os.system("clear")
  print s[:x]
  x = x + 1
  time.sleep(0.1)

s = 'hello world'

neon(s)
