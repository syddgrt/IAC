@secure()
param adminPassword string

// Storage
module storageModule './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: 'trialstorageacc456987'
    skuName: 'Standard_LRS'
  }
}
output storageAccountId string = storageModule.outputs.storageAccountId

// NSG
module nsgModule './modules/nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    nsgName: 'TrialNSG456987'
  }
}
output nsgId string = nsgModule.outputs.nsgId

// VNet
module vnetModule './modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: 'TrialVnet456987'
    location: resourceGroup().location
    addressPrefixes: ['10.0.0.0/16']
    subnets: [
      {
        name: 'TrialSubnet456987'
        addressPrefix: '10.0.0.0/24'
      }
    ]
  }
}
output vnetId string = vnetModule.outputs.vnetId
output subnetIds array = vnetModule.outputs.subnetIds

// NIC
module nicModule './modules/nic.bicep' = {
  name: 'nicDeployment'
  params: {
    nicName: 'TrialNic456987'
    location: resourceGroup().location
    subnetId: vnetModule.outputs.subnetIds[0] // Use the first subnet ID from the array
    nsgId: nsgModule.outputs.nsgId
  }
}
output nicId string = nicModule.outputs.nicId

// VM
module vmModule './modules/vm.bicep' = {
  name: 'virtualMachineDeployment'
  params: {
    virtualmachineName: 'TrialVm456987'
    skuName: 'Standard_B1s'
    adminUsername: 'azureuser'
    adminPassword: adminPassword
    nicId: nicModule.outputs.nicId
  }
}
output virtualMachineId string = vmModule.outputs.virtualMachineId
