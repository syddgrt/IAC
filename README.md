# IAC Project Documentation

## Overview
This project contains Bicep files for deploying Azure resources using Infrastructure as Code (IaC) practices. The main entry point is the `main.bicep` file, which references modules and parameters to define the desired infrastructure.

## Project Structure
- **main.bicep**: The main Bicep file that orchestrates the deployment of resources.
- **modules/storage.bicep**: A reusable module for configuring Azure Storage resources.
- **parameters/dev.parameters.json**: Parameter values for the development environment.

## Getting Started

### Prerequisites
- Ensure you have the Azure CLI installed. You can follow the installation instructions for your operating system from the [Azure CLI installation page](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

### Installation Steps for Azure CLI
1. Visit the Azure CLI installation page: [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
2. Follow the instructions specific to your operating system (Windows, macOS, or Linux).
3. After installation, verify the installation by running the following command in your terminal:
   ```
   az --version
   ```

### Deploying Bicep Files
1. Open your terminal and navigate to the project directory.
2. Use the Azure CLI to deploy the Bicep files. For example:
   ```
   az deployment group create --resource-group <your-resource-group> --template-file main.bicep --parameters @parameters/dev.parameters.json
   ```

## Additional Resources
- [Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)