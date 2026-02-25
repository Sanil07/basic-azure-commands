<#
.SYNOPSIS
Creates a public IP address and associates it with a NIC.
.PARAMETER ResourceGroupName
Resource group where the NIC and PIP exist.
.PARAMETER Location
Azure region for the public IP.
.PARAMETER PIPName
Name of the public IP address resource.
.PARAMETER NicName
Name of the NIC to attach the public IP to.
.PARAMETER IpConfigName
Name of the NIC's IP configuration (default: ipconfig1).
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$Location = "switzerlandnorth",
    [Parameter(Mandatory=$false)]
    [string]$PIPName = "pip-web-dev-swn-01",
    [Parameter(Mandatory=$false)]
    [string]$NicName = "Nic-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$IpConfigName = "ipconfig1"
)

try {
    $pip = New-AzPublicIpAddress -Name $PIPName -ResourceGroupName $ResourceGroupName -Location $Location -Sku Standard -AllocationMethod Static -ErrorAction Stop
    $nic = Get-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
    Set-AzNetworkInterfaceIpConfig -Name $IpConfigName -NetworkInterface $nic -PublicIpAddress $pip | Out-Null
    Set-AzNetworkInterface -NetworkInterface $nic -ErrorAction Stop
    Write-Host "Public IP '$PIPName' created and associated with NIC '$NicName'." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create or assign public IP: $_"
}
