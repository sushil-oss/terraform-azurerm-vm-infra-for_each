resource "azurerm_network_interface" "mynic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = lookup(
      each.value,
      "ip_configurations",
      [
        {
          name                          = "internal"
          subnet_key                     = "subnet1"   # default key
          private_ip_address_allocation = "Dynamic"
        }
      ]
    )

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    }
  }
}
