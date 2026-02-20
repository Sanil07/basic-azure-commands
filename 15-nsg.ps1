$rg = "rg-azcli"
$loc = "switzerlandnorth"
$nsgname = "nsg-dev"
$vnetname = "vnet-dev-swn-01"
$subnetname = "snet-dev-swn-web-01"

az network nsg create `
    -g $rg `
    -n $nsgname `
    -l $loc

az network nsg rule create `
    -g $rg `
    -n "allow-http" `
    --nsg-name $nsgname `
    --priority 100 `
    --destination-port-ranges 80 `
    --protocol tcp `
    --source-address-prefixes Internet `
    --source-port-ranges "*" `
    --destination-address-prefixes "10.0.0.4" `
    --access allow `
    --direction inbound `

az network nsg rule create `
    -g $rg `
    -n "allow-ssh" `
    --nsg-name $nsgname `
    --priority 200 `
    --destination-port-ranges 22 `
    --protocol tcp `
    --source-address-prefixes Internet `
    --source-port-ranges "*" `
    --destination-address-prefixes "10.0.0.4" `
    --access allow `
    --direction inbound `

az network vnet subnet update `
    -g $rg `
    --vnet-name $vnetname `
    --name $subnetname `
    --network-security-group $nsgname