
 resource "azurerm_resource_group" "main1" {
  name     = "example-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "main2" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main1.location
  resource_group_name = azurerm_resource_group.main1.name
}
resource "azurerm_subnet" "main3" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.main1.name
  virtual_network_name = azurerm_virtual_network.main2.name
  address_prefixes      = ["10.0.1.0/24"]
}


module "Site2Site" {
  source = "././tf-module"

  resource_group_name  = "example-rg"
  virtual_network_name = "example-vnet"
  vpn_gateway_name     = "shared-vpn-gw01"
  location             = "eastus"
  gateway_type         = "Vpn"
  vntgw_name           = "testvntgw"
  pip_name             = "testpip"
  pip_aa_name          = "testaapip"
  subnet_name          = "GatewaySubnet"
  localgw_name         = "onpremise"
  local_gateway_address = "8.8.8.8"
  local_address_space   = ["10.1.0.0/24"]
  shared_key            = "xpCGkHTBQmDvZK9HnLr7DAvH"
  

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
