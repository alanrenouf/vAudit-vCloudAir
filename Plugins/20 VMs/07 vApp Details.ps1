# Start of Settings 
# End of Settings

$CIvApp | Select Org, Name, Description, Enabled, CPUCount, SizeGB, MemoryAllocationMB | Sort Org, Name

$Title = "vApp Details"
$Header =  "List of all vApps and their details"
$Comments = ""
$Display = "Table"
$Author = "Alan Renouf"
$PluginVersion = 1.0
$PluginCategory = "vCAAudit"
