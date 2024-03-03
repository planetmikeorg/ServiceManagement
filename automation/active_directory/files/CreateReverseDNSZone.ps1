param(
    [string]$ZoneName,
    [string]$ReplicationScope = "Forest", # Possible values: 'Forest', 'Domain', 'Legacy', 'Custom'
    [string]$ADDomain
)

# Import DNS Server PowerShell Module
Import-Module DNSServer

try {
    # Check if the DNS Zone already exists
    $zone = Get-DnsServerZone -Name $ZoneName -ErrorAction Stop
    Write-Output "DNS Zone '$ZoneName' already exists."
}
catch {
    # If the zone does not exist, create it
    try {
        Add-DnsServerPrimaryZone -Name $ZoneName -ZoneFile "$ZoneName.dns" -ReplicationScope $ReplicationScope -DynamicUpdate Secure
        Write-Output "DNS Zone '$ZoneName' created successfully."
    }
    catch {
        Write-Error "Failed to create DNS Zone '$ZoneName'. Error: $_"
    }
}
