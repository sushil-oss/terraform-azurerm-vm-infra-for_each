variable "rg_name" {
  type = map(object({
    name     = string
    location = string
  }))
}


variable "storages" {
  type = map(object({
    name                     = string
    location                 = string
    resource_group_name      = string
    account_tier             = string
    account_replication_type = string
  }))

}


variable "vnets" {
  type = map(object({
    name                = string
    address_space       = list(string)
    location            = string
    resource_group_name = string
  }))
}


variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}


variable "nics" {
  #description = "NICs configuration for rg_nic module"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    ip_configurations = optional(
      list(
        object({
          name                          = string
          subnet_id                     = optional(string)
          subnet_key                    = optional(string) # optional
          private_ip_address_allocation = string
        })
      )
    )
  }))
}


variable "vms" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    network_interface_ids = optional(list(string))
    vm_size               = string
  }))

}



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
# variable "default_key_vault_id" {
#     type = string
#     description = "default key vault id to use if not specified in secret"

# }


variable "secrets" {
  description = " A map of secrets to create in key vault"
  type = map(object({
    name         = string
    value        = string
    key_vault_id = optional(string)

  }))
}
variable "default_key_vault_id" {
  type        = string
  description = "Default Key Vault ID to use if not specified per secret"
  default     = "" # Agar default empty hai
}



variable "keys" {
  description = "A map of keys to create in the key vault"
  type = map(object({
    name         = string
    key_vault_id = string
    key_type     = string
    key_size     = number
    key_opts     = list(string)

    rotation_policy = optional(object({
      expire_after         = string
      notify_before_expiry = string
      # automatic = optional(object({
      #   time_before_expiry = string
    }))
  }))
}


variable "containers" {
  type = map(object({
    name                  = string
    container_access_type = string
    storage_account_id    = optional(string)
    storage_account_key = optional(string)
  }))
}


variable "sqlservers" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    administrator_login          = string
    administrator_login_password = string
    version                      = string
    
  }))

}


variable "sqldbs" {
  type = map(object({
    name                = string
   # location            = string
   # server_name         = string
   # resource_group_name = string
    server_id = optional(string)
  }))

}

