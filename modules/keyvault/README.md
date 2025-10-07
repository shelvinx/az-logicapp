# Key Vault Module

This Terraform module creates keyvault resources that are used across environments, including Azure Key Vault.

## Usage

```hcl
module "keyvault" {
  source = "../../modules/keyvault"

  key_vault_name              = "kv-${var.environment}-keyvault"
  resource_group_name         = azurerm_resource_group.keyvault.name
  location                    = azurerm_resource_group.keyvault.location
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  sku_name                    = "standard"
  network_acl_default_action  = "Deny"
  network_acl_bypass          = "AzureServices"
  network_acl_ip_rules        = [] # Add your IP addresses here if needed
  tags                        = var.tags
}
```

## Requirements

- Terraform >= 1.0.0
- Azure Provider >= 3.0.0

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key_vault_name | The name of the Key Vault | `string` | n/a | yes |
| resource_group_name | The name of the resource group in which to create the Key Vault | `string` | n/a | yes |
| location | The Azure Region where the Key Vault should exist | `string` | n/a | yes |
| enabled_for_disk_encryption | Whether Azure Disk Encryption is permitted | `bool` | `false` | no |
| soft_delete_retention_days | Number of days to retain soft-deleted items | `number` | `90` | no |
| purge_protection_enabled | Whether Purge Protection is enabled | `bool` | `false` | no |
| sku_name | The SKU of the Key Vault | `string` | `"standard"` | no |
| network_acl_default_action | Default action for network rules | `string` | `"Deny"` | no |
| network_acl_bypass | What can bypass network rules | `string` | `"AzureServices"` | no |
| network_acl_ip_rules | List of IP addresses or CIDR blocks to allow | `list(string)` | `[]` | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| key_vault_id | The ID of the Key Vault |
| key_vault_uri | The URI of the Key Vault |
| key_vault_name | The name of the Key Vault |

## Security Considerations

- Enable `purge_protection_enabled` for production environments
- Configure `network_acl_ip_rules` to restrict access to specific IP addresses
- Use separate Key Vaults for different environments (dev, test, prod)
- Regularly rotate access keys and secrets
- Use Azure Policy to enforce compliance standards for your Key Vaults
