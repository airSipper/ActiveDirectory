 ### For this project we were tasked with
 
- connecting two sites with a Cisco site-to-site IPsec VPN 
- configuring dynamic routing (EIGRP) through the VPN tunnel
- configure inter-VLAN routing at each site
- configure AAA for our networking devices
- build and configure a multi-site Active Directory Domain on top of the network infrastructure


### The Beginning
After spending some time rebuilding an Active Directory environment on another project, I'd vowed in future to have scripts together to help rebuild my environments should the need arise.

The domain's user base for this project was quite small at only around 560 users. I broke this number down further to represent the different AD organisational units. 

#### users.py
This script uses two files, firstnames.txt and lastnames.txt. A user object is defined and from these files, we create 560 user instances with a randomly chosen name. The first 500 users are assigned an AD site of Sydney, the remaining users are assigned a site of Canberra. It then goes and assigns the user a particular OU and defines the LDAP path for that OU/User. Once all our users are created, the user object data is just written to a .csv file that is later imported into powershell. 

So that was great, I had the list of users.

#### user_ou.ps1
This script creates the AD Organisational Unit structure for our domain. It first defines the path to the users.csv file that was just created. It then defines the two sites, Sydney and Canberra. For simplicity, I decided I would just replicate the OU struture at both sites. For each site, the site-OU itself is created, then the remaining OUs are added to the site. I implemented a 3-tier IT OU. The logic here is the same, just loop through and create the 3 tiers within that site's IT OU.

After the OUs are created, the script goes through the list of users and simply adds them to Active Directory based on their OU and site information. At this point I feel pretty happy, just run this on the DC and everything is great right? Mmmm maybe, what about security groups?

#### groups.ps1
This script is verbose. Time was tight at this point and I had plenty of other things to be working on so verbose had to do. It starts out by creating the top-level group for the domain. To this, it then adds the site-top-level groups and, to those, it adds a global security group for each of the organisational units. Once it's finished creating all the security groups, it then goes through and retrieves the users in an OU and adds them to the appropriate security group.

That was more or less it for the domain.

### AAA
Our group was tasked with setting up AAA for access to our networking devices. I'd read about RADIUS and TACACS. I decided that it would be really great to see the actual commands being run on the devices so we deployed a TACACS server at both sites. Every device on the network had both server IPs in their configuration. If the server at Sydney went down, authentication requests would be sent to the Canberra TACACS server. It was also setup so that if both servers were down you were forced to console in. The servers themselves were Ubuntu 18.04 with the tacacs+ package installed. 

For a user to access a networking device, they had to have a) initial access to the ITADMIN VLAN b) a user entry and permissions set in the TACACS+ config file and c) an actual account on the Ubuntu server against which the user's credentials were authenticated. I'd set TAC+ Users from each site's level-3 IT department had full access to the devices, while the level-2 staff were only permitted to run 'show' commnads. 


#### pw_gen.py
I'd installed the pam_pwquality module on the servers to force complex passwords. I planned to create all the user accounts with passwords and then disable the account, only enabling it when a user requires it. In anticipation of this, i wrote a simple password generator that matches the settings I'd set in pam_pwquality. I reasoned with myself that having 2 non-domain-joined servers was a good idea, in that, if an IT Admin's domain credentials were ever compromised, this wouldn't necessarily mean that the infrastructure itself would be compromised.

### Random other things
#### switch_config.py
Netmiko script that would read IOS commands from a file and run them on all the devices

#### ping_infr.py
Simply pings the router IPs and switch SVIs

#### getconfigs.py
Netmiko script that issues 'show run' to each device and saves the output to file. 

#### nodes.py
A random script I made using the python Networkz module, to help visualise Access Control Lists
