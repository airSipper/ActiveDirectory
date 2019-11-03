# ping our infrastructure

import os

devices = {

	'SYD-GW1': '172.16.5.254',
	'SYD-SW1': '172.16.5.253',
	'SYD-SW2': '172.16.5.252',
	'SYD-DC1': '172.16.5.1',
	'SYD-DC2': '172.16.5.2',
	'TAC01'  : '172.16.5.11',
	'CBR-GW1': '172.17.2.254',
	'CBR-SW1': '172.17.2.253',
	'TAC02'  : '172.17.2.11'
}

for name, ip in devices.items():
	os.system('ping -c2 ' + ip)
