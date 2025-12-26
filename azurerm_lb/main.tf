resource "azurerm_lb" "mylb1" {

  for_each            = var.lbs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configuration
    content {
      name                 = frontend_ip_configuration.value.name

      public_ip_address_id = frontend_ip_configuration.value.public_ip_address_id

    }
  }

}
