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
