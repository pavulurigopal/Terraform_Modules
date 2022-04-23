resource "azurerm_container_registry" "sg_container_registry" {
  name                = var.sg_container_registry_name
  resource_group_name = azurerm_resource_group.resource_group_softwaregroup.name
  location            = var.azure_location
  sku                 = "Premium"
  admin_enabled       = true
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application 	  = "Community Commerce Bank Integration Layer"
    ESF_Application_ID	= "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program         = "Strategic Growth"
    ESF_Program_ID      = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service         = "Offline Stored Value Account Service"
    ESF_Service_ID      = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
  
}

 

resource "azurerm_route_table" "wesgrt" {
  name                = var.routetable_sg_aks_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_softwaregroup.name

  route {
    name                   = "kubenetfw_fw_r"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
  subnet_id      = "${local.network_local_s_prefix}${var.softwaregroup_aks_subnet_name}"
  route_table_id = azurerm_route_table.wesgrt.id
}

resource "azurerm_kubernetes_cluster" "softwaregroup_aks_cluster" {
  name                    = var.softwaregroup_aks_cluster_name
  location                = var.azure_location
  kubernetes_version      = "1.21.2"
  resource_group_name     = azurerm_resource_group.resource_group_softwaregroup.name
  dns_prefix              = "sg-private-aks"
  private_cluster_enabled = true

  default_node_pool {
    name           = "weprdaksnp"
    availability_zones = [ "1","2","3" ]
    node_count     = "3"
    vm_size        = "Standard_F4s_v2"
    vnet_subnet_id = "${local.network_local_s_prefix}${var.softwaregroup_aks_subnet_name}"
    tags = {
      Environment         = var.environment_tag
      created_by          = var.created_by_tag
      ESF_Application 	  = "Community Commerce Bank Integration Layer"
      ESF_Application_ID	= "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
      ESF_Program         = "Strategic Growth"
      ESF_Program_ID      = "fdf457a2-b271-3274-89f2-3514660dbf78"
      ESF_Service         = "Offline Stored Value Account Service"
      ESF_Service_ID      = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.0.6.10"
    network_plugin     = "azure"
    outbound_type      = "userDefinedRouting"
    service_cidr       = "10.0.6.0/24"
  }

  depends_on = [azurerm_route_table.wesgrt, azurerm_subnet_route_table_association.aks_subnet_association]
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application 	  = "Community Commerce Bank Integration Layer"
    ESF_Application_ID	= "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program         = "Strategic Growth"
    ESF_Program_ID      = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service         = "Offline Stored Value Account Service"
    ESF_Service_ID      = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
}