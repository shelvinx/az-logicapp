resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.resource_group_name}"
  location = var.location
}

module "logicapp" {
  source              = "./modules/logicapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  app_service_plan_os_type = "Windows"
  app_service_plan_sku     = "WS1"
  app_service_kind         = "logicapp"

  # Storage Account
  account_tier             = "Standard"
  account_replication_type = "LRS"
}