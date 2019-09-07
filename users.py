import random
import csv

# Read the name file and strip newline characters
name_file = open("firstnames.txt", "r")
names_read = name_file.readlines()
names = [name.strip("\n") for name in names_read]

# Read all the surnames and capitalise only the first character
lname_file = open("lastnames.txt", "r")
lnames_read = lname_file.readlines()
lnames = [lname.strip("\n").capitalize() for lname in lnames_read]


class User:
	""" a class for our AD users """
	def __init__(self, first, last):
		self.first = first
		self.last = last
		self.uname = ".".join([first[0], last])
		self.passwd = "Pass@word01"
		self.ou = ""
		self.site = ""

ou_str = "OU={}, OU={}, DC=Piedpiper, DC=COM"
it_ou_str = "OU={}, OU={}, OU={}, DC=Piedpiper, DC=COM"

# we'll put our user objects here
users = []

# create n random usernames
for i in range(559):
	users.append(User(random.choice(names), random.choice(lnames)))

	if i < 501:
		users[i].site = "SYDNEY"
	
	if i > 500:
		users[i].site = "CANBERRA"

	if i < 50 or i in range(501, 507):
		users[i].ou = ou_str.format("Managers", users[i].site)

	if i in range(50, 150) or i in range(507, 517):
		users[i].ou = ou_str.format("Accounting", users[i].site)

	if i in range(150, 250) or i in range(517, 530):
		users[i].ou = ou_str.format("Design", users[i].site)

	if i in range(250, 350) or i in range(530, 542):
		users[i].ou = ou_str.format("HR", users[i].site)

	if i in range(350, 450) or i in range(542, 554):
		users[i].ou = ou_str.format("Admin", users[i].site)

	if i in range(450, 460) or i in range(554, 556):
		users[i].ou = it_ou_str.format("Level1", "IT", users[i].site)

	if i in range(460, 480) or i in range(556, 558):
		users[i].ou = it_ou_str.format("Level2", "IT", users[i].site)

	if i in range(480, 501) or i in range(558, 561):
		users[i].ou = it_ou_str.format("Level3", "IT", users[i].site)


# send our data to file
with open('users.csv', mode='w') as employee_file:
	employee_writer = csv.writer(employee_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
	employee_writer.writerow(["firstname", "lastname", "username", "password", "ou"])
	for user in users:
		employee_writer.writerow([user.first, user.last, user.uname, user.passwd, user.ou])


