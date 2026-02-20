$ResourceGroupName= "rg-swn-dev"
$Location ="switzerlandnorth"
$vnetname = "vnet-swn-dev"
$addressspace ="10.0.0.0/16"


new-azvirtualnetwork -name $vnetname -resourcegroupname $ResourceGroupName -location $Location -addressprefix $addressspace