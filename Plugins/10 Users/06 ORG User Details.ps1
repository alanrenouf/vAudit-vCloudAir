# Start of Settings 
# End of Settings

$CIUser | Select Org, Name, StoredVMCount| Sort Org, StoredVMCount, Name


$Title = "User Details and number of VMs"
$Header =  "List of all Users and number of VMs"
$Comments = ""
$Display = "Table"
$Author = "Alan Renouf"
$PluginVersion = 1.0
$PluginCategory = "vCAAudit"
