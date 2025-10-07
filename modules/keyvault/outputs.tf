output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = module.keyvault.resource_id
}
