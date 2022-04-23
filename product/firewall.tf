#Create public IP for firewall
resource "azurerm_public_ip" "firewall_publicIP" {
  name                = "firewall-publicip"
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
  
}
#Create public IP for merchant.commercepass.mastercard.com
resource "azurerm_public_ip" "merchant" {
  name                = "merchant.commercepass.mastercard.com-pip"
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}

#Create public IP for cardholder.commercepass.mastercard.com
resource "azurerm_public_ip" "cardholder" {
  name                = "cardholder.commercepass.mastercard.com-pip"
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}

#Create public IP for commercepass.mastercard.com
resource "azurerm_public_ip" "commercepass" {
  name                = "commercepass.mastercard.com-pip"
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}

#Create public IP for admin.aidpass.mastercard.com
resource "azurerm_public_ip" "admin-aidpass" {
 name = "admin.aidpass.mastercard.com-pip"
 resource_group_name = azurerm_resource_group.resource_group_comcom.name
 location = var.azure_location
 allocation_method = "Static"
 sku = "Standard"
 tags = {
  Environment = var.environment_tag
  created_by = var.created_by_tag
 }
 depends_on = [azurerm_resource_group.resource_group_nc]
}
#Create public IP for aidpass.mastercard.com
resource "azurerm_public_ip" "aidpass" {
  name                = "aidpass.mastercard.com-pip"
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}

#Create public IP for eft.communitypass.mastercard.com
resource "azurerm_public_ip" "eft" {
  name                = "eft.communitypass.mastercard.com-pip"
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}


#Create public IP for mwintegration.commercepass.mastercard.com
resource "azurerm_public_ip" "mwintegration" {
  name                = "mwintegration.commercepass.mastercard.com-pip"
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
  }
}

# Create Azure Firewall
resource "azurerm_firewall" "azure_firewall" {
  name                = "core-azure-firewall"
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  location            = var.azure_location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  threat_intel_mode   = "Alert"
  zones               = []
 
  ip_configuration {
    name                 = "core-azure-firewall-config"
    subnet_id            = "${local.network_local_s_prefix}${var.firewall_subnet_name}"
    public_ip_address_id = azurerm_public_ip.firewall_publicIP.id
  }
  ip_configuration {
    name                 = "merchant.commercepass.mastercard.com"
    public_ip_address_id = azurerm_public_ip.merchant.id
  }
  ip_configuration {
    name                 = "cardholder.commercepass.mastercard.com"
    public_ip_address_id = azurerm_public_ip.cardholder.id
  }
  ip_configuration {
    name                 = "commercepass.mastercard.com"
    public_ip_address_id = azurerm_public_ip.commercepass.id
  }
  ip_configuration {
   name = "admin.aidpass.mastercard.com"
   public_ip_address_id = azurerm_public_ip.admin-aidpass.id
  }
  ip_configuration {
    name                 = "aidpass.mastercard.com"
    public_ip_address_id = azurerm_public_ip.aidpass.id
  }
  ip_configuration {
    name                 = "eft.communitypass.mastercard.com"
    public_ip_address_id = azurerm_public_ip.eft.id
  }
  ip_configuration {
    name                 = "mwintegration.commercepass.mastercard.com"
    public_ip_address_id = azurerm_public_ip.mwintegration.id
  }

  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc, azurerm_public_ip.firewall_publicIP, module.network_vnet]

}
# Create a Azure Firewall Network Rule for Web access
resource "azurerm_firewall_network_rule_collection" "fw-net-web" {
  name                = "azure-firewall-web-rule"
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  priority            = 101
  action              = "Allow"
  rule {
    name                  = "HTTPS"
    source_addresses      = ["10.11.2.0/24","10.11.0.96/27","10.11.0.64/27"]
    destination_ports     = ["443"]
    destination_addresses = ["*"]
    protocols             = ["TCP"]
  }
  rule {
    name                  = "DNS"
    source_addresses      = ["10.11.2.0/24","10.11.0.96/27","10.11.0.64/27"]
    destination_ports     = ["53"]
    destination_addresses = ["*"]
    protocols             = ["UDP"]
  }
  rule {
    name                  = "Proxy-to-internet-internal"
    source_addresses      = ["10.11.1.224/27"]
    destination_ports     = ["443","80"]
    destination_addresses = ["*"]
    protocols             = ["TCP"]
  }
  
}


