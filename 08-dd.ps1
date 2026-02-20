$rg = "rg-swn-dev"
$vmname = "vm-swn-dev-1"


$vm = get-azvm -name $vmname -resourcegroupname $rg

Add-AzVmDataDisk -vm $vm `
-name "datadisk-dev-1" `
-disksizeingb 16 `
-lun 0  `
-createoption empty `
StorageAccountType "standardSSd_lrs" `
-Caching Readwrite

update-azvm -vm $vm -resourcegroupname $rg