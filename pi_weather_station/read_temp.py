#!/usr/bin/python

from subprocess import check_output
import datetime

now = datetime.datetime.now()

str_date = str(now.year) + "-" + str(now.month) + "-" + str(now.day)
date = str(now.hour) + "-" + str(now.minute)

file_name = "/home/root/bsmith/" + str(str_date)

file = open(file_name, 'a')

r=check_output("cat /sys/module/bone_iio_helper/drivers/platform\:bone-iio-helper/helper.11/AIN1", shell=True)

temp_int=float(r)

temperature=temp_int/10

print "Temp is " + str(temperature) + "Degrees C"

far=float(9.0/5.0 * temperature + 32)

write_str = date + " " + str(far) + "\n"

file.write(write_str)

file.close()

print far


