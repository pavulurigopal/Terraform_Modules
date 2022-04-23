
#Create resource Groups for  comcom, mcaid, software_group and network_components group
resource "azurerm_resource_group" "resource_group_comcom" {
  name     = var.comcom_resource_group_name
  location = var.azure_location
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application = "Community Commerce Bank Integration Layer"
    ESF_Application_ID = "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Offline Stored Value Account Service"
    ESF_Service_ID = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
}
resource "azurerm_resource_group" "resource_group_mcaid" {
  name     = var.mcaid_resource_group_name
  location = var.azure_location
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Mastercard Aid"
    ESF_Service_ID = "94cfda38-0957-31a9-ae82-29e027bdc8b4"
    ESF_Application = "MC Aid Nextgen"
    ESF_Application_ID = "a34a8685-6dbf-3931-acb8-2b5f4d209a58"
  }
}
resource "azurerm_resource_group" "resource_group_softwaregroup" {
  name     = var.softwaregroup_resource_group_name
  location = var.azure_location
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application 	  = "Community Commerce Bank Integration Layer"
    ESF_Application_ID	= "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program         = "Strategic Growth"
    ESF_Program_ID      = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service         = "Offline Stored Value Account Service"
    ESF_Service_ID      = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
}
resource "azurerm_resource_group" "resource_group_nc" {
  name     = var.nc_resource_group_name
  location = var.azure_location
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
}
resource "azurerm_resource_group" "resource_group_internal" {
  name     = var.internal_resource_group_name
  location = var.azure_location
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
}
#Create storage account 1
resource "azurerm_storage_account" "storage_account1" {
  name                     = var.storage_account1_name
  resource_group_name      = azurerm_resource_group.resource_group_nc.name
  location                 = var.azure_location
  account_tier             = "Premium" #Need to get the correct account_tier for production#
  account_replication_type = "LRS" #Need to get the correct replictaion for production#
  network_rules {
    default_action = "Deny"
    #virtual_network_subnet_ids = [data.azurerm_subnet.comcom_subnet_XipAdmin.id]
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
}
#Create storage account for Boot Diagnostic
resource "azurerm_storage_account" "storage_account2" {
  name                     = var.storage_account2_name
  resource_group_name      = azurerm_resource_group.resource_group_internal.name
  location                 = var.azure_location
  account_tier             = "Standard" #Need to get the correct account_tier for production#
  account_replication_type = "LRS" #Need to get the correct replictaion for production#
  network_rules {
    default_action = "Allow"
    #virtual_network_subnet_ids = [data.azurerm_subnet.mcaidadmin_subnet_name.id]
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_internal]
}
#Create Azure Key vault
data "azurerm_client_config" "current" {}
module "app_keyvault" {
  source                     = "./../tf-modules/key_vault"
  key_vault_name             = var.app_keyvault_name #Key Vault to be manually created#
  resource_group_name        = azurerm_resource_group.resource_group_nc.name
  location                   = var.azure_location
  virtual_network_subnet_ids = ["${local.network_local_s_prefix}${var.softwaregroup_aks_subnet_name}", "${local.network_local_s_prefix}${var.mcaidms_subnet_name}", "${local.network_local_s_prefix}${var.internal_subnet_name}"]
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
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet]

}
module "app_keyvault2" {
  source                     = "./../tf-modules/key_vault"
  key_vault_name             = var.app_keyvault2_name #Key Vault to be manually created#
  resource_group_name        = azurerm_resource_group.resource_group_nc.name
  location                   = var.azure_location
  virtual_network_subnet_ids = ["${local.network_local_s_prefix}${var.softwaregroup_aks_subnet_name}", "${local.network_local_s_prefix}${var.mcaidms_subnet_name}", "${local.network_local_s_prefix}${var.comcomadmin_subnet_name}", "${local.network_local_s_prefix}${var.internal_subnet_name}"]
 
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet]

}


locals {
  network_local_s_prefix = "${var.network_local_s_prefix1}${var.subscription_id}${var.network_local_s_prefix2}${var.nc_resource_group_name}${var.network_local_s_prefix3}${var.network_vnet_name}${var.network_local_s_prefix4}"
}