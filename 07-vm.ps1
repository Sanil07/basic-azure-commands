$rg = "rg-swn-dev"
$loc = "switzerlandnorth"
$Vmname ="vm-swn-dev-1"
$VmSize ="Standard_B1s"

$vmconfig = new-azvmconfig -vmname $vmname -vmsize $vmsize
$Credential = get-credential -message "Enter the username and password for the VM"
$vmconfig = set-azVmoperatingsystem -vm $vmconfig -linux -computername $vmname -Credential $Credential

$vmconfig  = Set-AzVMSourceimage -vm $vmconfig -publishername "canonical" -offer "ubuntu-24_04-lts" -skus "server" -version "latest"

$nic = get-aznetworkinterface -name "nic-swn-dev" -resourcegroupname $rg

$vmconfig = Add-azvmnetworkinterface -vm $vmconfig -id $nic.id

new-azvm -resourcegroupname $rg -location $loc -vm $vmconfig 