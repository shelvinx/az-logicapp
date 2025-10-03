variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "environment" {
  type        = string
  description = "Environment Name"
  default     = "dev"
}

variable "account_tier" {
    type = string
    description = "Account Tier"
}

variable "account_replication_type" {
    type = string
    description = "Account Replication Type"
}

variable "app_service_plan_sku" {
    type = string
    description = "App Service Plan SKU"
}
