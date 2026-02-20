$rg = "rg-azcli"
$location = "switzerlandnorth"
$pipname = "pip-dev-swn"


az network public-ip create -g $rg -l $location -n $pipname --sku standard --allocation-method static --version ipv4