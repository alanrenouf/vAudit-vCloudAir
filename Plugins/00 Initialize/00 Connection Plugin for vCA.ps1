$Title = "Connection settings for vCloud Air"
$Author = "Alan Renouf"
$PluginVersion = 1.0
$PluginCategory = "vCDAudit"
$Display = "List"
$Header = "Connection Settings"
$Comments = "Connection Plugin for connecting to vCloud Air"

# Start of Settings 
# End of Settings

# Adding PowerCLI vCD Snapin/Module
if (!(get-Module -name VMware.VimAutomation.Cloud -erroraction silentlycontinue)) {
	add-Module VMware.VimAutomation.Cloud -erroraction silentlycontinue
}

if (!(get-Module -name VMware.VimAutomation.PCloud -erroraction silentlycontinue)) {
	add-Module VMware.VimAutomation.PCloud -erroraction silentlycontinue
}
Write-CustomOut "Connecting to vCloud Air"

$ConnectvCA = Connect-PIServer
$CIConnection = Get-PIDatacenter | Connect-CIServer

if (-not ($CIConnection | Select -first 1).IsConnected) {
	Write-Host "Unable to connect to vCloud Air, please ensure you have altered the vCloud Air server address correctly "
	Write-Host " to specify a username and password edit the connection string in the 00 Connection Plugin"
	break
}


Write-CustomOut "Collecting VM Objects"
$CIVM = Get-CIVM | Sort Name
Write-CustomOut "Collecting Catalog Objects"
$Catalog = Get-Catalog | Sort Name
Write-CustomOut "Collecting vApp Objects"
$CIvApp = Get-CIVapp | Sort Name
Write-CustomOut "Collecting Org Objects"
$Org = Get-Org | Sort Name
Write-CustomOut "Collecting VDC Objects"
$OrgvDC = Get-OrgvDC
Write-CustomOut "Collecting User Objects"
$CIUser = Get-CIUser
Write-CustomOut "Collecting Networks"
$OrgNet = Get-OrgNetwork
Write-CustomOut "Collecting Edge Gateways"
$CIEGW = search-cloud -QueryType EdgeGateway
Write-CustomOut "Collecting VM CPU Usage Metrics"
$VMCPUUsage = $CIVM | Where {$_.Status -eq "PoweredOn"} | Foreach {
	$Metrics = $_.ExtensionData.GetMetricsCurrent()
	$VMMetric = new-object PSObject -Property @{
        Name=$_.Name;
        CPUUsageMHZAvg = $metrics.Metric[2].value;
        OrgVdc = $_.OrgVdc.Name
    }
    $VMMetric
}


