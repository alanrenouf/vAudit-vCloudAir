# Start of Settings 
# End of Settings

Foreach ($Cat in $Catalog) { 
	$cat.ExtensionData.CatalogItems.CatalogItem | Select @{N="Org";E={$cat.org}}, @{N="Catalog";E={$Cat.Name}}, @{N="CatalogItem";E={$_.Name}} | Where { $_.Catalog -ne "Public Catalog" }| Sort Org, Catalog
}
$Title = "Catalog items"
$Header =  "List of all items within Catalogs"
$Comments = ""
$Display = "Table"
$Author = "Alan Renouf"
$PluginVersion = 1.0
$PluginCategory = "vCAAudit"
