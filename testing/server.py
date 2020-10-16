#!/usr/bin/env python3

# Import of python system libraries.
# These libraries will be used to create the web server.
# You don't have to install anything special, these libraries are installed with Python.
import http.server
import socketserver
import os

# This variable is going to handle the requests of our client on the server.
handler = http.server.SimpleHTTPRequestHandler

print("App started")


print(os.environ['version'])
print("Server version: {s}".format(s=os.environ['version']))
# Here we define that we want to start the server on port 1234. 
# Try to remember this information it will be very useful to us later with docker-compose.
with socketserver.TCPServer(("", 1234), handler) as httpd:
    # This instruction will keep the server running, waiting for requests from the client.
    print("Server version 14ss : {s}".format(s=os.environ['version']))
    httpd.serve_forever()

