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
  depends_on = [module.storage_account]
  source     = "../azurerm_stg_container"
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
  depends_on           = [module.key_voult, module.kv_secrets, ]
  source               = "../azurerm_kv_key"
  keys                 = var.keys
  default_key_vault_id = module.key_voult.kv_ids["kv1"]

}

module "sql_server" {
  depends_on = [module.key_voult]
  source     = "../azurerm_sql_server"
  sqlservers = var.sqlservers
}

module "sql_db" {
  depends_on = [module.sql_server]
  source     = "../azurerm_sql_db"
  sqldbs = {
    for k, v in var.sqldbs :
    k => merge(v, {
      server_id = module.sql_server.server_ids["sqlserver12"]
    })
  }

}

module "pip" {
  depends_on = [module.rg_vm]
  source     = "../azurerm_pip"
  pips       = var.pips

}


module "lbss" {
  depends_on = [module.pip]
  source     = "../azurerm_lb"
  lbs        = var.lbs
}


module "aks" {
  depends_on   = [module.rg_subnet]
  source       = "../azurerm_aks"
  aks_clusters = var.aks_clusters
}

module "acr" {
  depends_on = [module.aks]
  source     = "../azurerm_acr"
  acrs       = var.acrs
}

locals {
  role_assigns = {
    role1 = {
      principal_id                     = module.aks.aks_identity_principal_ids["aks1"]
      role_definition_name             = "AcrPull"
      scope                            = module.acr.acr_ids["acr1"]
      skip_service_principal_aad_check = false
    }
  }
}

module "role_assigns" {
  depends_on   = [module.acr]
  source       = "../azurerm_role_assign"
  role_assigns = local.role_assigns
}

module "private_endpoints" {
  depends_on        = [module.acr, module.vnet, module.rg_subnet]
  source            = "../azurerm_private_ep"
  private_endpoints = var.private_endpoints
 
}


module "app_gw" {
  depends_on = [module.vnet, module.pip, module.rg_subnet]
  source     = "../azurerm_app_gateway"
  app_gws    = var.app_gws
}

module "bastion" {
  depends_on    = [module.rg_subnet, module.pip, module.rg_vm]
  source        = "../azurerm_bastion"
  bastions      = var.bastions
  subnet_ids    = var.subnet_ids
}

module "firewall" {
  depends_on    = [module.rg_subnet, module.pip, module.rg_vm]
  source        = "../azurerm_firewall"
  firewalls      = var.firewalls 
  sub_ids    = var.sub_ids
  
}


module "nsgs" {
  depends_on = [module.rg_vm]
  source     = "../azurerm_nsg"
  nsgs       = var.nsgs
}

module "app_insites" {
  depends_on = [module.resource_group, module.law]
  source     = "../azurerm_app_insite"

  app_insites = var.app_insites
}


module "law" {
  depends_on = [module.resource_group]
  source     = "../azurerm_law"
  laws       = var.laws
}