data "azurerm_client_config" "current" {

}

resource "azurerm_key_vault" "kv" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  enable_rbac_authorization = true

  sku_name = "standard"
}

data "azuread_group" "admins" {
  display_name = "Administrators"
}

resource "azurerm_role_assignment" "grant_admins" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azuread_group.admins.object_id
}
