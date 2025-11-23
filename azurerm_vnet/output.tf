output "virtual_network" {
    value = { for k, v in azurerm_virtual_network.vnet1 : k => var.vnets}
}