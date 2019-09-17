#!/usr/bin/env python
#
# this script connects to all our networking devices and 
# writes their running-config to file [[device ip].conf]

from netmiko import Netmiko
#from getpass import getpass


SYDGW = {
    "host": "172.16.5.254",
    "username": 'admin',
    "password": 'Password01',
    "device_type": "cisco_ios",
	"secret": "Password01"
}

SYDSW1 = {
    "host": "172.16.5.253",
    "username": 'admin',
    "password": 'Password01',
    "device_type": "cisco_ios",
	"secret": "Password01"
}

SYDSW2 = {
    "host": "172.16.5.252",
    "username": 'admin',
    "password": 'Password01',
    "device_type": "cisco_ios",
	"secret": "Password01"

}

CBRGW = {
    "host": "172.17.2.254",
    "username": 'admin',
    "password": 'Password01',
    "device_type": "cisco_ios",
	"secret": "Password01"

}

CBRSW1 = {
    "host": "172.17.2.253",
    "username": 'admin',
    "password": 'Password01',
    "device_type": "cisco_ios",
	"secret": "Password01"
}

for device in (SYDGW, SYDSW1, SYDSW2,CBRGW, CBRSW1):
	net_connect = Netmiko(**device)
	net_connect.enable()
	print(net_connect.find_prompt())

	output = net_connect.send_command("show run")
	net_connect.disconnect()

	print(output)
	print()

	f = open(device["host"] + '.conf', 'w')

	f.write(output)
