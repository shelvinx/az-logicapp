location                 = "uksouth"
account_tier             = "Standard"
account_replication_type = "LRS"

resource_groups = {
  lxr-rg-1 = {
    location = "uksouth"
  }
  lxr-rg-2 = {
    location = "uksouth"
  }
}

logic_apps = {
  lxr-app-1 = {
    resource_group_name = "lxr-rg-1"
    app_service_plan_sku = "WS1"
    storage_account_name = "stworkflow1devuks01"
  },
  lxr-app-2 = {
    resource_group_name = "lxr-rg-2"
    app_service_plan_sku = "WS1"
    storage_account_name = "stworkflow2devuks01"
  }
}