<#
.SYNOPSIS
Uses Azure CLI to create a VM, availability set, data disk and enable diagnostics.
.PARAMETER ResourceGroupName
Name of the resource group.
.PARAMETER Location
Azure region.
.PARAMETER VmName
Name of the virtual machine.
.PARAMETER VmSize
Size of the VM.
.PARAMETER NicName
NIC to attach.
.PARAMETER StorageAccountName
Name of a storage account used for boot diagnostics.
.PARAMETER AvSetName
Name of the availability set.
.PARAMETER DataDiskName
Name of the data disk to create and attach.
#>
param(
    [string]$ResourceGroupName = "rg-azcli",
    [string]$Location = "switzerlandnorth",
    [string]$VmName = "vm-dev-swn-01",
    [string]$VmSize = "standard_b1s",
    [string]$NicName = "nic-dev-swn",
    [string]$StorageAccountName = "staccdevswn123rg",
    [string]$AvSetName = "av-dev-swn-01",
    [string]$DataDiskName = "datadisk1"
)

az vm availability-set create -g $ResourceGroupName -l $Location -n $AvSetName --platform-fault-domain-count 2 --platform-update-domain-count 5

az disk create -g $ResourceGroupName -l $Location -n $DataDiskName --size-gb 16 --sku Standard_LRS

az vm create -g $ResourceGroupName -l $Location -n $VmName --nics $NicName --size $VmSize --availability-set $AvSetName --admin-username sanilwsd --authentication-type ssh --generate-ssh-keys --image "canonical:0001-com-ubuntu-server-focal:20_04-lts:latest"

az vm disk attach -g $ResourceGroupName --vm-name $VmName --name $DataDiskName --lun 0 --caching ReadWrite

az vm boot-diagnostics enable -g $ResourceGroupName -n $VmName --storage "https://${StorageAccountName}.blob.core.windows.net/"
