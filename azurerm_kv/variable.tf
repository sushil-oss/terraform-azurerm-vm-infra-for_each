variable "kvs" {
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    sku_name                    = string
    tenant_id                   = string
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    enabled_for_disk_encryption = bool
    


    access_policy = list(object({
      tenant_id           = string
      object_id           = string
      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
      }
    ))
  }))
}
variable "default_key_vault_id" {
    type = string
    description = "default key vault id to use if not specified in secret"
  
}

