# IAC Project Documentation

## Overview
This learning project contains Bicep files for deploying Azure resources using Infrastructure as Code (IaC) practices. The main entry point is the `main.bicep` file, which references modules and parameters to define the desired infrastructure.

v1.0.0 (16/08/2025)
Includes Storage Account, NSG, NIC, VNET and VM provisionings. All within the scope of Azure 12 months free tier.

v1.1.0 (17/08/2025)
Add policy definition enforce https on storage account and restrict vm sizes.
Then apply them to the Resource Group TrialRG

## Additional Resources
- [Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)
