output "sqlserver_names" {
  value = { for k, s in azurerm_mssql_server.mysql1 : k => s.name }
}

output "resource_group_names" {
  value = { for k, s in azurerm_mssql_server.mysql1 : k => s.resource_group_name }
}

output "server_ids" {
  value = { for k, s in azurerm_mssql_server.mysql1 : k => s.id }
}