#!/usr/bin/env python3
#
# this script connects to all our networking devices and 
# writes their running-config to file [[date]_[device ip].txt]
#
# Credentials will be checked against either the local device database OR the TACACS servers

from netmiko import Netmiko
from datetime import date
from getpass import getpass

username = str(input('Username: '))
password = getpass()

SYDGW = {
    "host": "172.16.5.254",
    "username": username,
    "password": password,
    "device_type": "cisco_ios",
	"secret": password
}

SYDSW1 = {
    "host": "172.16.5.253",
    "username": username,
    "password": password,
    "device_type": "cisco_ios",
	"secret": password
}

SYDSW2 = {
    "host": "172.16.5.252",
    "username": username,
    "password": password,
    "device_type": "cisco_ios",
	"secret": password

}

CBRGW = {
    "host": "172.17.2.254",
    "username": username,
    "password": password,
    "device_type": "cisco_ios",
	"secret": password

}

CBRSW1 = {
    "host": "172.17.2.253",
    "username": username,
    "password": password,
    "device_type": "cisco_ios",
	"secret": password
}

for device in (SYDGW, SYDSW1, SYDSW2,CBRGW, CBRSW1):
	net_connect = Netmiko(**device)
	net_connect.enable()
	print(net_connect.find_prompt())

	output = net_connect.send_command("show run")
	net_connect.disconnect()

	print(output)
	print()

	f = open(str(date.today() + "_" + (device["host"] + '.txt')), 'w')

	f.write(output)
	f.close()
