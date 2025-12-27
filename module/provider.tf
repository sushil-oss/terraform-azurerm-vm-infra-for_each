terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }

#   backend "azurerm" {
#     resource_group_name   = "radha-rg"           # <-- replace with your state RG
#     storage_account_name  = "radhastg"  # <-- replace with your storage account
#     container_name        = "sushcont"             # <-- replace with your blob container
#     key                   = "terraform.tfstate"   # <-- state file name/path
#   }
}

provider "azurerm" {
  features {}

  subscription_id = "6c750392-d85d-41e6-a2be-4dc4ddc9d11d"
  tenant_id       = "xxxx" 
  client_id      = "xxxx"
  client_secret  = "xxxx"
}