# generate n random passwords that fit 
# the password strength we've set in pam_pwquality

import string
import random
import sys

pw_len = 14
lower = string.ascii_lowercase
upper = string.ascii_uppercase
number = string.digits
symbol = ['!', '@', '#', '$', '%', '&']

def main():

	passwords = []	

	try:
		npw = int(input('How many random passwords?: '))

	except:

		print('Error... Quitting')
		sys.exit(0)

	for _ in range(npw):
		passwords.append(create_pw())

	for password in passwords:
		print(password)
		


def create_pw():
	
	chars = []

	while len(chars) < pw_len:

		chars.append(random.choice(upper))
		chars.append(random.choice(lower))
		chars.append(random.choice(symbol))
		chars.append(random.choice(number))

	random.shuffle(chars)

	return "".join(chars)


if '__name__' == '__main__':
	main()
