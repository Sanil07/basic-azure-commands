$resourcegroupname= "rg-swn-dev"
$vnetname ="vnet-swn-dev"
$subnetname ="subnet-swn-dev"
$subnetprefix ="10.0.0.0/24"


$vnet=Get-AzVirtualNetwork -Resourcegroupname $resourcegroupname -Name $vnetname


add-azvirtualnetworksubnetconfig -name $subnetname -VirtualNetwork $vnet -Addressprefix $subnetprefix

$vnet | Set-AzVirtualNetwork