variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault"
  type        = string
}

variable "location" {
  description = "The Azure Region where the Key Vault should exist"
  type        = string
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for soft-deleted key vault"
  type        = number
  default     = 90
}

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault?"
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are 'standard' and 'premium'"
  type        = string
  default     = "standard"
}

variable "network_acl_default_action" {
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids."
  type        = string
  default     = "Deny"
}

variable "network_acl_bypass" {
  description = "Specifies which traffic can bypass the network acls. Possible values are 'AzureServices' and 'None'"
  type        = string
  default     = "AzureServices"
}

variable "network_acl_ip_rules" {
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}


