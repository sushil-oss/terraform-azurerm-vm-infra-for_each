resource "azurerm_private_endpoint" "mypep1" {
  for_each            = var.private_endpoints
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = each.value.private_service_connection.name
    private_connection_resource_id = each.value.private_service_connection.private_connection_resource_id
    is_manual_connection           = each.value.private_service_connection.is_manual_connection

    subresource_names = each.value.private_service_connection.subresource_names
  }
}
