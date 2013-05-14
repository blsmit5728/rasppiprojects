import sys

f = open('/home/pi/data.dat')

lines = f.readlines()

f.close()

for i in lines:
    split_line = i.split(' ')
    date = split_line[0]
    day_list = date.split('-')
    day = day_list[1]
    print day


