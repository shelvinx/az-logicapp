variable "name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Log Analytics Workspace."
  type        = string
}

variable "location" {
  description = "The Azure Region where the Log Analytics Workspace should exist."
  type        = string
}

variable "sku" {
  description = "The SKU of the Log Analytics Workspace."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The retention in days for the Log Analytics Workspace."
  type        = number
  default     = 30
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
