param virtualmachineName string
param adminUsername string
@secure()
param adminPassword string
param nicId string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: virtualmachineName
  location: resourceGroup().location
  properties: {
    hardwareProfile: { 
      vmSize: 'Standard_B1s' 
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
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        diskSizeGB: 30 // Free tier safe
      }
    }
    osProfile: {
      computerName: virtualmachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        { id: nicId }
      ]
    }
  }
}

output virtualMachineId string = virtualMachine.id
