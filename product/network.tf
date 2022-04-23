/*#Create DDOS plan for VNets
resource "azurerm_network_ddos_protection_plan" "ddos_plan" {
  name                = "${var.env_tag}ddospplan1"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
}*/
#Create vNet and its subnets.
module "network_vnet" {
  source                   = "./../tf-modules/vnet"
  vnet_resource_group_name = azurerm_resource_group.resource_group_nc.name
  vnet_location            = var.azure_location
  vnet_name                = var.network_vnet_name
  vnet_address_space       = var.network_vnet_address_space
  environment_tag          = var.environment_tag
  #ddos_id                  = azurerm_network_ddos_protection_plan.ddos_plan.id
  subnets = {
    "${var.comcomadmin_subnet_name}" = {
      subnet_cidr = var.comcomadmin_subnet_address_space
    },
    "${var.comcomms_subnet_name}" = {
      subnet_cidr = var.comcomms_subnet_address_space
    },
    "${var.mcaidadmin_subnet_name}" = {
      subnet_cidr = var.mcaidadmin_subnet_address_space
    },
    "${var.mcaidms_subnet_name}" = {
      subnet_cidr = var.mcaidms_subnet_address_space
    },
    "${var.bastion_subnet_name}" = {
      subnet_cidr = var.bastion_subnet_address_space
    },
    "${var.firewall_subnet_name}" = {
      subnet_cidr = var.firewall_subnet_address_space
    }
    /*"${var.netscalar_management_subnet_name}" = {
      subnet_cidr = var.netscalar_management_subnet_address_space
    }*/
    "${var.softwaregroup_aks_subnet_name}" = {
      subnet_cidr = var.softwaregroup_aks_subnet_address_space
    }
    "${var.internal_subnet_name}" = {
      subnet_cidr = var.internal_subnet_address_space
    }
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc]
}
##### NSG associations #####
resource "azurerm_subnet_network_security_group_association" "comcomadmin" {
  subnet_id                 = "${local.network_local_s_prefix}${var.comcomadmin_subnet_name}"
  network_security_group_id = azurerm_network_security_group.comcom_nsg.id
  depends_on                = [module.network_vnet, azurerm_network_security_group.comcom_nsg]
}
resource "azurerm_subnet_network_security_group_association" "comcomms" {
  subnet_id                 = "${local.network_local_s_prefix}${var.comcomms_subnet_name}"
  network_security_group_id = azurerm_network_security_group.comcom_nsg.id
  depends_on                = [module.network_vnet, azurerm_network_security_group.comcom_nsg]
}

resource "azurerm_subnet_network_security_group_association" "mcaidadmin" {
  subnet_id                 = "${local.network_local_s_prefix}${var.mcaidadmin_subnet_name}"
  network_security_group_id = azurerm_network_security_group.mcaid_nsg.id
  depends_on                = [module.network_vnet, azurerm_network_security_group.mcaid_nsg]
}
resource "azurerm_subnet_network_security_group_association" "mcaidms" {
  subnet_id                 = "${local.network_local_s_prefix}${var.mcaidms_subnet_name}"
  network_security_group_id = azurerm_network_security_group.mcaid_nsg.id
  depends_on                = [module.network_vnet, azurerm_network_security_group.mcaid_nsg]
}

resource "azurerm_subnet_network_security_group_association" "softwaregroup" {
  subnet_id                 = "${local.network_local_s_prefix}${var.softwaregroup_aks_subnet_name}"
  network_security_group_id = azurerm_network_security_group.softwaregroup_aks_nsg.id
  depends_on                = [module.network_vnet, azurerm_network_security_group.softwaregroup_aks_nsg]
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = "${local.network_local_s_prefix}${var.bastion_subnet_name}"
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id
  depends_on                = [module.network_vnet, azurerm_network_security_group.bastion_nsg]
}

/*resource "azurerm_subnet_network_security_group_association" "citrix" {
  subnet_id                 = "${local.network_local_s_prefix}${var.netscalar_management_subnet_name}"
  network_security_group_id = azurerm_network_security_group.citrix_nsg.id
  depends_on                = [module.network_vnet, azurerm_network_security_group.citrix_nsg]
  lifecycle {
    ignore_changes = all
  }
}*/