# Create mysql server for comcom
resource "azurerm_mysql_server" "comcom_db_mysql" {
  name                              = var.comcom_db_mysql_server_name
  location                          = var.azure_location
  resource_group_name               = azurerm_resource_group.resource_group_comcom.name
  administrator_login               = var.comcom_db_mysql_dbadmin_uid
  administrator_login_password      = var.comcom_db_mysql_dbadmin_password
  sku_name                          = "GP_Gen5_4"
  storage_mb                        = 819200
  version                           = "5.7"
  auto_grow_enabled                 = true
  backup_retention_days             = 35 #Retention to be confirmed#
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = false
  #ssl_minimal_tls_version_enforced  = "TLS1_2"
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
  depends_on = [azurerm_resource_group.resource_group_comcom]

}
# Create mysql server for mcaid
resource "azurerm_mysql_server" "mcaid_db_mysql" {
  name                              = var.mcaid_db_mysql_server_name
  location                          = var.azure_location
  resource_group_name               = azurerm_resource_group.resource_group_mcaid.name
  administrator_login               = var.mcaid_db_mysql_dbadmin_uid
  administrator_login_password      = var.mcaid_db_mysql_dbadmin_password
  sku_name                          = "GP_Gen5_4"
  storage_mb                        = 819200
  version                           = "5.7"
  auto_grow_enabled                 = true
  backup_retention_days             = 35 #Retention to be confirmed#
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = false
  #ssl_minimal_tls_version_enforced  = "TLS1_2"
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
  depends_on = [azurerm_resource_group.resource_group_mcaid]
 
}
# Create MS sql server for software group
resource "azurerm_sql_server" "softwaregroup_db_ms_sql_server" {
  name                         = var.softwaregroup_db_ms_sql_server_name
  resource_group_name          = azurerm_resource_group.resource_group_softwaregroup.name
  location                     = var.azure_location
  version                      = "12.0"
  administrator_login          = var.softwaregroup_db_ms_sql_dbadmin_uid
  administrator_login_password = var.softwaregroup_db_ms_sql_dbadmin_password
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
  depends_on = [azurerm_resource_group.resource_group_softwaregroup]
}
/*# Create elastic pool for MS SQL server-software group
resource "azurerm_mssql_elasticpool" "softwaregroup_db_ms_sql_elastic_pool" {
  name                = var.softwaregroup_db_ms_sql_elastic_pool_name
  resource_group_name = azurerm_resource_group.resource_group_softwaregroup.name
  location            = var.azure_location
  server_name         = azurerm_sql_server.softwaregroup_db_ms_sql_server.name
  license_type        = "LicenseIncluded"
  max_size_gb         = 500

  sku {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    family   = "Gen5"
    capacity = 4
  }

  per_database_settings {
    min_capacity = 0.25
    max_capacity = 2
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
  depends_on = [azurerm_resource_group.resource_group_softwaregroup, azurerm_sql_server.softwaregroup_db_ms_sql_server]
}

# Create SQL Database in SQL Server elastic pool
resource "azurerm_sql_database" "softwaregroup_db_ms_sql_db" {
  name                = var.softwaregroup_db_ms_sql_db_name
  resource_group_name = azurerm_resource_group.resource_group_softwaregroup.name
  location            = var.azure_location
  server_name         = azurerm_sql_server.softwaregroup_db_ms_sql_server.name
  elastic_pool_name   = azurerm_mssql_elasticpool.softwaregroup_db_ms_sql_elastic_pool.name

tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
}
depends_on = [azurerm_resource_group.resource_group_softwaregroup, azurerm_sql_server.softwaregroup_db_ms_sql_server, azurerm_mssql_elasticpool.softwaregroup_db_ms_sql_elastic_pool]
}*/