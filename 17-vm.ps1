$rg = "rg-azcli"
$loc = "switzerlandnorth"

$vmname = "vm-dev-swn-01"
$vmsize = "standard_b1s"
$nicname = "nic-dev-swn"
$storageaccountname = "staccdevswn123rg"

$avsetName = "av-dev-swn-01"
$dataDiskName = "datadisk1"


az vm availability-set create `
    -g $rg `
    -l $loc `
    -n $avsetName `
    --platform-fault-domain-count 2 `
    --platform-update-domain-count 5 `

az  disk create `
    -g $rg `
    -l $loc `
    -n $dataDiskName `
    --size-gb 16 `
    --sku Standard_LRS

az vm create `
    -g $rg `
    -l $loc `
    -n $vmname `
    --nics $nicname `
    --size $vmsize `
    --availability-set $avsetName `
    --admin-username sanilwsd `
    --authentication-type ssh `
    --generate-ssh-keys `
    --image "canonical:0001-com-ubuntu-server-focal:20_04-lts:latest" 

az vm disk attach `
    -g $rg `
    --vm-name $vmname `
    --name $dataDiskName `
    --lun 0 `
    --caching ReadWrite 

az vm boot-diagnostics enable `
    -g $rg `
    -name $vmname `
    --storage "https://${storageaccountname}.blob.core.windows.net/"