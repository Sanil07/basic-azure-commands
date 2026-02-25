<#
.SYNOPSIS
Adds a subnet to an existing virtual network.
.PARAMETER ResourceGroupName
Resource group containing the VNet.
.PARAMETER VNetName
The name of the virtual network to modify.
.PARAMETER SubnetName
Name of the subnet to add.
.PARAMETER SubnetPrefix
CIDR prefix for the subnet (e.g. 10.0.0.0/24).
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory = $false)]
    [string]$VNetName = "vnet-swn-dev",
    [Parameter(Mandatory = $false)]
    [string]$SubnetName = "subnet-swn-dev",
    [Parameter(Mandatory = $false)]
    [string]$SubnetPrefix = "10.0.0.0/24"
)

try {
    $vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName -ErrorAction Stop
    Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $vnet -AddressPrefix $SubnetPrefix | Out-Null
    $vnet | Set-AzVirtualNetwork -ErrorAction Stop
    Write-Host "Subnet '$SubnetName' added to virtual network '$VNetName'." -ForegroundColor Green
}
catch {
    Write-Error "Failed to add subnet: $_"
}
