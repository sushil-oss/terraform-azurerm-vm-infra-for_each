module "resource_group" {
    source = "../resource_group"
    rg_name = var.rg_name
  
}

module "storage_account" {
    source = "../storage_account"
    storages = var.storages
  
}