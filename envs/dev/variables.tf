variable "shared_resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "The resource group for shared resources."
}

variable "logic_apps" {
  type = map(any)
  description = "The logic apps to be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be deployed."
}

variable "account_tier" {
  type        = string
  description = "The storage account tier."
}

variable "account_replication_type" {
  type        = string
  description = "The storage account replication type."
}

variable "zone_balancing_enabled" {
  type        = bool
  description = "The zone balancing enabled."
}

variable "environment" {
  type        = string
  description = "The environment."
}

variable "tags" {
  type        = map(any)
  description = "Tags"
}