data "azurerm_resource_group" "existing_stg_network_rg" {
  name = "we-stg-shared-rg"
}

data "azurerm_virtual_network" "existing_stg_vnet" {
  name                = "wenpcomcomvnet"
  resource_group_name = "we-stg-shared-rg"
}
#Subnet for comcom xipAdmin
resource "azurerm_subnet" "subnet_comcom_xipadmin" {
  name                 = var.comcom_XipAdmin_subnet_name
  address_prefixes     = [var.comcom_XipAdmin_subnet_address_space]
  resource_group_name  = data.azurerm_resource_group.existing_stg_network_rg.name
  virtual_network_name = data.azurerm_virtual_network.existing_stg_vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}
#Subnet for comcom xipMS
resource "azurerm_subnet" "subnet_comcom_xipms" {
  name                 = var.comcom_XipMS_subnet_name
  address_prefixes     = [var.comcom_XipMS_subnet_address_space]
  resource_group_name  = data.azurerm_resource_group.existing_stg_network_rg.name
  virtual_network_name = data.azurerm_virtual_network.existing_stg_vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}
#Subnet for McAid xipAdmin
resource "azurerm_subnet" "subnet_mcaid_xipadmin" {
  name                 = var.mcaid_XipAdmin_subnet_name
  address_prefixes     = [var.mcaid_XipAdmin_subnet_address_space]
  resource_group_name  = data.azurerm_resource_group.existing_stg_network_rg.name
  virtual_network_name = data.azurerm_virtual_network.existing_stg_vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}
#Subnet for McAid xipMS
resource "azurerm_subnet" "subnet_mcaid_xipms" {
  name                 = var.mcaid_XipMS_subnet_name
  address_prefixes     = [var.mcaid_XipMS_subnet_address_space]
  resource_group_name  = data.azurerm_resource_group.existing_stg_network_rg.name
  virtual_network_name = data.azurerm_virtual_network.existing_stg_vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}
#Subnet for software group (aks cluster)
resource "azurerm_subnet" "subnet_softwaregroup_aks" {
  name                 = var.softwaregroup_aks_subnet_name
  address_prefixes     = [var.softwaregroup_aks_subnet_address_space]
  resource_group_name  = data.azurerm_resource_group.existing_stg_network_rg.name
  virtual_network_name = data.azurerm_virtual_network.existing_stg_vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}
#Subnet for Internal hosts
resource "azurerm_subnet" "subnet_internal" {
  name                 = var.internal_subnet_name
  address_prefixes     = [var.internal_subnet_address_space]
  resource_group_name  = data.azurerm_resource_group.existing_stg_network_rg.name
  virtual_network_name = data.azurerm_virtual_network.existing_stg_vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}
##### NSG associations #####
resource "azurerm_subnet_network_security_group_association" "comcom_XipAdmin" {
  subnet_id                 = azurerm_subnet.subnet_comcom_xipadmin.id
  network_security_group_id = azurerm_network_security_group.comcom_nsg.id
  depends_on                = [ azurerm_network_security_group.comcom_nsg]
}

resource "azurerm_subnet_network_security_group_association" "comcom_MS" {
  subnet_id                 = azurerm_subnet.subnet_comcom_xipms.id
  network_security_group_id = azurerm_network_security_group.comcom_nsg.id
  depends_on                = [ azurerm_network_security_group.comcom_nsg]
}

resource "azurerm_subnet_network_security_group_association" "mcaid_XipAdmin" {
  subnet_id                 = azurerm_subnet.subnet_mcaid_xipadmin.id
  network_security_group_id = azurerm_network_security_group.mcaid_nsg.id
  depends_on                = [ azurerm_network_security_group.mcaid_nsg]
}
resource "azurerm_subnet_network_security_group_association" "mcaid_MS" {
  subnet_id                 = azurerm_subnet.subnet_mcaid_xipms.id
  network_security_group_id = azurerm_network_security_group.mcaid_nsg.id
  depends_on                = [ azurerm_network_security_group.mcaid_nsg]
}

resource "azurerm_subnet_network_security_group_association" "softwaregroup" {
  subnet_id                 = azurerm_subnet.subnet_softwaregroup_aks.id
  network_security_group_id = azurerm_network_security_group.softwaregroup_aks_nsg.id
  depends_on                = [ azurerm_network_security_group.softwaregroup_aks_nsg]
}