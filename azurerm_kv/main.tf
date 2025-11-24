resource "azurerm_key_vault" "kv1" {
  for_each                    = var.kvs
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  sku_name                    = each.value.sku_name
  tenant_id                   = each.value.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption

  dynamic "access_policy" {
    for_each = each.value.access_policy
    content {
      tenant_id = access_policy.value.tenant_id
      object_id = access_policy.value.object_id

      key_permissions     = access_policy.value.key_permissions
      secret_permissions  = access_policy.value.secret_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }
}

