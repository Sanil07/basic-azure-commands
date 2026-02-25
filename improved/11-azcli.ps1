<#
.SYNOPSIS
Creates a resource group using the Azure CLI from PowerShell.
.PARAMETER ResourceGroupName
Name of the resource group to create.
.PARAMETER Location
Azure region for the group.
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth"
)

az group create -n $ResourceGroupName -l $Location
