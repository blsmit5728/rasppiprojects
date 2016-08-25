#!/usr/bin/env python
"""
Environment:
    Raspberry Pi Model B with Piface Digital Attachment
    Raspbian
    
Very simple HTTP server in python.
Usage::
    ./garage_door.py [<port>]
Send a GET request::
    curl http://localhost
Send a HEAD request::
    curl -I http://localhost
Send a POST request::
    curl -d "foo=bar&bin=baz" http://localhost
"""
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import SocketServer
import pifacedigitalio as p
import time
import signal, os

# Init Pushbullet API from key file to hide API key. :-)
from pushbullet import Pushbullet
f = open('pb.key','r')
key = f.readline()
pb = Pushbullet(key)

DOOR_OPEN = 0
DOOR_CLOSED = 1

# Define Signal Handler for CTRL-c and others
def handler(signum, frame):
    print "Signal Handler has been called with signal", signum
    sys.exit(1)

# Function to toggle relay for the door.
def toggle_door():
    p.digital_write(0,1)
    time.sleep(.5)
    p.digital_write(0,0)

class S(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        # Get the state of the door
        state = p.digital_read(0)
        if state is DOOR_OPEN:
            # Reply to the HTTP
            self.wfile.write("Open\n")
        else:
            # Reply to the HTTP
            self.wfile.write("Closed\n")

    def do_HEAD(self):
        self._set_headers()
        
    def do_POST(self):
        # Doesn't do anything with posted data
        self._set_headers()
        # Read the current state of the Door
        state = p.digital_read(0)
        # Prepare Pushbullet Response
        text = "[Garage Door] "
        if state is DOOR_CLOSED:
            # We are Opening the door
            text += "Opened"
            # Toggle the Relay
            toggle_door()
            # Since it was closed, only wait a second to see if it opened.
            time.sleep(1)
            # Read the state of the door again
            state = p.digital_read(0)
            # Check the state
            if state is DOOR_OPEN:
                # Push a Note on the state Change
                push = pb.push_note(text, "")
                # Reply to the HTTP packet.
                self.wfile.write("Door Closed!\n")
            else:
                # Push a Note on the state Change
                push = pb.push_note("[Garage Door] Error", "Could Not tell if the door is open or not!")
                # Reply to the HTTP packet.
                self.wfile.write("ERROR\n")
        else:
            # We are Closing the door
            text += "Closed"
            toggle_door()
            time.sleep(10)
            state = p.digital_read(0)
            if state is DOOR_CLOSED:
                # Push a Note on the state Change
                push = pb.push_note(text, "")
                # Reply to the HTTP packet.
                self.wfile.write("Door Closed!\n")
            else:
                # Push a Note on the state Change
                push = pb.push_note("[Garage Door] Error", "Could Not tell if the door is open or not!")
                # Reply to the HTTP packet.
                self.wfile.write("ERROR\n")
    
    def log_message(self, format, *args):
        return
        
def run(server_class=HTTPServer, handler_class=S, port=80):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print 'Starting httpd...'
    httpd.serve_forever()

if __name__ == "__main__":
    from sys import argv
    
    signal.signal(signal.SIGINT, handler)
    signal.signal(signal.SIGILL, handler)
    signal.signal(signal.SIGSEGV, handler)
    
    # Init the PiFaceDigital IO library/hardware    
    p.init()
    # set output for Garage Sense
    p.digital_write(7,1)
    
    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()
