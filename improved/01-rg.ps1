<#
.SYNOPSIS
Creates an Azure resource group using the Az PowerShell module.
.DESCRIPTION
This script is a parameterized version of the original sample. It accepts a resource group name
and location and will attempt to create the RG.  Errors are trapped so the script can be reused
in automation pipelines.
.PARAMETER ResourceGroupName
Name of the resource group to create.  Default: rg-swn-dev
.PARAMETER Location
Azure region where the group will be created. Default: switzerlandnorth
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName = "rg-swn-dev",

    [Parameter(Mandatory = $false)]
    [string]$Location = "switzerlandnorth"
)

try {
    Write-Host "Creating resource group '$ResourceGroupName' in location '$Location'..." -ForegroundColor Cyan
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location -ErrorAction Stop
    Write-Host "Resource group created successfully." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create resource group: $_"
}
