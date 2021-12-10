variable "resource_group_name" {
  default     = ""
}

variable "location" {
  
  default     = ""
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = ""
}
variable "subnet_name" {
  description = "The name of the subnet to use in VM scale set"
  type = string
}

variable "vpn_gateway_name" {
  description = "The name of the Virtual Network Gateway"
  default     = ""
}
variable "pip_name" {
  type = string
  
}

variable "pip_aa_name" {
  type = string
  
}
variable "public_ip_allocation_method" {
  
  default     = "Dynamic"
}

variable "public_ip_sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic"
  default     = "Basic"
}

variable "gateway_type" {
  default     = "Vpn"
}

variable "vpn_type" {
  description = "The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased. Defaults to RouteBased"
  default     = "RouteBased"
}

variable "vpn_gw_sku" {
  description = "Valid options are Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments"
  default     = "VpnGw1"
}

variable "vpn_gw_generation" {
  description = "The Generation of the Virtual Network gateway. Possible values include Generation1, Generation2 or None"
  default     = "Generation1"
}

variable "enable_active_active" {
  description = "If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance sku. If false, an active-standby gateway will be created. Defaults to false."
  default     = false
}



variable "enable_bgp" {
  description = "If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. Defaults to false"
  default     = false
}

variable "bgp_asn_number" {
  description = "The Autonomous System Number (ASN) to use as part of the BGP"
  default     = "65515"
}

variable "bgp_peering_address" {
  description = "The BGP peer IP address of the virtual network gateway. This address is needed to configure the created gateway as a BGP Peer on the on-premises VPN devices. The IP address must be part of the subnet of the Virtual Network Gateway."
  default     = ""
}

variable "bgp_peer_weight" {
  description = "The weight added to routes which have been learned through BGP peering. Valid values can be between 0 and 100"
  default     = ""
}

variable "vpn_client_configuration" {
  type        = object({ address_space = string, certificate = string, vpn_client_protocols = list(string) })
  description = "Virtual Network Gateway client configuration to accept IPSec point-to-site connections"
  default     = null
}

variable "localgw_name" {
  type = string
  
}
variable "local_gateway_address" {
  type = string
}
variable "local_address_space" {
  type = any
}


variable "local_bgp_settings" {
  type        = list(object({ asn_number = number, peering_address = string, peer_weight = number }))
  description = "Local Network Gateway's BGP speaker settings"
  default     = null
}
variable "shared_key" {
  type = string
}
variable "gateway_connection_type" {
  description = "The type of connection. Valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet)"
  default     = "IPsec"
}

variable "vntgw_name" {
  type = string
  
}

variable "gateway_connection_protocol" {
  description = "The IKE protocol version to use. Possible values are IKEv1 and IKEv2. Defaults to IKEv2"
  default     = "IKEv2"
}


variable "tags" {
     type  = map(string)
    default ={}
}