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