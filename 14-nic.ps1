$rg = "rg-azcli"

$location = "switzerlandnorth"
$vnetname = "vnet-dev-swn-01"
$subnetname = "snet-dev-swn-web-01"
$pipname = "pip-dev-swn"
$nicname = "nic-dev-swn"


az network nic create -g $rg -l $location --name $nicname --vnet-name $vnetname --subnet $subnetname --public-ip-address $pipname