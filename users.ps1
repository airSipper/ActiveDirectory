
<#
	Create our OU structure and users
	requires users.csv on administrators desktop with 
	column headings: firstname, lastname, username, password, ou
#>


Import-Module ActiveDirectory


$usr_filepath = "C:\Users\Administrator\Desktop\users.csv"
$domain = "Piedpiper"
$sites = @("CANBERRA", "SYDNEY")

$ADUsers = Import-csv $usr_filepath
$OUs = @("Managers", "Accounting", "Design", "HR", "Admin", "IT")
$tiers = @("Level1", "Level2", "Level3")


# Add the two sites and add the OUs
foreach ($site in $sites){

	# Create the two sites
	New-ADOrganizationalUnit -Name $site -Path "DC=$domain, DC=COM" -ProtectedFromAccidentalDeletion $True
	
	# Add the OUs
	foreach ($OU in $OUs){
	New-ADOrganizationalUnit -Name $OU -Path "OU=$site, DC=$domain, DC=COM" -ProtectedFromAccidentalDeletion $True
	}

	# Add tiers to our IT department
	foreach ($tier in $tiers){
	New-ADOrganizationalUnit -Name $tier -Path "OU=IT, OU=$site, DC=$domain, DC=COM" -ProtectedFromAccidentalDeletion $True	
	}
}

# Create our users and put them in an OU
foreach ($User in $ADUsers){

       $Username    = $User.username
       $Password    = $User.password
       $Firstname   = $User.firstname
       $Lastname    = $User.lastname
       $OU          = $User.ou

       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username}){

               #If user does exist, output a warning
               Write-Warning "A user account $Username has already exist in Active Directory."
       }

       else{
              #If a user does not exist then create a new user account
           
             #Account will be created in the OU listed in the $OU variable in the CSV file
             New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$domain.com" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -ChangePasswordAtLogon $True `
            -DisplayName "$Firstname $Lastname" `
            -Path $OU `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
       }
}
