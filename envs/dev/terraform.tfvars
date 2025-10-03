location                 = "uksouth"
account_tier             = "Standard"
account_replication_type = "LRS"

logic_apps = [
  {
    logic_app_name      = "myworkflow"
    resource_group_name = "rg-dev-uks"
    app_service_plan_sku_name = "WS1"
  },
  {
    logic_app_name      = "anotherworkflow"
    resource_group_name = "rg-dev-uks"
    app_service_plan_sku_name = "P1v2"
  }
]