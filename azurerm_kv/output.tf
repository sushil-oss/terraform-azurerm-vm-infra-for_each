output "kv_ids" {
  description = "Map of Key Vault key => Key Vault ID"
  value       = { for k, v in azurerm_key_vault.kv1 : k => v.id }
}

output "kv_names" {
  description = "Map of Key Vault key => Key Vault Name"
  value       = { for k, v in azurerm_key_vault.kv1 : k => v.name }
}

output "kv_uris" {
  description = "Map of Key Vault key => Vault URI (for secrets if needed)"
  value       = { for k, v in azurerm_key_vault.kv1 : k => v.vault_uri }
}

output "kv_resource_groups" {
  description = "Map of Key Vault key => Resource Group Name"
  value       = { for k, v in azurerm_key_vault.kv1 : k => v.resource_group_name }
}

output "kv_locations" {
  description = "Map of Key Vault key => Location"
  value       = { for k, v in azurerm_key_vault.kv1 : k => v.location }
}


