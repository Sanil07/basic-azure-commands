<#
.SYNOPSIS
Builds a Network Security Group with basic HTTP/SSH rules and attaches it to a subnet.
.PARAMETER ResourceGroupName
Resource group where the NSG and subnet exist.
.PARAMETER Location
Azure location for the NSG.
.PARAMETER NsgName
Name for the network security group.
.PARAMETER VNetName
Name of the virtual network containing the subnet.
.PARAMETER SubnetName
Name of the subnet to associate the NSG with.
.PARAMETER DestinationAddressPrefix
Destination address prefix used for rules (e.g. 10.0.0.4).
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$Location = "switzerlandnorth",
    [Parameter(Mandatory=$false)]
    [string]$NsgName = "nsg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$VNetName = "vnet-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$SubnetName = "subnet-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$DestinationAddressPrefix = "10.0.0.4"
)

try {
    $r1 = New-AzNetworkSecurityRuleConfig -Name "in-allow-http-from-internet" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix $DestinationAddressPrefix -DestinationPortRange 80
    $r2 = New-AzNetworkSecurityRuleConfig -Name "in-allow-ssh-from-internet" -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix $DestinationAddressPrefix -DestinationPortRange 22
    $nsg = New-AzNetworkSecurityGroup -Name $NsgName -ResourceGroupName $ResourceGroupName -Location $Location -SecurityRules $r1,$r2 -ErrorAction Stop

    $vnet = Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
    Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $SubnetName -AddressPrefix "10.0.0.0/24" -NetworkSecurityGroup $nsg | Out-Null
    $vnet | Set-AzVirtualNetwork -ErrorAction Stop
    Write-Host "NSG '$NsgName' created and associated with subnet '$SubnetName'." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create or attach NSG: $_"
}
