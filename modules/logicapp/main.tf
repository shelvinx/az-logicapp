resource "azurerm_storage_account" "example" {
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  location                 = var.location
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name

  https_traffic_only_enabled = true
  public_network_access_enabled = true
  shared_access_key_enabled = true
  
  tags = var.tags
}

module "avm-res-web-serverfarm" {
  source  = "Azure/avm-res-web-serverfarm/azurerm"
  version = "0.7.0"

  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.app_service_plan_os_type
  sku_name            = var.app_service_plan_sku
  zone_balancing_enabled = var.zone_balancing_enabled
  worker_count = var.worker_count

  tags = var.tags
}

module "avm-res-web-site" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.19.1"

  name                = var.logic_app_workflow_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.app_service_plan_os_type
  kind                = var.app_service_kind
  service_plan_resource_id = module.avm-res-web-serverfarm.resource_id

  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  storage_account_name = azurerm_storage_account.example.name
  enable_application_insights = false
  https_only = true
  client_certificate_mode = "OptionalInteractiveUser"
  client_certificate_enabled = false
  managed_identities = {
    system_assigned = true
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "dotnet"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  site_config = {
    health_check_path = "/"
    health_check_eviction_time_in_min = 2
  }

  tags = var.tags
}