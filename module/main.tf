module "resource_group" {
  source  = "../resource_group"
  rg_name = var.rg_name

}

module "storage_account" {
  depends_on = [module.resource_group]
  source     = "../storage_account"
  storages   = var.storages
}

module "rg_container" {
  depends_on = [ module.storage_account ]
  source = "../azurerm_stg_container"
  containers = {
    for k, v in var.containers : k => {
      name                  = v.name
      container_access_type = v.container_access_type
      storage_account_id    = module.storage_account.storage_account_ids[v.storage_account_key]
    }
  }
}


module "vnet" {
  depends_on = [module.storage_account]
  source     = "../azurerm_vnet"
  vnets      = var.vnets
}

module "rg_subnet" {
  depends_on = [module.vnet]
  source     = "../azurerm_subnet"
  subnets    = var.subnets
}

module "rg_nic" {
  depends_on = [module.rg_subnet]
  source     = "../azurerm_nic"
  nics = {
    for k, nic in var.nics : k => merge(
      nic,
      {
        ip_configurations = [
          for ip in nic.ip_configurations : merge(
            ip,
            {
              subnet_id = module.rg_subnet.subnets[ip.subnet_key].id
            }
          )
        ]
      }
    )
  }
}



module "rg_vm" {
  depends_on = [module.rg_nic]
  source     = "../azurerm_vm"
  vms        = var.vms
  nic_ids = {
    vm1 = module.rg_nic.nic_ids["nic1"]
    vm2 = module.rg_nic.nic_ids["nic2"]
  }
}


module "key_voult" {
  depends_on           = [module.resource_group]
  source               = "../azurerm_kv"
  kvs                  = var.kvs
  default_key_vault_id = module.key_voult.kv_ids["kv1"]
}


module "kv_secrets" {
  depends_on           = [module.key_voult]
  source               = "../azurerm_kv_secret"
  secrets              = var.secrets
  default_key_vault_id = module.key_voult.kv_ids["kv1"]
}


module "kv_keys" {
  depends_on           = [module.key_voult, module.kv_secrets,]
  source               = "../azurerm_kv_key"
  keys                 = var.keys
  default_key_vault_id = module.key_voult.kv_ids["kv1"]

}
