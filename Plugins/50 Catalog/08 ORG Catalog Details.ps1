# Start of Settings 
# End of Settings

$Catalog | Where { $_.Name -ne "Public Catalog" }| Select Org, Name, Description, vAppTemplateCount, Shared | Sort Org, Name, vAppTemplateCount

$Title = "Catalog Details per VDC"
$Header =  "List of all Catalogs per VDC"
$Comments = ""
$Display = "Table"
$Author = "Alan Renouf"
$PluginVersion = 1.0
$PluginCategory = "vCAAudit"
