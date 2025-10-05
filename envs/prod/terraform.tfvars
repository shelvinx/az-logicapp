location                 = "uksouth"
account_tier             = "Standard"
account_replication_type = "LRS"
zone_balancing_enabled   = false
environment              = "prod"

resource_groups = {
  lxr-rg-1 = {
    location = "uksouth"
  }
}

logic_apps = {
  lxr-app-1 = {
    resource_group_name = "lxr-rg-1"
    app_service_plan_sku = "WS1"
    storage_account_name = "stworkflow1devuks01"
  }
}

tags = {
  Environment = "prod"
  ManagedBy   = "Terraform"
}