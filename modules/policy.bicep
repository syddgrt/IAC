targetScope = 'subscription'

@description('Allowed VM sizes')
param allowedVMSizes array = [
  'Standard_B1s'
  'Standard_B1ms'
  'Standard_B2s'
]

// -----------------------
// Custom Policy: Enforce HTTPS on Storage Accounts
// -----------------------
resource storageHttpsPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'custom-storage-https-only'
  properties: {
    displayName: 'Enforce HTTPS on Storage Accounts'
    description: 'Ensure storage accounts use HTTPS only.'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            field: 'Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly'
            equals: false
          }
        ]
      }
      then: {
        effect: 'Deny'
      }
    }
  }
}

// -----------------------
// Custom Policy: Restrict VM Sizes
// -----------------------
resource vmSizePolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'custom-allowed-vm-sizes'
  properties: {
    displayName: 'Restrict VM Sizes'
    description: 'Restrict VMs to small sizes.'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
  if: {
    allOf: [
      {
        field: 'type'
        equals: 'Microsoft.Compute/virtualMachines'
      }
      {
        not: {
          field: 'Microsoft.Compute/virtualMachines/sku.name'
          in: '[parameters(\'allowedSizes\')]'
        }
      }
    ]
  }
  then: {
    effect: 'Deny'
  }
}


    parameters: {
      allowedSizes: {
        type: 'Array'
        defaultValue: allowedVMSizes
        metadata: { description: 'Allowed VM sizes' }
      }
    }
  }
}

// -----------------------
// Outputs for assignments
// -----------------------
output storagePolicyId string = storageHttpsPolicy.id
output vmSizePolicyId string = vmSizePolicy.id
