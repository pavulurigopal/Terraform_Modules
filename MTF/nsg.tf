#Create nsg for comcom subnets
resource "azurerm_network_security_group" "comcom_nsg" {
  name                = var.comcom_nsg_name
  location            = var.azure_location
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  security_rule {
    name                       = "XipAdmin-in-allow"
    priority                   = 100
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
  }
  security_rule {
    name                       = "XipAdmin-vnet-out-allow"
    priority                   = 100
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "outbound"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
  }
  security_rule {
    name                       = "XipAdmin-azure-out-allow"
    priority                   = 120
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "outbound"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
    source_port_range          = "*"
    destination_port_range     = "443"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#Create nsg for mcaid subnets
resource "azurerm_network_security_group" "mcaid_nsg" {
  name                = var.mcaid_nsg_name
  location            = var.azure_location
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  security_rule {
    name                       = "XipMS-in-allow"
    priority                   = 100
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
  }
  security_rule {
    name                       = "XipMS-vnet-out-allow"
    priority                   = 100
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "outbound"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
  }
  security_rule {
    name                       = "XipMS-control-in-allow"
    priority                   = 120
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "4443"]
  }
  security_rule {
    name                       = "XipMS-azure-out-allow"
    priority                   = 120
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "outbound"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
    source_port_range          = "*"
    destination_port_range     = "443"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}
#Create nsg for software group subnets
resource "azurerm_network_security_group" "softwaregroup_aks_nsg" {
  name                = var.softwaregroup_aks_nsg_name
  location            = var.azure_location
  resource_group_name = data.azurerm_resource_group.existing_stg_network_rg.name
  security_rule {
    name                       = "XipMS-in-allow"
    priority                   = 100
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
  }
  security_rule {
    name                       = "XipMS-vnet-out-allow"
    priority                   = 100
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "outbound"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
  }
  security_rule {
    name                       = "XipMS-control-in-allow"
    priority                   = 120
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "4443"]
  }
  security_rule {
    name                       = "XipMS-azure-out-allow"
    priority                   = 120
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "outbound"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
    source_port_range          = "*"
    destination_port_range     = "443"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}