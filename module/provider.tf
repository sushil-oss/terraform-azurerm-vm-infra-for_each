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
  subscription_id = "345f5a23-b761-4ede-ab2b-beedb9d58ab1"
}