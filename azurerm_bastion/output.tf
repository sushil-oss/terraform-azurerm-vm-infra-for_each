output "bastions" {
    value = azurerm_bastion_host.mybas1
}

output "bastion_ids" {
  value = { for k, v in azurerm_bastion_host.mybas1 : k => v.id }
}

