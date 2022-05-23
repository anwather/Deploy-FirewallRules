# Manage Firewall Rule Collection Groups

## Project Structure

Folder structure:-
- Top level folder should have the same name as the firewall policy
- Each sub folder should be named after the rule collection group

File structure:-
- Each sub folder should contain a ```properties.json``` folder containing an entry similar to below.

```
{
    "priority": 200
}
```
- For each rule collection there should be a file with a schema similar to below (taken from the ARM schema)

```
{
    "ruleCollectionType": "FirewallPolicyFilterRuleCollection",
    "action": {
        "type": "Allow"
    },
    "rules": [],
    "name": "rule_collection_name",
    "priority": 100
}
```

## Deployment

- Requirements:
    - PowerShell Az Modules (specifically Az.Resources)
    - Bicep
    - Not tested using PowerShell 5.1

```
Deploy-FirewallRules.ps1 -FirewallPolicyName "test_firewall_policy" -FirewallPolicyResourceGroup "hub-spoke" -Location australiaeast
```