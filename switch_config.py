# !/usr/bin/env python3
#
# This script will run configuration commands from a file

# It can be useful in ensuring configuration
# consistency across our switches

from netmiko import Netmiko
from getpass import getpass


username = str(input('Username: '))
password = getpass()
conf_file = str(input('Config file path: '))

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

# put each line of the config file into a list
# and remove newline characters
with open(conf_file, 'r') as file:
    text = file.read()
    commands = text.split('\n')

    # connect to each device
    for switch in (SYDSW1, SYDSW2, CBRSW1):
        net_connect = Netmiko(**switch)
        net_connect.enable()
        print(net_connect.find_prompt())

        # and run the commands listed in our config file
        net_connect.send_config_set(commands)
        net_connect.disconnect()

    file.close()
