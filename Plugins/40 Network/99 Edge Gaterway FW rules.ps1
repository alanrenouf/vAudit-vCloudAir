# Start of Settings 
# End of Settings

Function Get-EdgeFWRule ($EdgeGateway)  {  
    $Edgeview = $EdgeGateway | Get-CIView
	if (!$Edgeview) {
		Write-Warning "Edge Gateway with name $Edgeview not found"
		Exit
	}
    $webclient = New-Object system.net.webclient
    $webclient.Headers.Add("x-vcloud-authorization",$Edgeview.Client.SessionKey)
    $webclient.Headers.Add("accept",$EdgeView.Type + ";version=5.1")
    [xml]$EGWConfXML = $webclient.DownloadString($EdgeView.href)
    $FirewallRules = $EGWConfXML.EdgeGateway.Configuration.EdgegatewayServiceConfiguration.FirewallService.FirewallRule
    $Rules2 = @()
    if ($FirewallRules){
    	$FirewallRules | ForEach-Object {
    		$ProtocolArray = $_.Protocols | get-member -MemberType Property | Select-Object Name
    		$ProtocolArray | ForEach-Object {
    			$ProtocolValue = $ProtocolValue + $_.Name
    		}
    		$NewRule2 = new-object PSObject -Property @{
    			id = $_.Id;
    			Name = $Edgeview.name;
    			Description = $_.Description
    			Enabled = $_.IsEnabled;
    			SourceIP = $_.SourceIp;
    			SourcePortRange = $_.SourcePortRange
    			DestinationIP = $_.DestinationIp;
    			DestinationPortRange = $_.DestinationPortRange;
    			Protocol = $ProtocolValue;
    			Policy = $_.Policy;
    		}
    		$NewRule2 | Select id, Description, SourceIP, SourcePortRange, DestinationIP, DestinationPortRange, Protocol, Policy, Enabled
    		Remove-Variable ProtocolValue
    	}
    }
}

Foreach ($eg in $CIEGW) {  Get-EdgeFWRule $eg }


$Title = "List of Edge Gateway Rules for FW"
$Header =  "List of Edge Gateway Rules for FW"
$Comments = ""
$Display = "Table"
$Author = "Naoya Matsuda"
$PluginVersion = 1.0
$PluginCategory = "vCAAudit"

