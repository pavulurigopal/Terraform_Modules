terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.46.0"
    }
  }
}

provider "azurerm" {
 features {}
 client_id       = 
 client_secret   = 
 subscription_id = 
 tenant_id       = 
 version         = "~> 2.46.0"
}
  
terraform {
  backend "azurerm" {
    resource_group_name  = "pocterraform_RG"
    storage_account_name = "pocterafrmsa"
    container_name       = "terraformstatefile"
    key                  = "poc-tf-state-file"
    access_key           = 
 }
}


  
