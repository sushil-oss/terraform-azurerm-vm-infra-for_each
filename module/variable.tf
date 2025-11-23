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
          subnet_key                    = optional(string)   # optional
          private_ip_address_allocation = string
        })
      )
    )
  }))
}


variable "vms" {
    type = map(object({
      name  = string
      location = string
      resource_group_name = string
      network_interface_ids = optional(list(string))
      vm_size = string
    }))
  
}

