#!/usr/bin/python

import os

def clear():
    os.system("clear")

def external_ip():
    fp = open('/home/pi/ip.txt','r')
    line=fp.readline()
    line.rstrip()
    return line

def run_infostation():
    clear()
    l = external_ip()
    print "External IP: " + l
    


if __name__ == "__main__":
    run_infostation()