#Create firewall NAT rule collection
resource "azurerm_firewall_nat_rule_collection" "firewall_nat_rule_comcom" {
  name                = "ComCom_Mcaid_NAT_rule"
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  priority            = 100
  action              = "Dnat"
  rule {
    name                  = "merchant.commercepass.mastercard.com"
    source_addresses      = ["*"]
    destination_ports     = ["443"]
    destination_addresses = [azurerm_public_ip.merchant.ip_address]
    translated_port       = 443
    translated_address    = "10.11.0.118"
    protocols             = ["TCP"]
  }
  rule {
    name                  = "eft.communitypass.mastercard.com"
    source_addresses      = ["*"]
    destination_ports     = ["443"]
    destination_addresses = ["20.82.31.122"]
    translated_port       = 443
    translated_address    = "10.11.0.118"
    protocols             = ["TCP"]
  }
  rule {
    name                  = "cardholder.commercepass.mastercard.com"
    source_addresses      = ["*"]
    destination_ports     = ["443"]
    destination_addresses = [azurerm_public_ip.cardholder.ip_address]
    translated_port       = 443
    translated_address    = "10.11.0.111"
    protocols             = ["TCP"]
  }
  rule {
    name                  = "commercepass.mastercard.com"
    source_addresses      = ["*"]
    destination_ports     = ["443"]
    destination_addresses = [azurerm_public_ip.commercepass.ip_address]
    translated_port       = 443
    translated_address    = "10.11.0.112"
    protocols             = ["TCP"]
  }
  rule {
    name                  = "admin.aidpass.mastercard.com"
    source_addresses      = ["*"]
    destination_ports     = ["443"]
    destination_addresses = [azurerm_public_ip.admin-aidpass.ip_address]
    translated_port       = 443
    translated_address    = "10.11.0.113"
    protocols             = ["TCP"]
  }
  rule {
    name                  = "aidpass.mastercard.com"
    source_addresses      = ["*"]
    destination_ports     = ["443"]
    destination_addresses = [azurerm_public_ip.aidpass.ip_address]
    translated_port       = 443
    translated_address    = "10.11.0.114"
    protocols             = ["TCP"]
  }
  rule {
    name                  = "mwintegration.commercepass.mastercard.com"
    source_addresses      = ["*"]
    destination_ports     = ["443"]
    destination_addresses = [azurerm_public_ip.mwintegration.ip_address]
    translated_port       = 443
    translated_address    = "10.11.0.118"
    protocols             = ["TCP"]
  }
}

#Create firewall Application rule collection
resource "azurerm_firewall_application_rule_collection" "CitrixADM_rule" {
  name                = "CitrixADM_rule"
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "Citrix ADM"
    source_addresses = [ "10.11.0.64/27" ]
    target_fqdns = [ "*.adm.cloud.com" ]
    protocol {
      port = "443"
      type = "Https"
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "Prod_aks_rule" {
  name                = "Prod_aks_rule"
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  priority            = 110
  action              = "Allow"

  rule {
    name = "Prod_AKS_to_Images"
    source_addresses = [ "10.11.2.0/24" ]
    target_fqdns = [ "quay.io", "azurecr.io" ]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  
  rule {
    name = "Windows.net"
    source_addresses = [ "10.11.2.0/24" ]
    target_fqdns = [ "*.windows.net" ]
    protocol {
      port = "443"
      type = "Https"
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "prod-comcom-out-rule" {
  name                = "prod-comcom-out-rules"
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  priority            = 120
  action              = "Allow"

  rule {
    name = "Nearex-SMS"
    source_addresses = [ "10.11.0.96/27" ]
    target_fqdns = [ "api.twilio.com" ]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  
  rule {
    name = "Nearex-Email"
    source_addresses = [ "10.11.0.96/27" ]
    target_fqdns = [ "api.sendgrid.com" ]
    protocol {
      port = "443"
      type = "Https"
    }
  }
}