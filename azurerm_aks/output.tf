output "aks_identity_principal_ids" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.identity[0].principal_id
  }
}
