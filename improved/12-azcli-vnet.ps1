<#
.SYNOPSIS
Creates a virtual network and subnet with the Azure CLI.
PARAMETER ResourceGroupName
Name of the RG.
PARAMETER Location
Azure region.
PARAMETER VNetName
Name for the virtual network.
PARAMETER AddressSpace
CIDR block for the VNet.
PARAMETER SubnetName
Name of the default subnet.
PARAMETER SubnetPrefix
CIDR for the subnet.
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth",
    [string]$VNetName = "vnet-dev-swn-01",
    [string]$AddressSpace = "10.0.0.0/16",
    [string]$SubnetName = "snet-dev-swn-web-01",
    [string]$SubnetPrefix = "10.0.0.0/24"
)

az network vnet create -g $ResourceGroupName -l $Location -n $VNetName --address-prefixes $AddressSpace --subnet-name $SubnetName --subnet-prefixes $SubnetPrefix
