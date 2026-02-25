<#
.SYNOPSIS
Creates a network interface and attaches it to a subnet.
.PARAMETER ResourceGroupName
Name of the resource group.
.PARAMETER Location
Azure location for the NIC.
.PARAMETER NicName
Name for the network interface.
.PARAMETER VNetName
Virtual network that contains the subnet.
.PARAMETER SubnetName
Name of the subnet to connect the NIC to.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$Location = "switzerlandnorth",
    [Parameter(Mandatory=$false)]
    [string]$NicName = "Nic-Swn-Dev",
    [Parameter(Mandatory=$false)]
    [string]$VNetName = "vnet-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$SubnetName = "subnet-swn-dev"
)

try {
    $vnet = Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
    $subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $vnet -ErrorAction Stop
    New-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -Location $Location -Subnet $subnet -IpConfigurationName "ipconfig1" -ErrorAction Stop
    Write-Host "Network interface '$NicName' created." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create NIC: $_"
}
