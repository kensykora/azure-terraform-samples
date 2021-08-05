terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.70"
    }
    azuread = "~>1.6"
  }

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformkms"
    container_name       = "tfstate"
    key                  = "20-azure-ad.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
