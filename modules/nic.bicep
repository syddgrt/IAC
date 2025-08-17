param nicName string
param location string = resourceGroup().location
param subnetId string
param nsgId string

resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: { id: subnetId }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: { id: nsgId }
    enableIPForwarding: false
  }
}

output nicId string = nic.id
