output "resource_group_names" {
  value = { for k, v in azurerm_resource_group.rgname1 : k => v.name }
}

output "resource_group_ids" {
  value = { for k, v in azurerm_resource_group.rgname1 : k => v.id }
}