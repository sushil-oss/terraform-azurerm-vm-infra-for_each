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
  tenant_id       = "6381cfae-3f7e-42fb-aef1-16e0aaabd282" 
  client_id      = "ba55fbed-b68a-4a8f-9ab6-2cfa18645ac5"
  client_secret  = "x~68Q~pqWKDyxpWzWWC30mvxDiKa74eTkYh.9boG"
}