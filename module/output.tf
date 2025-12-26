# output.tf in dev (root module)
output "resource_group_names" {
  value = module.resource_group.resource_group_names
}

output "resource_group_ids" {
  value = module.resource_group.resource_group_ids
}

output "storage_account_names" {
  value = module.storage_account.storage_account_names
}

output "storage_account_ids" {
  value = module.storage_account.storage_account_ids
}


output "virtual_network" {
  value = module.vnet.virtual_network
}

output "subnets" {
  value = module.rg_subnet.subnets
}

output "network_interface" {
  value = module.rg_nic.nic_ids
}


output "rg_vm" {
  value     = module.rg_vm.rg_myvm
  sensitive = true

}


output "key_vault_ids" {
  value = module.key_voult.kv_ids
}

output "key_vault_names" {
  value = module.key_voult.kv_names
}


output "kv_secret" {
  value     = module.kv_secrets.rg_secrets
  sensitive = true
}



output "kv_keys" {
  value = module.kv_keys.rg_keys
}




