$ResourceGroupName = "rg-azcli"
$Location = "switzerlandnorth"
$VNetName = "vnet-dev-swn-01"
$AddressSpace = "10.0.0.0/16"
$SubnetName = "snet-dev-swn-web-01"
$SubnetAddressPrefix = "10.0.0.0/24"

az network vnet create -g $ResourceGroupName -l $Location -n $VNetName --address-prefixes $AddressSpace --subnet-name $SubnetName --subnet-prefixes $SubnetAddressPrefix
