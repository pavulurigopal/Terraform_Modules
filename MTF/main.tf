
#Create resource Groups for  comcom, mcaid, software_group and network_components group
resource "azurerm_resource_group" "resource_group_comcom" {
  name     = var.comcom_resource_group_name
  location = var.azure_location
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
resource "azurerm_resource_group" "resource_group_mcaid" {
  name     = var.mcaid_resource_group_name
  location = var.azure_location
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
resource "azurerm_resource_group" "resource_group_softwaregroup" {
  name     = var.softwaregroup_resource_group_name
  location = var.azure_location
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
resource "azurerm_resource_group" "resource_group_internal" {
  name     = var.internal_resource_group_name
  location = var.azure_location
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#Create storage account 1
resource "azurerm_storage_account" "storage_account1" {
  name                     = var.storage_account1_name
  resource_group_name      = data.azurerm_resource_group.existing_stg_network_rg.name
  location                 = var.azure_location
  account_tier             = "Premium"
  account_replication_type = "LRS"
  network_rules {
    default_action = "Deny"
    #virtual_network_subnet_ids = [data.azurerm_subnet.comcom_subnet_XipAdmin.id]
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#Create Azure Key vault
data "azurerm_client_config" "current" {}
module "app_keyvault" {
  source                     = "./../tf-modules/key_vault"
  key_vault_name             = var.app_keyvault_name
  resource_group_name        = data.azurerm_resource_group.existing_stg_network_rg.name
  location                   = var.azure_location
  virtual_network_subnet_ids = [azurerm_subnet.subnet_comcom_xipadmin.id,azurerm_subnet.subnet_comcom_xipms.id,azurerm_subnet.subnet_mcaid_xipadmin.id,azurerm_subnet.subnet_mcaid_xipms.id,azurerm_subnet.subnet_softwaregroup_aks.id]
  /*   policies = {
    full = {
      tenant_id = "<ADD-TENANT-ID"
      object_id = "<ADD-OBJECT-ID>"
      key_permissions = [
        "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"
      ]
      secret_permissions = [
        "backup", "delete", "get", "list", "purge", "recover", "restore", "set"
      ]
      storage_permissions = [
        "backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"
      ]
    }
    read = {
      tenant_id               = "<ADD-TENANT-ID"
      object_id               = "<ADD-OBJECT-ID>"
      key_permissions         = ["get", "list", ]
      secret_permissions      = ["get", "list", ]
      certificate_permissions = ["get", "getissuers", "list", "listissuers", ]
    } 
  } */
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}