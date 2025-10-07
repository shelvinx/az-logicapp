module "naming" {
  for_each = var.logic_apps
  source   = "Azure/naming/azurerm"
  version  = "0.4.2"

  # The environment is added by the naming module convention, so it is removed from the suffix.
  suffix = [each.key, "uks", var.environment]
}

resource "azurerm_resource_group" "rg" {
  for_each = var.logic_apps
  
  name     = "rg-${each.key}"
  location = each.value.location
  tags     = var.tags
}

resource "azurerm_resource_group" "keyvault" {
  name     = var.keyvault_resource_group.name
  location = var.keyvault_resource_group.location
  tags     = var.tags
}

resource "azurerm_resource_group" "loganalytics" {
  name     = var.loganalytics_resource_group.name
  location = var.loganalytics_resource_group.location
  tags     = var.tags
}

# Get current client configuration for Key Vault access
data "azurerm_client_config" "current" {}

# Create keyvault resources including Key Vault
module "keyvault" {
  source = "../../modules/keyvault"

  key_vault_name              = "kv-${var.environment}-${replace(lower(var.keyvault_resource_group.name), "rg-", "")}"
  resource_group_name         = azurerm_resource_group.keyvault.name
  location                    = azurerm_resource_group.keyvault.location
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  sku_name                    = "standard"
  tags                        = var.tags
}

resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = azurerm_resource_group.keyvault.name
  location            = azurerm_resource_group.keyvault.location
  name                = "id-logicapp"
}

# Look up the Entra ID group for Key Vault users
data "azuread_group" "kv_users" {
  display_name     = "SG Terraform Storage Contributors"
  security_enabled = true
}

# Assign Key Vault Secrets User role to the kv_users group
resource "azurerm_role_assignment" "kv_secrets_user" {
  scope                = module.keyvault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azuread_group.kv_users.object_id
  principal_type       = "Group"

  # Skip the role assignment if the group doesn't exist
  skip_service_principal_aad_check = true
}

module "loganalytics" {
  source = "../../modules/loganalytics"

  name                = "la-test"
  resource_group_name = azurerm_resource_group.loganalytics.name
  location            = azurerm_resource_group.loganalytics.location
  tags                = var.tags
}

module "logicapp" {
  for_each = var.logic_apps
  source   = "../../modules/logicapp"
  # version = "0.19.2"

  resource_group_name = azurerm_resource_group.rg[each.key].name
  location            = var.location

  app_service_plan_sku     = each.value.app_service_plan_sku
  app_service_plan_os_type = "Windows"
  app_service_kind         = "logicapp"

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # Use the user-provided storage account name, which is validated to be compliant.
  storage_account_name    = each.value.storage_account_name
  app_service_plan_name   = module.naming[each.key].app_service_plan.name
  logic_app_workflow_name = module.naming[each.key].logic_app_workflow.name

  zone_balancing_enabled = var.zone_balancing_enabled

  enable_application_insights = true
  application_insights_workspace_id = module.loganalytics.id

  user_assigned_identity_resource_ids = [azurerm_user_assigned_identity.example.id]

  tags = var.tags
}

output "logic_app_names" {
  value = [for app in module.logicapp : app.name]
  sensitive = true
}

resource "azurerm_monitor_diagnostic_setting" "logic_app_diag" {
  for_each = var.logic_apps

  name                       = "logic-app-diag-settings"
  target_resource_id         = module.logicapp[each.key].resource_id
  log_analytics_workspace_id = module.loganalytics.id

  enabled_log {
    category = "WorkflowRuntime"
  }
}

resource "azapi_resource" "staging_slot" {
  for_each = var.logic_apps

  type      = "Microsoft.Web/sites/slots@2022-09-01"
  name      = "staging"
  parent_id = module.logicapp[each.key].resource_id
  location  = var.location # Slots must be in the same location as the parent app

  body = {
    # The slot inherits most properties from the parent Logic App.
    # An empty properties block is sufficient to create it.
    properties = {}
  }
}