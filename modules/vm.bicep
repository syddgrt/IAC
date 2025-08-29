param virtualmachineName string
param adminUsername string
@secure()
param adminPassword string
param nicId string

@description('VM size for deployment')
param vmSize string = 'Standard_B1s' // define in parameter, no hardcode



resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: virtualmachineName
  location: resourceGroup().location
  properties: {
    hardwareProfile: { 
      vmSize: vmSize 
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
        diskSizeGB: 30 // safe for free tier
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
