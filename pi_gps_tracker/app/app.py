#!/usr/bin/python

import serial
import pynmea2
import time
from ISStreamer.Streamer import Streamer

serialStream = serial.Serial("/dev/ttyAMA0", 9600, timeout=0.5)

streamer = Streamer(bucket_name="GPS Tracker", bucket_key="GPS_Tracker_20151126", ini_file_location="./isstreamer.ini")

try:
    while True:
        sentence = serialStream.readline()
        if sentence.find('GGA') > 0:
            data = pynmea2.parse(sentence)
            print "{time}: {lat},{lon}".format(time=data.timestamp,lat=data.latitude,lon=data.longitude)
            streamer.log("Location", "{lat},{lon}".format(lat=data.latitude,lon=data.longitude))
            streamer.log("Altitude ({unit})".format(unit=data.altitude_units), data.altitude)
except KeyboardInterrupt:
    streamer.close()


    
