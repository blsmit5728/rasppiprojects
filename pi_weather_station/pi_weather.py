#!/usr/bin/python


import urllib2
import json
import datetime

# Get the current conditions from Columbia
f = urllib2.urlopen('http://api.wunderground.com/api/f83d46c368361137/geolookup/conditions/q/MD/Columbia.json')

#open the data file to write to.
f_file = open('/home/bsmith/repos/rasppiprojects/pi_weather_station/data.dat','a')
rain_file = open('/home/bsmith/repos/rasppiprojects/pi_weather_station/rain.dat','a')

# Read the response.
json_string = f.read()

# Parse the JSON response
parsed_json = json.loads(json_string)

# Grab the location data.
location = parsed_json['location']['city']

# grab the temp
temp_f = parsed_json['current_observation']['temp_f']

#grab the rainfall 
rain = parsed_json['current_observation']['precip_today_in']

# just a temp print
print "Current temperature in %s is: %s" % (location, temp_f)

#another wind speed
wind = parsed_json['current_observation']['wind_mph']
print "Current Wind speed is: %s mph" % (wind)

# dew pt
dew_pt = parsed_json['current_observation']['dewpoint_f']
print "Current dew point is: %s mph" % (dew_pt)

wc_pt = parsed_json['current_observation']['windchill_f']
print "Current dew point is: %s mph" % (wc_pt)
# get the datetime
now = datetime.datetime.now()

# now just get the date
str_date = str(now.month) + "-" + str(now.day) + "-" + str(now.year) + "-" + str(now.hour)
st_date = str(str_date)

# format the output
st = st_date + " " + str(temp_f) + " " + str(wind) + " " + str(dew_pt) + " " + str(wc_pt) + "\n"

#make a rain string
rain_str =  st_date + " " +  str(rain) + "\n"

#write the files
f_file.write(st)
rain_file.write(rain_str)

# lets put this in this form: date_temp_wind_dew_
f_file.close()
rain_file.close()

