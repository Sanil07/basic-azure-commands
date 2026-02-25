<#
.SYNOPSIS
Creates a public IP address using the Azure CLI.
.PARAMETER ResourceGroupName
Resource group for the IP address.
.PARAMETER Location
Azure location.
.PARAMETER PIPName
Name for the public IP.
.PARAMETER Sku
SKU for the public IP (Standard/Basic).
.PARAMETER AllocationMethod
Static or Dynamic.
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth",
    [string]$PIPName = "pip-dev-swn",
    [string]$Sku = "standard",
    [string]$AllocationMethod = "Static",
    [string]$Version = "ipv4"
)

az network public-ip create -g $ResourceGroupName -l $Location -n $PIPName --sku $Sku --allocation-method $AllocationMethod --version $Version
