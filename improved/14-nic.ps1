<#
.SYNOPSIS
Creates a network interface using Azure CLI.
.PARAMETER ResourceGroupName
Name of the resource group.
.PARAMETER Location
Azure region.
.PARAMETER VNetName
Virtual network containing the subnet.
.PARAMETER SubnetName
Name of the subnet.
.PARAMETER PIPName
Public IP resource to associate (optional).
.PARAMETER NicName
Name for the NIC.
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth",
    [string]$VNetName = "vnet-dev-swn-01",
    [string]$SubnetName = "snet-dev-swn-web-01",
    [string]$PIPName = "pip-dev-swn",
    [string]$NicName = "nic-dev-swn"
)

az network nic create -g $ResourceGroupName -l $Location --name $NicName --vnet-name $VNetName --subnet $SubnetName --public-ip-address $PIPName
