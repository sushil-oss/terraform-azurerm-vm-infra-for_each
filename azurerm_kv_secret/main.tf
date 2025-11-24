resource "azurerm_key_vault_secret" "mysc1" {
  for_each     = var.secrets
  name         = each.value.name
  value        = each.value.value
  key_vault_id = each.value.key_vault_id != null ? each.value.key_vault_id : var.default_key_vault_id
}


