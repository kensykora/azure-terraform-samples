terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.70"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformkms"
    container_name       = "tfstate"
    key                  = "00-storage.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
