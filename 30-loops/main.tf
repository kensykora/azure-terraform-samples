resource "azurerm_resource_group" "rg" {
  name     = "kensrg3"
  location = "North Central US"
}

locals {
  subnets = {
    "DMZ"      = "10.0.1.0/24"
    "Internal" = "10.0.2.0/24"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  for_each             = local.subnets
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = each.key
  address_prefixes     = [each.value]
}
