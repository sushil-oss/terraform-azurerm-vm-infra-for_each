resource "azurerm_application_gateway" "myappgw1" {
  for_each            = var.app_gws
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  backend_http_settings {
    name                  = each.value.backend_http_settings.name
    cookie_based_affinity = each.value.backend_http_settings.cookie_based_affinity
    port                  = each.value.backend_http_settings.port
    protocol              = each.value.backend_http_settings.protocol
    request_timeout       = each.value.backend_http_settings.request_timeout
  }
  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity

  }

  gateway_ip_configuration {
    name = each.value.gateway_ip_configuration.name

    subnet_id = try(
      each.value.gateway_ip_configuration.subnet_id,
      lookup(var.subnet_ids, each.value.gateway_ip_configuration.subnet_key, null)
    )
  }

  frontend_port {
    name = each.value.frontend_port.name
    port = each.value.frontend_port.port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration.name
    public_ip_address_id = each.value.frontend_ip_configuration.public_ip_address_id
  }

  backend_address_pool {
    name = each.value.backend_address_pool.name
  }

  http_listener {
    name                           = each.value.http_listener.name
    frontend_ip_configuration_name = each.value.http_listener.frontend_ip_configuration_name
    frontend_port_name             = each.value.http_listener.frontend_port_name
    protocol                       = each.value.http_listener.protocol
  }

  request_routing_rule {
    name                       = each.value.request_routing_rule.name
    rule_type                  = each.value.request_routing_rule.rule_type
    http_listener_name         = each.value.request_routing_rule.http_listener_name
    backend_address_pool_name  = each.value.request_routing_rule.backend_address_pool_name
    backend_http_settings_name = each.value.request_routing_rule.backend_http_settings_name

  }
}
