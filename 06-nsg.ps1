$rg = "rg-swn-dev"
$loc = "switzerlandnorth"
$nsgname = "nsg-swn-dev"
$subnetname ="subnet-swn-dev"


$r1 =new-aznetworksecurityruleConfig -name "in-allow-http-from-internet" -access allow -Protocol tcp -direction inbound -priority 100 -sourceaddressprefix internet -sourceportrange * -destinationaddressprefix 10.0.0.4 -destinationportrange 80 

$r2 = new-aznetworksecurityruleconfig -name "in-allow-ssh-from-internet" -access allow -Protocol tcp -direction inbound -priority 110 -sourceaddressprefix internet -sourceportrange * -destinationaddressprefix 10.0.0.4 -destinationportrange 22 

$nsg= New-AzNetworkSecurityGroup -name $nsgname -resourcegroupname $rg -location $loc -securityrules $r1,$r2

$vnet = get-azvirtualnetwork -name "vnet-swn-dev" -resourcegroupname $rg

set-azvirtualnetworksubnetconfig -virtualnetwork $vnet -name $subnetname -addressprefix "10.0.0.0/24" -NetworkSecurityGroup $nsg 

set-azvirtualnetwork -virtualnetwork $vnet 