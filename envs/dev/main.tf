locals {
  logic_apps = { for idx, app in var.logic_apps : idx => app }
}

resource "azurerm_resource_group" "rg" {
  for_each = toset([for app in var.logic_apps : app.resource_group_name])
  name     = each.key
  location = var.location
}

module "naming" {
  for_each = local.logic_apps
  source   = "Azure/naming/azurerm"
  version  = "0.4.2"

  # The environment is added by the naming module convention, so it is removed from the suffix.
  suffix = [each.value.logic_app_name, "uks", format("%02d", each.key + 1)]
}

module "logicapp" {
  for_each = local.logic_apps
  source   = "../../modules/logicapp"

  resource_group_name = each.value.resource_group_name
  location            = var.location

  app_service_plan_os_type = "Windows"
  app_service_plan_sku     = each.value.app_service_plan_sku_name
  app_service_kind         = "logicapp"

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # Use the user-provided storage account name, which is validated to be compliant.
  storage_account_name    = each.value.storage_account_name
  app_service_plan_name   = module.naming[each.key].app_service_plan.name
  logic_app_workflow_name = module.naming[each.key].logic_app_workflow.name

  depends_on = [azurerm_resource_group.rg]
}