param storageAccountName string 
param skuName string

var storageAccountId = resourceId('Microsoft.Storage/storageAccounts', storageAccountName)

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: resourceGroup().location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountId string = storageAccountId
