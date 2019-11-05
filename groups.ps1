# ********************* SYDNEY *******************************

New-ADGroup -name 'PiedPiper_GG' -groupscope global
New-ADGroup -name 'PP_Sydney_GG' -groupscope global -path 'OU=SYDNEY, DC=Piedpiper, DC=COM'

New-ADGroup -name 'SYD_Accounting_gg' -groupscope global -path 'OU=Accounting, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_Admin_gg' -groupscope global -path 'OU=Admin, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_Design_gg' -groupscope global -path 'OU=Design, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_HR_gg' -groupscope global -path 'OU=HR, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_Managers_gg' -groupscope global -path 'OU=Managers, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_IT_gg' -groupscope global -path 'OU=IT, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_IT1_gg' -groupscope global -path 'OU=Level1, OU=IT, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_IT2_gg' -groupscope global -path 'OU=Level2, OU=IT, OU=SYDNEY, DC=Piedpiper, DC=com'
New-ADGroup -name 'SYD_IT3_gg' -groupscope global -path 'OU=Level3, OU=IT, OU=SYDNEY, DC=Piedpiper, DC=com'


#### NEST THE SYDNEY GROUPS
Add-ADGroupMember -identity Piedpiper_GG -Members PP_Sydney_GG
Add-ADGroupMember -identity PP_Sydney_GG -Members SYD_Accounting_gg, SYD_Admin_gg, SYD_Design_gg, SYD_HR_gg, SYD_Managers_gg, SYD_IT_gg
Add-ADGroupMember - identity SYD_IT_gg -Members SYD_IT1_gg, SYD_IT2_gg, SYD_IT3_gg


#### ADD THE SYDNEY USERS TO THEIR RESPECTIVE GROUPS

Get-ADUser -SearchBase 'OU=Accounting , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_Accounting_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Admin , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_Admin_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Design , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_Design_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=HR , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_HR_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Managers , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_Managers_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Level1, OU=IT , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_IT1_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Level2, OU=IT , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_IT2_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Level3, OU=IT , OU=SYDNEY, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'SYD_IT3_gg' -Members $_ }



# ********************** CANBERRA ****************************

New-ADGroup -name 'PP_Canberra_GG' -groupscope global -path 'OU=CANBERRA, DC=Piedpiper, DC=COM'

New-ADGroup -name 'CBR_Accounting_gg' -groupscope global -path 'OU=Accounting, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_Admin_gg' -groupscope global -path 'OU=Admin, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_Design_gg' -groupscope global -path 'OU=Design, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_HR_gg' -groupscope global -path 'OU=HR, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_Managers_gg' -groupscope global -path 'OU=Managers, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_IT_gg' -groupscope global -path 'OU=IT, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_IT1_gg' -groupscope global -path 'OU=Level1, OU=IT, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_IT2_gg' -groupscope global -path 'OU=Level2, OU=IT, OU=CANBERRA, DC=Piedpiper, DC=com'
New-ADGroup -name 'CBR_IT3_gg' -groupscope global -path 'OU=Level3, OU=IT, OU=CANBERRA, DC=Piedpiper, DC=com'
	

#### NEST THE CANBERRA GROUPS

Add-ADGroupMember -identity Piedpiper_GG -Members PP_Canberra_GG
Add-ADGroupMember -identity PP_Canberra_GG -Members CBR_Accounting_gg, CBR_Admin_gg, CBR_Design_gg, CBR_HR_gg, CBR_Managers_gg, CBR_IT_gg
Add-ADGroupMember - identity CBR_IT_gg -Members CBR_IT1_gg, CBR_IT2_gg, CBR_IT3_gg


#### ADD THE CANBERRA USERS TO THEIR RESPECTIVE GROUPS

Get-ADUser -SearchBase 'OU=Accounting , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_Accounting_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Admin , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_Admin_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Design , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_Design_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=HR , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_HR_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Managers , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_Managers_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Level1, OU=IT , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_IT1_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Level2, OU=IT , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_IT2_gg' -Members $_ }
Get-ADUser -SearchBase 'OU=Level3, OU=IT , OU=CANBERRA, DC=Piedpiper, DC=com' -Filter * | ForEach-Object {Add-ADGroupMember -Identity 'CBR_IT3_gg' -Members $_ }











