
output "rg_myvm" {
    value = azurerm_virtual_machine.myvm
    sensitive  = true
}

