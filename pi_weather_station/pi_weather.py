import urllib2
import json
import datetime

# Get the current conditions from Columbia
f = urllib2.urlopen('http://api.wunderground.com/api/f83d46c368361137/geolookup/conditions/q/MD/Columbia.json')

#open the data file to write to.
f_file = open('./data.dat','w')

# Read the response.
json_string = f.read()

# Parse the JSON response
parsed_json = json.loads(json_string)

# Grab the location data.
location = parsed_json['location']['city']

# grab the temp
temp_f = parsed_json['current_observation']['temp_f']

# just a temp print
print "Current temperature in %s is: %s" % (location, temp_f)

#another wind speed
wind = parsed_json['current_observation']['wind_mph']
print "Current Wind speed is: %s mph" % (wind)

# dew pt
dew_pt = parsed_json['current_observation']['dewpoint_f']
print "Current dew point is: %s mph" % (dew_pt)

# get the datetime
now = datetime.datetime.now()

# now just get the date
str_date = str(now.month) + "-" + str(now.day) + "-" + str(now.year)
st_date = str(str_date)

# format the output
st = st_date + " " + str(temp_f) + " " + str(wind) + " " + str(dew_pt) + "\n"

f_file.write(st)

# lets put this in this form: date_temp_wind_dew_
f_file.close()

