<#
.SYNOPSIS
Creates an NSG with HTTP/SSH rules and attaches it to a subnet (CLI version).
.PARAMETER ResourceGroupName
Name of the RG.
.PARAMETER Location
Azure region.
.PARAMETER NsgName
Name of the NSG.
.PARAMETER VNetName
Name of the VNet.
.PARAMETER SubnetName
Subnet to update.
.PARAMETER DestinationAddress
Destination prefix used in rules.
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth",
    [string]$NsgName = "nsg-dev",
    [string]$VNetName = "vnet-dev-swn-01",
    [string]$SubnetName = "snet-dev-swn-web-01",
    [string]$DestinationAddress = "10.0.0.4"
)

az network nsg create -g $ResourceGroupName -n $NsgName -l $Location

az network nsg rule create -g $ResourceGroupName -n "allow-http" --nsg-name $NsgName --priority 100 --destination-port-ranges 80 --protocol tcp --source-address-prefixes Internet --source-port-ranges "*" --destination-address-prefixes $DestinationAddress --access allow --direction inbound

az network nsg rule create -g $ResourceGroupName -n "allow-ssh" --nsg-name $NsgName --priority 200 --destination-port-ranges 22 --protocol tcp --source-address-prefixes Internet --source-port-ranges "*" --destination-address-prefixes $DestinationAddress --access allow --direction inbound

az network vnet subnet update -g $ResourceGroupName --vnet-name $VNetName --name $SubnetName --network-security-group $NsgName
