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

