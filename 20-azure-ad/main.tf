resource "azuread_application" "myapp" {
  display_name = "Ken's App"
}

resource "azuread_application_password" "mypassword" {
  application_object_id = azuread_application.myapp.object_id
}

resource "azurerm_resource_group" "rg" {
  name     = "kensrg2"
  location = "North Central US"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = "kenskv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "list", "Set", "Delete"
    ]

  }
}

resource "azurerm_key_vault_secret" "example" {
  name = "service-principal-credentials"
  value = jsonencode({
    client_id     = azuread_application.myapp.application_id
    client_secret = azuread_application_password.mypassword.value
  })
  content_type = "application/json"
  key_vault_id = azurerm_key_vault.kv.id
}
