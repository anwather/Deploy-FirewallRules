<#
.SYNOPSIS
    Deploy firewall rule collection groups
.DESCRIPTION
    See README.md for full documentation
.NOTES
    Not tested in PowerShell 5.1
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    C:>Deploy-FirewallRules.ps1 -FirewallPolicyName "test_firewall_policy" -FirewallPolicyResourceGroup "hub-spoke" -Location australiaeast
#>
Param(
    [Parameter(Mandatory = $true)]    
    [string]$FirewallPolicyName, 
    [Parameter(Mandatory = $true)] 
    [string]$FirewallPolicyResourceGroup, 
    [Parameter(Mandatory = $true)] 
    [string]$FirewallPolicyLocation
)

. .\Utilities\functions.ps1

foreach ($folder in Get-ChildItem -Path $FirewallPolicyName -Directory) {
    $ruleCollections = @()
    foreach ($file in Get-ChildItem -Path $folder) {
        if ($file.Name -eq 'properties.json') {
            $priority = (Get-Content $file | ConvertFrom-Json).priority
        }
        else {
            $ruleCollections += Get-Content $file | ConvertFrom-Json -Depth 10
        }
    }

    $parameters = @{
        ruleCollectionGroupName = $folder.Name
        location                = $FirewallPolicyLocation
        firewallPolicyName      = $FirewallPolicyName
        priority                = $priority
        ruleCollections         = @($ruleCollections | ConvertPSObjectToHashTable)
    }

    New-AzResourceGroupDeployment -ResourceGroupName $FirewallPolicyResourceGroup `
        -TemplateFile .\Templates\ruleCollectionGroup.bicep `
        -TemplateParameterObject $parameters `
        -Verbose -WhatIf
}