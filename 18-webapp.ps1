$rg = "rg-azcli"
$loc = "switzerlandnorth"
$appserviceplan = "asp-dev-swn"
$webappname = "webapp-dev-swn"

az appservice plan create `
    -g $rg `
    -l $loc `
    -n $appserviceplan `
    --sku F1 `
    --is-linux 

az webapp create `
    -g $rg `
    -n $webappname `
    --plan $appserviceplan `
    --runtime "PHP:8.3" 