
data "azurerm_subscription" "current" {}
locals{
  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet_name          = var.subnet_name
  subnet_id            = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.subnet_name}"

} 

#---------------------------------------------
# Public IP for Virtual Network Gateway
#---------------------------------------------
resource "azurerm_public_ip" "pip_gw" {
  name                = var.pip_name
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}

resource "azurerm_public_ip" "pip_aa" {
  count               = var.enable_active_active ? 1 : 0
  name                = var.pip_aa_name
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}

#-------------------------------
# Virtual Network Gateway 
#-------------------------------
resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = var.vpn_gateway_name
  resource_group_name = local.resource_group_name
  location            = local.location
  type                = var.gateway_type
  vpn_type            = var.vpn_type
  sku                 = var.vpn_gw_sku
  active_active       = var.vpn_gw_sku != "Basic" ? var.enable_active_active : false
  enable_bgp          = var.vpn_gw_sku != "Basic" ? var.enable_bgp : false
  generation          = var.vpn_gw_generation
  dynamic "bgp_settings" {
    for_each = var.enable_bgp ? [true] : []
    content {
      asn             = var.bgp_asn_number
      peering_address = var.bgp_peering_address
      peer_weight     = var.bgp_peer_weight
    }
  }

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip_gw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = local.subnet_id
  }

  dynamic "ip_configuration" {
    for_each = var.enable_active_active ? [true] : []
    content {
      name                          = "vnetGatewayAAConfig"
      public_ip_address_id          = azurerm_public_ip.pip_gw.id
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = local.subnet_id
    }
  }
}

#---------------------------
# Local Network Gateway
#---------------------------
resource "azurerm_local_network_gateway" "localgw" {
  //count               = length(var.local_networks)
  name                = var.localgw_name
  resource_group_name = local.resource_group_name
  location            = local.location
  gateway_address     = var.local_gateway_address
  address_space       = var.local_address_space

  dynamic "bgp_settings" {
    for_each = var.local_bgp_settings != null ? [true] : []
    content {
      asn                 = var.local_asn_number
      bgp_peering_address = var.local_bgp_peering_address
      peer_weight         = var.local_bgp_peer_weight
    }
  }
  tags = var.tags
}

#---------------------------------------
# Virtual Network Gateway Connection
#---------------------------------------
resource "azurerm_virtual_network_gateway_connection" "az-hub-onprem" {
  name                            = var.vntgw_name
  resource_group_name             = local.resource_group_name
  location                        = local.location
  type                            = var.gateway_connection_type
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id        = azurerm_local_network_gateway.localgw.id
  shared_key                      = var.shared_key
  connection_protocol             = var.gateway_connection_type == "IPSec" && var.vpn_gw_sku == ["VpnGw1", "VpnGw2", "VpnGw3", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ"] ? var.gateway_connection_protocol : null

  /*dynamic "ipsec_policy" {
    for_each = var.local_networks_ipsec_policy != null ? [true] : []
    content {
      dh_group         = var.local_networks_ipsec_policy.dh_group
      ike_encryption   = var.local_networks_ipsec_policy.ike_encryption
      ike_integrity    = var.local_networks_ipsec_policy.ike_integrity
      ipsec_encryption = var.local_networks_ipsec_policy.ipsec_encryption
      ipsec_integrity  = var.local_networks_ipsec_policy.ipsec_integrity
      pfs_group        = var.local_networks_ipsec_policy.pfs_group
      sa_datasize      = var.local_networks_ipsec_policy.sa_datasize
      sa_lifetime      = var.local_networks_ipsec_policy.sa_lifetime
    }
  }*/
  tags = var.tags
}