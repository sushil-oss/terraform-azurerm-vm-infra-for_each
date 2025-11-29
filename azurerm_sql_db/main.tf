resource "azurerm_mssql_database" "sqldb1" {
  for_each            = var.sqldbs
  name                = each.value.name
  #location            = each.value.location
  #server_name         = each.value.server_name
  #resource_group_name = each.value.resource_group_name
  server_id = each.value.server_id
}
