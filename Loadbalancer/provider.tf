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
 client_id       = "8bd86f5a-45e4-4efb-9de5-3dd3767b3063"
 client_secret   = "s5HAyiE81c3S6E5s_g~-P0bG9-q-Od7s3a"
 subscription_id = "34bb2ac5-01b1-4ee6-b4ca-c133469dc1a4"
 tenant_id       = "470304bc-324e-436e-8af9-9ed8502e3e83"
 version         = "~> 2.46.0"
}
  
terraform {
  backend "azurerm" {
    resource_group_name  = "pocterraform_RG"
    storage_account_name = "pocterafrmsa"
    container_name       = "terraformstatefile"
    key                  = "poc-tf-state-file"
    access_key           = "0Ha47KcPbsBmG7CzNuCDlz45lyAn2tIxspcaTV7lReaEhcn5ViqwDvHLJbStpvfCza/u5s2fk4ATDGV/IDLQ6Q=="
 }
}


  