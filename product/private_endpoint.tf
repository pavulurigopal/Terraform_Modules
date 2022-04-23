#Create private endpoint for keyvault
resource "azurerm_private_endpoint" "keyvault_plink" {
  name                = var.keyvault_private_endpoint_name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  location            = var.azure_location
  subnet_id           = "${local.network_local_s_prefix}${var.internal_subnet_name}"

  private_service_connection {
    name                           = var.keyvault_private_service_name
    is_manual_connection           = false
    private_connection_resource_id = module.app_keyvault.key_vault_id
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.prd_dns_private_zone.id]
  }

  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, module.app_keyvault]
}

resource "azurerm_private_endpoint" "keyvault_plink2" {
  name                = var.keyvault_private_endpoint2_name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  location            = var.azure_location
  subnet_id           = "${local.network_local_s_prefix}${var.internal_subnet_name}"

  private_service_connection {
    name                           = var.keyvault_private_service2_name
    is_manual_connection           = false
    private_connection_resource_id = module.app_keyvault2.key_vault_id
    subresource_names              = ["vault"]
  }
    private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.prd_dns_private_zone.id]
  }


  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, module.app_keyvault2]
}

########################################################################################################################
#create endpoint for comcom mySQL
resource "azurerm_private_endpoint" "mysql_comcom_plink" {
  name                = var.private_endpoint_mysql_comcom_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  subnet_id           = "${local.network_local_s_prefix}${var.comcomadmin_subnet_name}"

  private_service_connection {
    name                           = var.private_service_mysql_comcom_name
    private_connection_resource_id = azurerm_mysql_server.comcom_db_mysql.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
   private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.mysql_servers_plink_DNS_config.id]
  }
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
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, azurerm_mysql_server.comcom_db_mysql]
  
}
#######################################################################################################################
#create endpoint for mcaid mySQL
resource "azurerm_private_endpoint" "mysql_mcaid_plink" {
  name                = var.private_endpoint_mysql_mcaid_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  subnet_id           = "${local.network_local_s_prefix}${var.mcaidadmin_subnet_name}"

  private_service_connection {
    name                           = var.private_service_mysql_mcaid_name
    private_connection_resource_id = azurerm_mysql_server.mcaid_db_mysql.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.mysql_servers_plink_DNS_config.id]
  }
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
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, azurerm_mysql_server.mcaid_db_mysql]
  
}
#####################################################################################################
#create endpoint for Software-Group MSSQL
resource "azurerm_private_endpoint" "mssql_sg_plink" {
  name                = var.private_endpoint_mssql_sg_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  subnet_id           = "${local.network_local_s_prefix}${var.softwaregroup_aks_subnet_name}"

  private_service_connection {
    name                           = var.private_service_mssql_sg_name
    private_connection_resource_id = azurerm_sql_server.softwaregroup_db_ms_sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.mssql_servers_plink_DNS_config.id]
  }
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
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, azurerm_sql_server.softwaregroup_db_ms_sql_server]
  
}

###########################################################################################################
#create endpoint for storage account
resource "azurerm_private_endpoint" "storageaccount_plink" {
  name                = var.private_endpoint_sa_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  subnet_id           = "${local.network_local_s_prefix}${var.internal_subnet_name}"

  private_service_connection {
    name                           = var.private_service_sa_name
    private_connection_resource_id = azurerm_storage_account.storage_account1.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, azurerm_storage_account.storage_account1]
}