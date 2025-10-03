variable "app_service_plan_os_type" {
  type = string
  description = "App Service Plan OS Type"

  validation {
    condition     = var.app_service_plan_os_type == "Windows" || var.app_service_plan_os_type == "Linux"
    error_message = "app_service_plan_os_type must be Windows or Linux"
  }
}

variable "app_service_kind" {
  type = string
  description = "App Service Type"

  validation {
    condition     = var.app_service_kind == "functionapp" || var.app_service_kind == "webapp" || var.app_service_kind == "logicapp"
    error_message = "app_service_kind must be functionapp or webapp or logicapp"
  }
}

variable "app_service_plan_sku" {
  type = string
  description = "App Service Plan SKU"
}

variable "location" {
  type = string
  description = "Location"
}

variable "resource_group_name" {
    type = string
    description = "Resource Group Name"
}

variable "account_tier" {
    type = string
    description = "Account Tier"
}

variable "account_replication_type" {
    type = string
    description = "Account Replication Type"
}

variable "storage_account_name" {
    type = string
    description = "Storage Account Name"
}

variable "app_service_plan_name" {
    type = string
    description = "App Service Plan Name"
}

variable "logic_app_workflow_name" {
    type = string
    description = "Logic App Workflow Name"
}