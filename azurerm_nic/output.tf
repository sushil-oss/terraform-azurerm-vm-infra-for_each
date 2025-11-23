output "nic_ids" {
  value = { for k, nic in azurerm_network_interface.mynic : k => nic.id }
}
