variable "vms" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    network_interface_ids = optional(list(string))
    vm_size               = string
  }))

}

variable "nic_ids" {
  type        = map(string)
  description = "Map of NIC names to NIC IDs"
}
