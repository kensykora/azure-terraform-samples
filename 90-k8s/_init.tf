terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.70"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformkms"
    container_name       = "tfstate"
    key                  = "90-hyperv.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
