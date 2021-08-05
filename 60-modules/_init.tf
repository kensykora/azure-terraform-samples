terraform {

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformkms"
    container_name       = "tfstate"
    key                  = "60-modules.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
