<#
.SYNOPSIS
Creates a storage account using Azure CLI.
.PARAMETER ResourceGroupName
The resource group name.
.PARAMETER Location
Azure region.
.PARAMETER StorageAccountName
Globally unique name for the account.
.PARAMETER Kind
Account kind (storageV2 etc.).
.PARAMETER Sku
SKU name.
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth",
    [string]$StorageAccountName = "staccdevswn123rg",
    [string]$Kind = "storageV2",
    [string]$Sku = "standard_lrs"
)

az storage account create -g $ResourceGroupName -n $StorageAccountName -l $Location --kind $Kind --sku $Sku
