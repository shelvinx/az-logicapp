location                 = "uksouth"
account_tier             = "Standard"
account_replication_type = "LRS"
zone_balancing_enabled   = true
environment              = "dev"

keyvault_resource_group = {
  name     = "lxr-rg-shared"
  location = "uksouth"
}

loganalytics_resource_group = {
  name     = "lxr-rg-loganalytics"
  location = "uksouth"
}

logic_apps = {
  lxr-app-1 = {
    location = "uksouth"
    app_service_plan_sku = "WS1"
    storage_account_name = "stworkflow1devuks01"
  }
}

tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
}