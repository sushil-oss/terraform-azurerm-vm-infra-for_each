resource "azurerm_storage_container" "mycont1" {
  for_each              = var.containers
  name                  = each.value.name
  storage_account_id = each.value.storage_account_id
  container_access_type = each.value.container_access_type
  
}
