param virtualmachineName string
param skuName string
param adminUsername string
@secure()
param adminPassword string
param nicId string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: virtualmachineName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: skuName
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: virtualmachineName  // <-- FIXED: required!
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicId
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}

output virtualMachineId string = virtualMachine.id
