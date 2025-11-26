resource "azurerm_key_vault_key" "mykey1" {
  for_each     = var.keys
  name         = each.value.name
  key_vault_id = each.value.key_vault_id != "" ? each.value.key_vault_id : var.default_key_vault_id
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_opts     = each.value.key_opts

  dynamic "rotation_policy" {
    for_each = each.value.rotation_policy == null ? [] : [each.value.rotation_policy]
    content {
      expire_after         = rotation_policy.value.expire_after
      notify_before_expiry = rotation_policy.value.notify_before_expiry
      }
      }
      

  }


