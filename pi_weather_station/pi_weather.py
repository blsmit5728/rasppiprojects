import urllib2
import json
f = urllib2.urlopen('http://api.wunderground.com/api/f83d46c368361137/geolookup/conditions/q/MD/Columbia.json')
g = urllib2.urlopen('http://api.wunderground.com/api/f83d46c368361137/geolookup/conditions/q/MD/Gaithersburg.json')
json_string = f.read()
json_string_g = g.read()
parsed_json = json.loads(json_string)
parsed_json_g = json.loads(json_string_g)
location = parsed_json['location']['city']
location_g = parsed_json_g['location']['city']
temp_f = parsed_json['current_observation']['temp_f']
temp_f_g = parsed_json_g['current_observation']['temp_f']
print "Current temperature in %s is: %s" % (location, temp_f)
print "Current temperature in %s is: %s" % (location_g, temp_f_g)

wind = parsed_json['current_observation']['wind_mph']
print "Current Wind speed is: %s mph" % (wind)

f.close()
