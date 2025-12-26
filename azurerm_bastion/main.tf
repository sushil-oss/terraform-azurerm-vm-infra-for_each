resource "azurerm_bastion_host" "mybas1" {
  for_each            = var.bastions
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name = each.value.ip_configuration.name
    subnet_id = try(
      each.value.ip_configuration.0.subnet_id,
      lookup(var.subnet_ids, each.value.ip_configuration.subnet_key)
    )
    public_ip_address_id = each.value.ip_configuration.public_ip_address_id
  }
}
