resource "azurerm_resource_group" "rg" {
  name     = "kensrg5"
  location = "North Central US"
}

locals {
  
}

resource "azurerm_app_service_plan" "asp" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

data "http" "oidc_wellknown" {
  url = "https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration"
}

resource "azurerm_app_service" "appsvc" {
  name                = "example-app-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  app_settings = {
    "MS_TOKEN_ENDPOINT" = jsondecode(data.http.oidc_wellknown.body).token_endpoint
  }
}
