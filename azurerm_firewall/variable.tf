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
