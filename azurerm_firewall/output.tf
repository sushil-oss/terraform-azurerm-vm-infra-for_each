output "firewalls" {
  value = var.firewalls
}

output "firewall_ids" {
  value = { for k, v in azurerm_firewall.myfire1 : k => v.id }
}