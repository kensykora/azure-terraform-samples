locals {
  prefix = "kms-test"
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "kmstest-rg"
  location = "North Central US"
}

resource "azurerm_storage_account" "example" {
  name                     = "kmsteststg"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}