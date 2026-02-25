<#
.SYNOPSIS
Adds a data disk to an existing VM.
.PARAMETER ResourceGroupName
Resource group containing the VM.
.PARAMETER VmName
Name of the VM to modify.
.PARAMETER DiskName
Name for the new data disk.
.PARAMETER DiskSizeGB
Size of the disk in GiB.
.PARAMETER Lun
Logical unit number to assign.
.PARAMETER StorageAccountType
Type of storage (Standard_LRS, Premium_LRS, etc.)
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-swn-dev",
    [Parameter(Mandatory=$false)]
    [string]$VmName = "vm-swn-dev-1",
    [Parameter(Mandatory=$false)]
    [string]$DiskName = "datadisk-dev-1",
    [Parameter(Mandatory=$false)]
    [int]$DiskSizeGB = 16,
    [Parameter(Mandatory=$false)]
    [int]$Lun = 0,
    [Parameter(Mandatory=$false)]
    [string]$StorageAccountType = "StandardSSD_LRS"
)

try {
    $vm = Get-AzVM -Name $VmName -ResourceGroupName $ResourceGroupName -ErrorAction Stop
    Add-AzVMDataDisk -VM $vm `
        -Name $DiskName `
        -DiskSizeInGB $DiskSizeGB `
        -Lun $Lun `
        -CreateOption Empty `
        -StorageAccountType $StorageAccountType `
        -Caching ReadWrite
    Update-AzVM -VM $vm -ResourceGroupName $ResourceGroupName -ErrorAction Stop
    Write-Host "Data disk '$DiskName' added to VM '$VmName'." -ForegroundColor Green
}
catch {
    Write-Error "Failed to attach data disk: $_"
}
