terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = " ~> 4.46.0"
    }
    random = {
      source  = "hashicorp/random"
      version = " ~> 3.7.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-management"
    storage_account_name = "tfauratest"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}