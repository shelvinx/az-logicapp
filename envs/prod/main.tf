resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.resource_group_name}"
  location = var.location
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"

  suffix = ["appname", var.environment, "uks"]
}

module "logicapp" {
  source              = "../../modules/logicapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  app_service_plan_os_type = "Windows"
  app_service_plan_sku     = var.app_service_plan_sku
  app_service_kind         = "logicapp"

  # Storage Account
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # Naming
  storage_account_name    = module.naming.storage_account.name
  app_service_plan_name   = module.naming.app_service_plan.name
  logic_app_workflow_name = module.naming.logic_app_workflow.name
}