param ruleCollectionGroupName string
param location string
param firewallPolicyName string
param priority int
param ruleCollections array

resource rcg 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2020-11-01' = {
  name: '${firewallPolicyName}/${ruleCollectionGroupName}'
  location: location
  properties: {
    priority: priority
    ruleCollections: ruleCollections
  }
}
