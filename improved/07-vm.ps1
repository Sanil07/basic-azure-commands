<#
.SYNOPSIS
Creates a virtual machine (Linux) and attaches a NIC.
.PARAMETER ResourceGroupName
The resource group for the VM.
.PARAMETER Location
Azure region.
.PARAMETER VmName
Name of the VM.
.PARAMETER VmSize
Flavor/size of the VM.
.PARAMETER NicName
Name of the network interface to attach.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$Location = "switzerlandnorth",
    [Parameter(Mandatory=$false)]
    [string]$VmName = "vm-swn-dev-1",
    [Parameter(Mandatory=$false)]
    [string]$VmSize = "Standard_B1s",
    [Parameter(Mandatory=$false)]
    [string]$NicName = "nic-swn-dev"
)

try {
    $vmConfig = New-AzVMConfig -VMName $VmName -VMSize $VmSize
    $credential = Get-Credential -Message "Enter the username and password for the VM"
    $vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Linux -ComputerName $VmName -Credential $credential
    $vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName "canonical" -Offer "ubuntu-24_04-lts" -Skus "server" -Version "latest"
    $nic = Get-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
    $vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id
    New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vmConfig -ErrorAction Stop
    Write-Host "VM '$VmName' created." -ForegroundColor Green
}
catch {
    Write-Error "Failed to create VM: $_"
}
