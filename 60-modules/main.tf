resource "azurerm_resource_group" "rg" {
  name     = "kensrg6"
  location = "North Central US"
}

module "keyvault" {
  source              = "../_modules/key-vault"
  name                = "kensrg6kv"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
