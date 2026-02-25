<#
.SYNOPSIS
Creates an App Service plan and Linux web app configured for PHP.
.PARAMETER ResourceGroupName
Resource group to create resources in.
.PARAMETER Location
Azure region.
.PARAMETER AppServicePlan
Name of the App Service plan.
.PARAMETER WebAppName
Name of the Web App.
.PARAMETER Runtime
Runtime to set (e.g. PHP|8.3).
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$Location = "switzerlandnorth",
    [Parameter(Mandatory=$false)]
    [string]$AppServicePlan = "app-web-dev-plan",
    [Parameter(Mandatory=$false)]
    [string]$WebAppName = "webapp-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$Runtime = "PHP|8.3"
)

try {
    New-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Location $Location -Name $AppServicePlan -Tier "Free" -Linux -ErrorAction Stop
    New-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName -Location $Location -AppServicePlan $AppServicePlan -ErrorAction Stop
    Set-AzResource -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.Web/sites/config" -Name "$WebAppName/web" -Properties @{linuxFxVersion = $Runtime} -Force
    Write-Host "Web app '$WebAppName' created with runtime $Runtime." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create app service or web app: $_"
}
