#!/usr/bin/python
import httplib
import urllib
import urllib3
 
params = urllib.urlencode({'METHOD':'createuser', 'FirstName':'Jon', 'LastName':'Snow', 'Password':'test', 'PrincipalID':'3a1c8128-908f-4455-8157-66c96a46f75e'})
conn = httplib.HTTPConnection("localhost", 8003);
conn.request("POST", "/accounts", params)
response = conn.getresponse()
print(response.read();)

params = urllib.urlencode({'METHOD':'setpassword', 'PRINCIPAL' : '3a1c8128-908f-4455-8157-66c96a46f75e', 'PASSWORD':'bing'})
conn = httplib.HTTPConnection("localhost", 8003);
conn.request("POST", "/auth/plain", params)
response = conn.getresponse()
print(response.read();)

params = urllib.urlencode({'METHOD':'setaccount', 'FirstName':'Tyrion', 'PrincipalID':'3a1c8128-908f-4455-8157-66c96a46f75e'})
conn = httplib.HTTPConnection("localhost", 8003);
conn.request("POST", "/accounts", params)
response = conn.getresponse()
print(response.read();)

