<#
.SYNOPSIS
Creates an App Service plan and webapp using Azure CLI.
.PARAMETER ResourceGroupName
Name of the resource group.
.PARAMETER Location
Azure region.
.PARAMETER AppServicePlan
Name of the service plan.
.PARAMETER WebAppName
Name of the web app.
.PARAMETER Runtime
Runtime stack (e.g. "PHP:8.3").
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth",
    [string]$AppServicePlan = "asp-dev-swn",
    [string]$WebAppName = "webapp-dev-swn",
    [string]$Runtime = "PHP:8.3"
)

az appservice plan create -g $ResourceGroupName -l $Location -n $AppServicePlan --sku F1 --is-linux

az webapp create -g $ResourceGroupName -n $WebAppName --plan $AppServicePlan --runtime $Runtime
