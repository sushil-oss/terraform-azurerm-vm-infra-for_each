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
        subnet_id = optional(string)
        subnet_key = optional(string)
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

variable "subnet_ids" {
  type    = map(string)
  default = {}
  description = "Map of subnet_key => subnet id passed from root module"
}