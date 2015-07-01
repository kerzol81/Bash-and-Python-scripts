#!/usr/bin/python

import os


dm = """
## DEBIAN MULTIMEDIA
deb http://www.deb-multimedia.org stable main non-free
"""

print "The script will add\n", dm, "\nto : /etc/apt/sources.list and install AVIDEMUX"

if os.geteuid() != 0:
    exit("\nYou need to be root. Exiting")

print "\nPress any key to continue, Ctrl-C to exit"
raw_input("> ")

f=open("/etc/apt/sources.list",'a+')
f.write(dm)
f.close()

os.system("apt-get install debian-keyring")
os.system("gpg --keyserver pgp.mit.edu --recv-keys 5C808C2B65558117")
os.system("gpg --armor --export 5C808C2B65558117 | apt-key add -")
os.system("apt-get update -y")
os.system("apt-get install avidemux -y")
