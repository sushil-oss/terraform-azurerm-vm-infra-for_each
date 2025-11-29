rg_name = {
  rg1 = {
    name     = "sushrg1"
    location = "westus"
  }
  rg2 = {
    name     = "sushrg2"
    location = "westus"
  }
}

#### Storage Accounts ####
storages = {

  storage11 = {
    name                     = "sushstg1"
    location                 = "westus"
    resource_group_name      = "sushrg1"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }

  storage22 = {
    name                     = "sushstg2"
    location                 = "westus"
    resource_group_name      = "sushrg2"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}


## Virtual Networks ##
vnets = {
  vnets1 = {
    name                = "mynet1"
    address_space       = ["10.0.0.0/16"]
    location            = "westus"
    resource_group_name = "sushrg1"
  }

  vnets2 = {
    name                = "mynet2"
    address_space       = ["10.0.0.0/16"]
    location            = "westus"
    resource_group_name = "sushrg2"
  }
}


subnets = {
  subnet1 = {
    name                 = "mysub11"
    resource_group_name  = "sushrg1"
    virtual_network_name = "mynet1"
    address_prefixes     = ["10.0.2.0/24"]
  }

  subnet2 = {
    name                 = "mysub22"
    resource_group_name  = "sushrg2"
    virtual_network_name = "mynet2"
    address_prefixes     = ["10.0.3.0/24"]
  }
}


nics = {
  "nic1" = {
    name                = "mynic1"
    location            = "westus"
    resource_group_name = "sushrg1"
    ip_configurations = [
      {
        name                          = "internal"
        subnet_key                    = "subnet1"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }

  "nic2" = {
    name                = "mynic2"
    location            = "westus"
    resource_group_name = "sushrg2"
    ip_configurations = [
      {
        name                          = "internal"
        subnet_key                    = "subnet2"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
}




vms = {
  vm1 = {
    name                = "frontend-vm"
    location            = "westus"
    resource_group_name = "sushrg1"
    #network_interface_keys = ["nic1"]
    vm_size = "Standard_B1s"
    #network_interface_ids  = [module.rg_nic.nic_ids["nic1"]]
  }

  vm2 = {
    name                = "backend-vm"
    location            = "westus"
    resource_group_name = "sushrg2"
    # network_interface_keys = ["nic1"]
    vm_size = "Standard_B1s"
    #network_interface_ids  = [module.rg_nic.nic_ids["nic2"]]
  }
}


kvs = {
  kv1 = {
    name                        = "sushkv003"
    location                    = "westus"
    resource_group_name         = "sushrg1"
    sku_name                    = "standard"
    tenant_id                   = "28c3654a-a897-4228-8e6a-099ee5e50a80"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    enabled_for_disk_encryption = true
    access_policy = [{
      key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
      object_id           = "f7b7fd9f-c1a6-4224-9ac1-17130f6d1693"
      secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
      storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
      tenant_id           = "28c3654a-a897-4228-8e6a-099ee5e50a80"
    }]
  }
}


secrets = {
  secret1 = {
    name  = "mysecret11"
    value = "supersecrte"

  }
}


keys = {
  key1 = {
    name         = "mykey01"
    key_vault_id = ""
    key_type     = "RSA"
    key_size     = 2048
    key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    rotation_policy = {
      # automatic = {
      #   time_before_expiry = "P30D"
      # }
      expire_after         = "P90D"
      notify_before_expiry = "P15D"
    }
  }
}

containers = {
  container1 = {
    name                  = "sushcont001"
    container_access_type = "private"
    storage_account_key   = "storage11"
     #storage_account_id    = module.storage_account.storage_account_ids["storage11"]
  }

  container2 = {
    name                  = "sushcont002"
    container_access_type = "private"
    storage_account_key   = "storage22"
     #storage_account_id    = module.storage_account.storage_account_ids["storage22"]
  }
}


sqlservers = {
  sqlserver12 = {
    name                         = "sushsqlserver1"
    resource_group_name          = "sushrg1"
    administrator_login          = "4dm1n157r470r"
    administrator_login_password = "4-v3ry-53cr37-p455w0rd"
    version                      = "12.0"
    location                     = "westus"
  }
}


sqldbs = {
  sqlbd1 = {
    name                = "sushsqldb1"
    location            = "eastus"
    server_name         = ""
    resource_group_name = ""
    server_id = ""


  }
}
