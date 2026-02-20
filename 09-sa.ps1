$rg = "rg-swn-dev"
$storageaccountname = "stswndev123test"
$location = "switzerlandnorth"
$kind = "StorageV2"
$sku = "Standard_LRS"

new-azstorageaccount -name $storageaccountname -resourcegroupname $rg -location $location `
-kind $kind `
-sku $sku