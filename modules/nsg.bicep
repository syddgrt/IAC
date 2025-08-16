@description('Name of the NSG')
param nsgName string
param location string = resourceGroup().location

resource nsg 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: nsgName
  location: location
  properties: {}
}

output nsgId string = nsg.id
