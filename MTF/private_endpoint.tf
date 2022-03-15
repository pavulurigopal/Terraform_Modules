#Create private endpoint for keyvault
resource "azurerm_private_endpoint" "keyvault_plink" {
  name                = var.keyvault_private_endpoint_name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  location            = var.azure_location
  subnet_id           = azurerm_subnet.subnet_internal.id

  private_service_connection {
    name                           = var.keyvault_private_service_name
    is_manual_connection           = false
    private_connection_resource_id = module.app_keyvault.key_vault_id
    subresource_names              = ["vault"]
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [  module.app_keyvault]
}
########################################################################################################################
#create endpoint for comcom mySQL
resource "azurerm_private_endpoint" "mysql_comcom_plink" {
  name                = var.private_endpoint_mysql_comcom_name
  location            = var.azure_location
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  subnet_id           = azurerm_subnet.subnet_comcom_xipadmin.id

  private_service_connection {
    name                           = var.private_service_mysql_comcom_name
    private_connection_resource_id = azurerm_mysql_server.comcom_db_mysql.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [  azurerm_mysql_server.comcom_db_mysql]
}
#######################################################################################################################
#create endpoint for mcaid mySQL
resource "azurerm_private_endpoint" "mysql_mcaid_plink" {
  name                = var.private_endpoint_mysql_mcaid_name
  location            = var.azure_location
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  subnet_id           = azurerm_subnet.subnet_mcaid_xipadmin.id

  private_service_connection {
    name                           = var.private_service_mysql_mcaid_name
    private_connection_resource_id = azurerm_mysql_server.mcaid_db_mysql.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [  azurerm_mysql_server.mcaid_db_mysql]
}
#create endpoint for storage account
resource "azurerm_private_endpoint" "storageaccount_plink" {
  name                = var.private_endpoint_sa_name
  location            = var.azure_location
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  subnet_id           = azurerm_subnet.subnet_internal.id

  private_service_connection {
    name                           = var.private_service_sa_name
    private_connection_resource_id = azurerm_storage_account.storage_account1.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [  azurerm_storage_account.storage_account1]
}