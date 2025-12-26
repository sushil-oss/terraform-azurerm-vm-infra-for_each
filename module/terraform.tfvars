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
    name                     = "sushstg5"
    location                 = "westus"
    resource_group_name      = "sushrg1"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }

  storage22 = {
    name                     = "sushstg6"
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

## Subnet Creation ##
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

## Network Interface Card Creation ##
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



## Virtual Machine Creation ##
vms = {
  vm1 = {
    name                = "frontend-vm"
    location            = "westus"
    resource_group_name = "sushrg1"
    vm_size             = "Standard_B1s"
  }

  vm2 = {
    name                = "backend-vm"
    location            = "westus"
    resource_group_name = "sushrg2"
    vm_size             = "Standard_D2s_v3"
  }
}


## Key Vault Creation ##
kvs = {
  kv1 = {
    name                        = "sushkv006"
    location                    = "westus"
    resource_group_name         = "sushrg1"
    sku_name                    = "standard"
    tenant_id                   = "6381cfae-3f7e-42fb-aef1-16e0aaabd282"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    enabled_for_disk_encryption = true
    
    access_policy = [{
      key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
      object_id           = "27f5004b-9b8d-4a70-9010-f7470ea84f41"
      secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
      storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
      tenant_id           = "6381cfae-3f7e-42fb-aef1-16e0aaabd282"
    }]
  }
}

## Secrete Creation ##
secrets = {
  secret1 = {
    name  = "mysecret11"
    value = "supersecrte"

  }
}

## Key Creation ##
keys = {
  key1 = {
    name         = "mykey01"
    key_vault_id = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.KeyVault/vaults/sushkv006"
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

## VContainer Creation ##
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

## SQL Server Creation ##
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

## VSQL Database Creation ##
sqldbs = {
  sqlbd1 = {
    name                = "sushsqldb1"
    location            = "westus"
    server_name         = "sushsqlserver1"
    resource_group_name = "sushrg1"
    server_id           = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Sql/servers/sushsqlserver1"

  }
}

pips = {
  pip1 = {
    name                = "sushpip1"
    location            = "westus"
    resource_group_name = "sushrg1"
    allocation_method   = "Static"

  }
}


lbs = {
  lb1 = {
    name                = "myLoadBalancer1"
    location            = "westus"
    resource_group_name = "sushrg1"
    sku                 = "Standard"
    frontend_ip_configuration = {
      pip1 = {
        name                 = "frontend1"
        public_ip_address_id = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/publicIPAddresses/mypip1"
      }
    }

  }
}


## AKS Cluster Creation ##
aks_clusters = {
  aks1 = {
    name                = "aks-cluster1"
    location            = "westus"
    resource_group_name = "sushrg1"
    dns_prefix          = "aksdns1"

    default_node_pool = {
      name       = "default"
      node_count = 1
      vm_size    = "Standard_D2s_v3"
    }

    identity = {
      type = "SystemAssigned"
    }
  }
}

acrs = {
  acr1 = {
    name                = "sushacr1"
    location            = "westus"
    resource_group_name = "sushrg1"
    sku                 = "Basic"
    admin_enabled       = false

  }
}  

role_assigns = {
  role1 = {
    principal_id                     = "f352838a-bb61-47ee-9b04-cda1e470c55c"
    role_definition_name             = "AcrPull"
    scope                            = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.ContainerRegistry/registries/sushacr1"
    skip_service_principal_aad_check = false
  }
}


private_endpoints = {
  pep1 = {
    name                = "mypep1"
    location            = "westus"
    resource_group_name = "sushrg1"
    subnet_id           = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/virtualNetworks/mynet1/subnets/mysub11"

    private_service_connection = {
      name                           = "mypsc1"
      private_connection_resource_id = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Storage/storageAccounts/sushstg5"
      is_manual_connection           = false

      subresource_names = ["blob"]
    }
  }
}



app_gws = {
  appgw1 = {
    name                = "appgw1"
    location            = "westus"
    resource_group_name = "sushrg1"

    sku = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 2
    }

    gateway_ip_configuration = {
      name      = "gatewayipconfig1"
      subnet_id = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/virtualNetworks/mynet1/subnets/mysub11"
    }

    frontend_ip_configuration = {
      name                 = "frontend1"
      public_ip_address_id = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/publicIPAddresses/mypip1"
    }

    frontend_port = {
      name = "frontendport1"
      port = 80
    }

    backend_address_pool = {
      name = "backendaddresspool1"
    }

    backend_http_settings = {
      name                  = "backendhttpsettings1"
      cookie_based_affinity = "Disabled"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 20
    }

    http_listener = {
      name                           = "httplistener1"
      frontend_ip_configuration_name = "frontend1"
      frontend_port_name             = "frontendport1"
      protocol                       = "Http"
    }

    request_routing_rule = {
      name                       = "requestroutingrule1"
      rule_type                  = "Basic"
      http_listener_name         = "httplistener1"
      backend_address_pool_name  = "backendaddresspool1"
      backend_http_settings_name = "backendhttpsettings1"
    }
  }
}


bastions = {
  bastion1 = {
    name                = "mybastionhost1"
    location            = "westus"
    resource_group_name = "sushrg1"

    ip_configuration = {
      name                 = "ipconfig1"
      subnet_key           = "bastion_subnet"
      public_ip_address_id = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/publicIPAddresses/mypip1"
      }
    
  }
}

subnet_ids = {
  bastion_subnet = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/virtualNetworks/mynet1/subnets/AzureBastionSubnet"
}


firewalls = {
  fire1 = {
    name                = "sushfire1"
    location            = "westus"
    resource_group_name = "sushrg1"
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"
    ip_configuration = {
      name                 = "firewallipconfig1"
      subnet_key           = "firewall_subnet"
      subnet_id            = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/virtualNetworks/mynet1/subnets/AzureFirewallSubnet"
     # public_ip_address_id = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.Network/publicIPAddresses/firewallpip1"
    }
    
  }
}

nsgs = {
  nsg1 = {
    name                = "mynsg1"
    location            = "westus"
    resource_group_name = "sushrg1"

    security_rule = {
      name                       = "allow_ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    
  }
}


laws = {
  law1 = {
    name                = "sushlaw2"
    location            = "westus"
    resource_group_name = "sushrg1"
    sku                 = "PerGB2018"
    retention_in_days   = 30
  }
}

app_insites = {
  appinsite1 = {
    name                = "appinsite1"
    location            = "westus"
    resource_group_name = "sushrg1"
    application_type    = "web"
    workspace_id        = "/subscriptions/6c750392-d85d-41e6-a2be-4dc4ddc9d11d/resourceGroups/sushrg1/providers/Microsoft.OperationalInsights/workspaces/sushlaw2"
    tags = {
      environment = "staging"
  }
}
}

