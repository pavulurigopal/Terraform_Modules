
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


module "pdzone" {
  source = "././tf-module"
  zone_name           = "testzone.com"
  resource_group_name = azurerm_resource_group.main1.name
  tags  = {
    test = "test"
  }
  create_zone = true
  virtual_network_id = azurerm_virtual_network.main2.id
  vnet_link = "testlink"
  registration = false

  a_recordsets = [ {
    name = "service.nearexsg"
    record = [ "10.0.1.2" ]
    ttl = 1
  } ]
  
}