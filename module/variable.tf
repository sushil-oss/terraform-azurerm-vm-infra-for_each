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
    storage_account_key   = optional(string)
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
    name = string
    # location            = string
    # server_name         = string
    # resource_group_name = string
    server_id = optional(string)
  }))

}

variable "pips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
  }))
}



variable "lbs" {
  type = map(object({
    name                      = string
    location                  = string
    resource_group_name       = string
    sku                       = string
    frontend_ip_configuration = map(object({
      name                 = string
      public_ip_address_id = string
    }))
  }))
}


variable "aks_clusters" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string

    default_node_pool = object({
      name       = string
      node_count = number
      vm_size    = string
    })

    identity = object({
      type = string
    })
  }))
}


variable "acrs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    admin_enabled       = bool
}))
}

variable "role_assigns" {
  type = map(object({
    principal_id                     = string
    role_definition_name             = string
    scope                            = string
    skip_service_principal_aad_check = optional(bool)
  }))
}

variable "private_endpoints" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string

    private_service_connection = object({
      name                           = string
      private_connection_resource_id = string
      is_manual_connection           = bool
      subresource_names              = list(string)
    })
  }))
}



variable "app_gws" {
    type = map(object({
      name = string
      location            = string
      resource_group_name = string
      backend_http_settings = object({
        name                  = string
        cookie_based_affinity = string
        port                  = number
        protocol              = string
        request_timeout       = number
      })
      sku = object({
        name     = string
        tier     = string
        capacity = number
      })
      gateway_ip_configuration = object({
        name      = string
        subnet_id = string
      })
      frontend_port = object({
        name = string
        port = number
      })
      frontend_ip_configuration = object({
        name                 = string
        public_ip_address_id = string
      })
      backend_address_pool = object({
        name = string
      })
      http_listener = object({
        name                           = string
        frontend_ip_configuration_name = string
        frontend_port_name             = string
        protocol                       = string
      })

      request_routing_rule = object({
        name                       = string
        rule_type                  = string
        http_listener_name         = string
        backend_address_pool_name  = string
        backend_http_settings_name = string
      })
      }))
}


variable "bastions" {
    type = map(object({
      name                = string
      location            = string
      resource_group_name = string
      ip_configuration = object({
        name                 = string
        subnet_id            = optional(string)
        subnet_key           = optional(string)
        public_ip_address_id = string
      })
      }))
  }

    variable "subnet_ids" {
        type    = map(string)
        default = {}
        description = "Map of subnet_key => subnet id passed from root module"
    }

    variable "firewalls" {
    type = map(object({
      name                = string
      location            = string
      resource_group_name = string
      sku_name            = string
      sku_tier            = string
      ip_configuration = object({
        name                 = string
        subnet_id            = optional(string)
        subnet_key           = optional(string)
       
      })
      }))
}

variable "sub_ids" {
  type    = map(string)
  default = {}
  description = "Map of subnet_key => subnet id passed from root module"
}

variable "nsgs" {
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        security_rule = object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
        })
    }))
  
}


variable "app_insites" {
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        application_type    = string
        workspace_id        = string
        tags                = map(string)
    }))
}



variable "laws" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    retention_in_days   = number
  }))
}