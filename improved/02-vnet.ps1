<#
.SYNOPSIS
Creates an Azure virtual network in an existing resource group.
.PARAMETER ResourceGroupName
The name of the RG where the VNet will live.
.PARAMETER Location
Azure location for the VNet.
.PARAMETER VNetName
Name of the virtual network to create.
.PARAMETER AddressSpace
CIDR for the VNet (e.g. 10.0.0.0/16).
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory = $false)]
    [string]$Location = "switzerlandnorth",
    [Parameter(Mandatory = $false)]
    [string]$VNetName = "vnet-swn-dev",
    [Parameter(Mandatory = $false)]
    [string]$AddressSpace = "10.0.0.0/16"
)

try {
    Write-Host "Creating virtual network '$VNetName' in '$ResourceGroupName'..." -ForegroundColor Cyan
    New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $AddressSpace -ErrorAction Stop
    Write-Host "Virtual network created." -ForegroundColor Green
}
catch {
    Write-Error "Error creating virtual network: $_"
}
