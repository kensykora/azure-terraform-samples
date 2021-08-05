resource "azurerm_resource_group" "rg" {
  name     = "kensrg4"
  location = "North Central US"
}

locals {
  subnets = {
    "DMZ"      = "10.0.1.0/24"
    "Internal" = "10.0.2.0/24"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "virtualNetwork2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  dynamic "subnet" {
    for_each = local.subnets
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }
}

