variable "nics" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    ip_configurations = optional(
      list(
        object({
          name                          = string
          subnet_id                     = string
          #subnet_key                     = string    # just key like "subnet1"
          private_ip_address_allocation = string
        })
      )
    )
  }))
}


# variable "subnet_ids" {
#   type = map(string)
#   description = "Map of subnet keys to subnet IDs"
# }