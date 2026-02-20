$rg = "rg-azcli"
$loc = "switzerlandnorth"
$storageaccountname = "staccdevswn123rg"
$kind = "storageV2"
$sku = "standard_lrs"

az storage account create `
    -g $rg `
    -n $storageaccountname `
    -l $loc `
    --kind $kind `
    --sku $sku