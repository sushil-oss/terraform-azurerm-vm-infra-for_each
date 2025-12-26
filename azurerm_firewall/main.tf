resource "azurerm_firewall" "myfire1" {
  for_each            = var.firewalls
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier

  ip_configuration {
    name = each.value.ip_configuration.name
    subnet_id = try(
      each.value.ip_configuration.subnet_id,
      lookup(var.sub_ids, each.value.ip_configuration.subnet_key, null)
    )
    
  }
}
