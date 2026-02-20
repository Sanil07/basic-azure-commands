$rg = "rg-swn-dev"
$loc = "switzerlandnorth"
$pipname = "pip-web-dev-swn-01"
$nicname ="Nic-swn-dev"
$ip ="ipconfig1"

$pip =New-AzPublicIpAddress -name $pipname -ResourceGroupname $rg -location $loc -Sku standard -allocationmethod Static 

$nic =Get-azNetworkinterface -name $nicname -resourcegroupname $rg 

Set-aznetworkinterfaceipconfig -name $ip -networkinterface $nic -publicipaddress $pip | Out-Null

set-aznetworkinterface -networkinterface $nic 

