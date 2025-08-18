@secure()
param adminPassword string

// -----------------------
// Storage Account Module
// -----------------------
module storageModule './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: 'trialstorageacc456987'
    skuName: 'Standard_LRS'
  }
}
output storageAccountId string = storageModule.outputs.storageAccountId

// -----------------------
// Network Security Group Module
// -----------------------
module nsgModule './modules/nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    nsgName: 'TrialNSG456987'
  }
}
output nsgId string = nsgModule.outputs.nsgId

// -----------------------
// Virtual Network Module
// -----------------------
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

// -----------------------
// Network Interface Modulee
// -----------------------
module nicModule './modules/nic.bicep' = {
  name: 'nicDeployment'
  params: {
    nicName: 'TrialNic456987'
    location: resourceGroup().location
    subnetId: vnetModule.outputs.subnetIds[0]
    nsgId: nsgModule.outputs.nsgId
  }
}
output nicId string = nicModule.outputs.nicId

// -----------------------
// Virtual Machine Module
// -----------------------
module vmModule './modules/vm.bicep' = {
  name: 'virtualMachineDeployment'
  params: {
    virtualmachineName: 'TrialVm456987'
    adminUsername: 'azureuser'
    adminPassword: adminPassword
    nicId: nicModule.outputs.nicId
  }
}
output virtualMachineId string = vmModule.outputs.virtualMachineId

// -----------------------
// Auto-Shutdown for VM
// -----------------------
resource autoShutdown 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: 'shutdown-computevm-TrialVm456987'
  location: resourceGroup().location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: { time: '22:00' }
    timeZoneId: 'Singapore Standard Time'
    targetResourceId: vmModule.outputs.virtualMachineId
  }
}

@description('Allowed VM sizes')
param allowedVMSizes array = [
  'Standard_B1s'
  'Standard_B1ms'
  'Standard_B2s'
]

module customPolicies './modules/policy.bicep' = {
  name: 'deployCustomPolicies'
  scope: subscription() // <-- explicitly subscription
  params: {
    allowedVMSizes: allowedVMSizes
  }
}

module assignPolicies './modules/policyAssignments.bicep' = {
  name: 'assignPolicies'
  scope: resourceGroup() 
  params: {
    storagePolicyId: customPolicies.outputs.storagePolicyId
    vmSizePolicyId: customPolicies.outputs.vmSizePolicyId
    allowedVMSizes: allowedVMSizes
  }
}



