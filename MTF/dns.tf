#Create DNS Private zone
resource "azurerm_private_dns_zone" "dns_private_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
}
#Link DNS private zone to VNET
resource "azurerm_private_dns_zone_virtual_network_link" "main_zone_to_vnet_link" {
  name                  = "main_zone_vnet"
  resource_group_name   = data.azurerm_resource_group.existing_stg_network_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_private_zone.name
  virtual_network_id    = data.azurerm_virtual_network.existing_stg_vnet.id
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#DNS config private link for comcom - mysql server
data "azurerm_private_endpoint_connection" "comcom_mysql_plink_databaseconnection" {
  name                = azurerm_private_endpoint.mysql_comcom_plink.name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
}
resource "azurerm_private_dns_a_record" "private_endpoint_a_record_comcom_mysql" {
  name                = azurerm_mysql_server.comcom_db_mysql.name
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.comcom_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address]
}
output "private_link_endpoint_ip_comcom_mysql" {
  value = data.azurerm_private_endpoint_connection.comcom_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address
}
#DNS config private link for mcaid - mysql server
data "azurerm_private_endpoint_connection" "mcaid_mysql_plink_databaseconnection" {
  name                = azurerm_private_endpoint.mysql_mcaid_plink.name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
}
resource "azurerm_private_dns_a_record" "private_endpoint_a_record_mcaid_mysql" {
  name                = azurerm_mysql_server.mcaid_db_mysql.name
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.mcaid_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address]
}
output "private_link_endpoint_ip_mcaid_mysql" {
  value = data.azurerm_private_endpoint_connection.mcaid_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address
}
#DNS config private link for keyvault
data "azurerm_private_endpoint_connection" "keyvault_plink_connection" {
  name                = azurerm_private_endpoint.keyvault_plink.name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
}
resource "azurerm_private_dns_a_record" "private_endpoint_a_record_keyvault" {
  name                = var.app_keyvault_name
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.keyvault_plink_connection.private_service_connection.0.private_ip_address]
}
output "private_link_endpoint_ip_keyvault" {
  value = data.azurerm_private_endpoint_connection.keyvault_plink_connection.private_service_connection.0.private_ip_address
}