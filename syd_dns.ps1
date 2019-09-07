<#
    Create zones and records for SYD-DC-01 DNS
#>

$domain = Piedpiper

# Add a reverse lookup zone for DNS
Add-DnsServerPrimaryZone -NetworkID "172.16.0.0/21" -ReplicationScope "Forest"

# Add an A record for the name server
Add-DnsServerResourceRecord -ZoneName  -A -Name "ns1.$domain.com" -IPv4Address "XXX.XXX.XXX.XXX"

# Add a PTR record for the name server in the RLZ
Add-DnsServerResourceRecord -Name "ns1" -Ptr -ZoneName "0.16.172.in-addr.arpa" -AllowUpdateAny -PtrDomainName "ns1.$domain.com"

