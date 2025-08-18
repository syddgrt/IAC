targetScope = 'resourceGroup'

@description('Policy Definition ID for storage HTTPS enforcement')
param storagePolicyId string

@description('Policy Definition ID for allowed VM sizes')
param vmSizePolicyId string

@description('Allowed VM sizes array')
param allowedVMSizes array

// -----------------------
// Assign HTTPS Policy
// -----------------------
resource storageAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'assign-storage-https-policy'
  properties: {
    displayName: 'Assign HTTPS-only Storage Policy'
    policyDefinitionId: storagePolicyId
    enforcementMode: 'Default'
  }
}

// -----------------------
// Assign VM Size Policy
// -----------------------
resource vmSizeAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'assign-vm-size-policy'
  properties: {
    displayName: 'Assign VM Size Restriction Policy'
    policyDefinitionId: vmSizePolicyId
    enforcementMode: 'Default'
    parameters: {
      allowedSizes: {
        value: allowedVMSizes
      }
    }

  }
}
