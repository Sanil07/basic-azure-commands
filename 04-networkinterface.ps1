$rg ="rg-swn-dev"
$location = "switzerlandnorth"
$nicname = "Nic-Swn-Dev"
$vnetname = "vnet-swn-dev"

$vnet = Get-AzVirtualNetwork -Name $vnetname -ResourceGroupName $rg

$subnet = Get-AzVirtualNetworkSubnetConfig -Name "subnet-swn-dev" -VirtualNetwork $vnet

New-AznetworkInterface -name $nicname -resourcegroupname $rg -location $location -subnet $subnet  -ipconfigurationname "ipconfig1" 