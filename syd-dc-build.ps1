<# 
  Build SYD-DC-01 Domain Controller   
        # !! will be prompted for the DSRM password
#>

# Rename the server
Rename-computer -newname “SYD-DC-01” -LocalCredential administrator -force

# Install domain services
Install-Windowsfeature AD-domain-services
Import-Module ADDSDeployment

# Add domain details
Install-ADDSForest
-CreateDnsDelegation:$false `
-DatabasePath “C:\Windows\NTDS” `
-DomainMode “Win2016” `
-DomainName “Piedpiper.com” `
-DomainNetbiosName “PIEDPIPER” `
-ForestMode “Win2016” `
-InstallDns:$true `
-LogPath “C:\Windows\NTDS” `
-NoRebootOnCompletion:$false `
-SysvolPath “C:\Windows\SYSVOL” `
-Force:$true
