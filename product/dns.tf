#####################Create DNS Private zone comcom.com ##########################
resource "azurerm_private_dns_zone" "dns_private_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  tags = {
    Environment = var.environment_tag
    Created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
}
###################Link DNS comcom private zone to VNET#############################
resource "azurerm_private_dns_zone_virtual_network_link" "main_zone_to_vnet_link" {
  name                  = "linktovnet"
  resource_group_name   = azurerm_resource_group.resource_group_nc.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_private_zone.name
  virtual_network_id    = module.network_vnet.vnet_id
  tags = {
    Environment = var.environment_tag
    Created_by  = var.created_by_tag
  }
}
#DNS config private link A record for admin.nearexsg

resource "azurerm_private_dns_a_record" "admin" {
  name                = "admin.nearexsg"
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 3600
  records             = ["10.11.0.118"]
}

#DNS config private link for console.nearexsg

resource "azurerm_private_dns_a_record" "console" {
  name                = "console.nearexsg"
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 3600
  records             = ["10.11.0.118"]
}

#DNS config private link for eft.nearexsg

resource "azurerm_private_dns_a_record" "eft_nearex" {
  name                = "eft.nearexsg"
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 3600
  records             = ["10.11.0.118"]
}

#DNS config private link for service.nearexsg

resource "azurerm_private_dns_a_record" "service" {
  name                = "service.nearexsg"
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 3600
  records             = ["10.11.0.118"]
}

#DNS config private link for solutionapp.nearexsg

resource "azurerm_private_dns_a_record" "solutionapp" {
  name                = "solutionapp.nearexsg"
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 3600
  records             = ["10.11.0.118"]
}

#DNS config private link for api.sgnearex

resource "azurerm_private_dns_a_record" "api_sgnearex" {
  name                = "api.sgnearex"
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 3600
  records             = ["10.11.0.117"]
}


###########################Create DNS Private zone prd.mastercard.com #######################33
resource "azurerm_private_dns_zone" "prd_dns_private_zone" {
  name                = var.private_dns_zone_name2
  resource_group_name = azurerm_resource_group.resource_group_nc.name
    tags = {
    Environment = var.environment_tag
    Created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
}
#Link DNS private zone prd.mastercard.com to VNET
resource "azurerm_private_dns_zone_virtual_network_link" "prd_main_zone_to_vnet_link" {
  name                  = "prd_main_zone_vnet"
  resource_group_name   = azurerm_resource_group.resource_group_nc.name
  private_dns_zone_name = azurerm_private_dns_zone.prd_dns_private_zone.name
  virtual_network_id    = module.network_vnet.vnet_id
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#DNS config private link prd.mastercard.com for "weprdmcaidmysql01"

resource "azurerm_private_dns_a_record" "mysqlserver1" {
  name                = "weprdmcaidmysql01"
  zone_name           = azurerm_private_dns_zone.prd_dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = ["10.11.1.68"]
}

#DNS config private link prd.mastercard.com for "weprdccmysql01"

resource "azurerm_private_dns_a_record" "mysqlserver2" {
  name                = "weprdccmysql01"
  zone_name           = azurerm_private_dns_zone.prd_dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = ["10.11.1.4"]
}
#DNS config private link prd.mastercard.com for "weprdkeyvault01 & weprdkeyvault02"

resource "azurerm_private_dns_a_record" "prdkeyvault01" {
  name                = "weprdkeyvault01"
  zone_name           = azurerm_private_dns_zone.prd_dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = ["10.11.1.229"]
}
resource "azurerm_private_dns_a_record" "prdkeyvault02" {
  name                = "weprdkeyvault02"
  zone_name           = azurerm_private_dns_zone.prd_dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = ["10.11.1.230"]
}
resource "azurerm_private_dns_a_record" "softwaregroup_db_ms_sql_server" {
  name                = "weprdsgsql01"
  zone_name           = azurerm_private_dns_zone.prd_dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = ["10.11.2.98"]
}


############Private Link DNS Zone configuration  for MYSQL servers ###########################

data "azurerm_private_dns_zone" "mysql_servers_plink_DNS_config"{
  name                 = "privatelink.mysql.database.azure.com"
  resource_group_name  = "we-prd-shared-rg"
}

#####################################################################################################
##### Private Link DNS Zone configuration  for mssql servers #####
resource "azurerm_private_dns_zone" "mssql_servers_plink_DNS_config"{
  name                 = "privatelink.database.windows.net"
  resource_group_name  = "we-prd-shared-rg"
   tags = {
   Environment = var.environment_tag
   Created_by  = var.created_by_tag
   ESF_Program = "Strategic Growth"
   ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78" 
  }
}
#Link DNS private zone privatelink.database.windows.net to VNET
resource "azurerm_private_dns_zone_virtual_network_link" "mssql_main_zone_to_vnet_link" {
  name                  = "Linktovnet"
  resource_group_name   = azurerm_resource_group.resource_group_nc.name
  private_dns_zone_name = azurerm_private_dns_zone.mssql_servers_plink_DNS_config.name 
  virtual_network_id    = module.network_vnet.vnet_id
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#DNS config private link privatelink.database.windows.net for weprdsgsql01
resource "azurerm_private_dns_a_record" "mssqlserver1" {
  name                = "weprdsgsql01"
  zone_name           = azurerm_private_dns_zone.mssql_servers_plink_DNS_config.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 10
  records             = ["10.11.2.98"]
}

##########################################################################################################################


 
/*#Create DNS Private zone
resource "azurerm_private_dns_zone" "dns_private_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
}
#Link DNS private zone to VNET
resource "azurerm_private_dns_zone_virtual_network_link" "main_zone_to_vnet_link" {
  name                  = "main_zone_vnet"
  resource_group_name   = azurerm_resource_group.resource_group_nc.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_private_zone.name
  virtual_network_id    = module.network_vnet.vnet_id
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#DNS config private link for comcom - mysql server
data "azurerm_private_endpoint_connection" "comcom_mysql_plink_databaseconnection" {
  name                = azurerm_private_endpoint.mysql_comcom_plink.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
}
resource "azurerm_private_dns_a_record" "private_endpoint_a_record_comcom_mysql" {
  name                = azurerm_mysql_server.comcom_db_mysql.name
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.comcom_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address]
}
output "private_link_endpoint_ip_comcom_mysql" {
  value = data.azurerm_private_endpoint_connection.comcom_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address
}
#DNS config private link for mcaid - mysql server
data "azurerm_private_endpoint_connection" "mcaid_mysql_plink_databaseconnection" {
  name                = azurerm_private_endpoint.mysql_mcaid_plink.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
}
resource "azurerm_private_dns_a_record" "private_endpoint_a_record_mcaid_mysql" {
  name                = azurerm_mysql_server.mcaid_db_mysql.name
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.mcaid_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address]
}
output "private_link_endpoint_ip_mcaid_mysql" {
  value = data.azurerm_private_endpoint_connection.mcaid_mysql_plink_databaseconnection.private_service_connection.0.private_ip_address
}
#DNS config private link for keyvault
data "azurerm_private_endpoint_connection" "keyvault_plink_connection" {
  name                = azurerm_private_endpoint.keyvault_plink.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
}
resource "azurerm_private_dns_a_record" "private_endpoint_a_record_keyvault" {
  name                = var.app_keyvault_name
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.keyvault_plink_connection.private_service_connection.0.private_ip_address]
}
output "private_link_endpoint_ip_keyvault" {
  value = data.azurerm_private_endpoint_connection.keyvault_plink_connection.private_service_connection.0.private_ip_address
}*/
