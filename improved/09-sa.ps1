<#
.SYNOPSIS
Creates a storage account.
.PARAMETER ResourceGroupName
Resource group for the account.
.PARAMETER StorageAccountName
Desired name (must be globally unique).
.PARAMETER Location
Azure region.
.PARAMETER Kind
Storage account kind (StorageV2, BlobStorage, etc.).
.PARAMETER Sku
SKU (Standard_LRS, Premium_LRS, etc.).
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$StorageAccountName = "stswndev123test",
    [Parameter(Mandatory=$false)]
    [string]$Location = "switzerlandnorth",
    [Parameter(Mandatory=$false)]
    [string]$Kind = "StorageV2",
    [Parameter(Mandatory=$false)]
    [string]$Sku = "Standard_LRS"
)

try {
    New-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -Location $Location -Kind $Kind -SkuName $Sku -ErrorAction Stop
    Write-Host "Storage account '$StorageAccountName' created." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create storage account: $_"
}
