import gps
import gpxpy 
import gpxpy.gpx 
import sys
import os

f = open('gps_points.txt', 'w+')

#def add_gps_point(lat, lon, alt):
#	gpx_segment.points.append(gpxpy.gpx.GPXTrackPoint(lat, lon, elevation=alt))



# Listen on port 2947 (gpsd) of localhost
session = gps.gps("localhost", "2947")
session.stream(gps.WATCH_ENABLE | gps.WATCH_NEWSTYLE)
 
 
#gpx = gpxpy.gpx.GPX() 
# Create first track in our GPX: 
#gpx_track = gpxpy.gpx.GPXTrack() 
#gpx.tracks.append(gpx_track) 

# Create first segment in our GPX track: 
#gpx_segment = gpxpy.gpx.GPXTrackSegment() 
#gpx_track.segments.append(gpx_segment) 
 
while True:
    try:
    	report = session.next()
		# Wait for a 'TPV' report and display the current time
		# To see all report data, uncomment the line below
		# print report
        if report['class'] == 'TPV':
            if hasattr(report, 'time'):
            	s =  '{a},{b},{c}\n'.format(a=report.lat,b=report.lon,c=report.alt)
                #print s
            	f.write(s)
    except KeyError:
	pass
    except KeyboardInterrupt:
    	f.close()
	quit()
    except StopIteration:
	session = None
	print "GPSD has terminated"
	f.close()
	
