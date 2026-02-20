$AppServicePlan ="app-web-dev-plan"
$rg ="rg-swn-dev"
$location = "switzerlandnorth"
$webappname = "webapp-swn-dev"



new-azappserviceplan -resourcegroupname $rg -location $location -name $appserviceplan -tier "free" -linux

new-azwebapp -resourcegroupname $rg -name $webappname -location $location -appserviceplan $appserviceplan 

set-azresource -resourcegroupname $rg -resourcetype "Microsoft.Web/sites/config" -name "$webappname/web" -properties @{linuxFxVersion = "PHP|8.3"} -force

