variable "logic_apps" {
  description = "A list of Standard Logic Apps to deploy."
  type = list(object({
    logic_app_name            = string
    resource_group_name       = string
    app_service_plan_sku_name = string
    storage_account_name      = string
  }))

  validation {
    condition = alltrue([
      for app in var.logic_apps : can(regex("^[a-z0-9]+$", app.storage_account_name))
    ])
    error_message = "Storage account names must only contain lowercase letters and numbers."
  }
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be deployed."
}

variable "environment" {
  type        = string
  description = "The deployment environment name (e.g., 'dev', 'prod')."
  default     = "dev"
}

variable "account_tier" {
  type        = string
  description = "The storage account tier."
}

variable "account_replication_type" {
  type        = string
  description = "The storage account replication type."
}