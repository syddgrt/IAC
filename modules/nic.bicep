param nicName string
param location string = resourceGroup().location
param subnetId string
param nsgId string
param enableIPForwarding bool = false
param privateIPAllocationMethod string = 'Dynamic'

resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: privateIPAllocationMethod
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgId
    }
    enableIPForwarding: enableIPForwarding
  }
}

output nicId string = nic.id
