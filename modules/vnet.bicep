@description('Name of the Virtual Network')
param vnetName string

@description('Location for the Virtual Network')
param location string = resourceGroup().location

@description('Address space for the Virtual Network')
param addressPrefixes array

@description('Subnets configuration')
param subnets array

resource vnet 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      for subnet in subnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.addressPrefix
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output subnetIds array = [for subnet in subnets: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnet.name)]
