#Create nsg for comcom subnets
resource "azurerm_network_security_group" "comcom_nsg" {
  name                = var.comcom_nsg_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
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
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application = "Community Commerce Bank Integration Layer"
    ESF_Application_ID = "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Offline Stored Value Account Service"
    ESF_Service_ID = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
}
#Create nsg for mcaid subnets
resource "azurerm_network_security_group" "mcaid_nsg" {
  name                = var.mcaid_nsg_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
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
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Mastercard Aid"
    ESF_Service_ID = "94cfda38-0957-31a9-ae82-29e027bdc8b4"
    ESF_Application = "MC Aid Nextgen"
    ESF_Application_ID = "a34a8685-6dbf-3931-acb8-2b5f4d209a58"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
}
#Create nsg for software group subnets
resource "azurerm_network_security_group" "softwaregroup_aks_nsg" {
  name                = var.softwaregroup_aks_nsg_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
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
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application = "Community Commerce Bank Integration Layer"
    ESF_Application_ID = "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Offline Stored Value Account Service"
    ESF_Service_ID = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
}
resource "azurerm_network_security_group" "bastion_nsg" {
  name                = var.bastion_nsg_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  security_rule {
    name                       = "GatewayManager"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Internet-Bastion-PublicIP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "OutboundVirtualNetwork"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "OutboundToAzureCloud"
    priority                   = 1002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
}
#Create nsg for Citrix subnet
resource "azurerm_network_security_group" "citrix_nsg" {
  name                = var.citrix_nsg_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
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
    name                       = "ADC_to_ADM"
    priority                   = 105
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "10.11.0.64/27"
    destination_address_prefix = "10.11.0.68"
    source_port_range          = "*"
    destination_port_ranges     = ["22", "80", "300", "443", "3008", "3010", "3011", "4001", "7279", "27000"]
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
    name                       = "ADM_to_ADC"
    description                = "TCP ports for communication between ADM and ADC"
    priority                   = 110
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "10.11.0.68"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_ranges     = ["22", "80", "300", "443", "3008", "3010", "3011", "4001", "7279", "27000"]
  }
  security_rule {
    name                       = "ADM_to_ADC_UDP"
    description                = "UDP ports communication between ADM and ADC"
    priority                   = 115
    access                     = "allow"
    protocol                   = "Tcp"
    direction                  = "inbound"
    source_address_prefix      = "10.11.0.68"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_ranges     = ["67", "123", "161", "500", "3003", "4500", "7000"]
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
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
}