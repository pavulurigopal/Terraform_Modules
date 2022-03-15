resource "azurerm_container_registry" "sg_container_registry" {
  name                = var.sg_container_registry_name
  resource_group_name = azurerm_resource_group.resource_group_softwaregroup.name
  location            = var.azure_location
  sku                 = "Premium"
  admin_enabled       = true
}


/* resource "azurerm_kubernetes_cluster" "softwaregroup_aks_cluster" {
  name                = var.softwaregroup_aks_cluster_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_softwaregroup.name
  dns_prefix          = var.aks_cluster_dns_prefix
  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
    private_cluster_enabled = true
    vnet_subnet_id = azurerm_subnet.subnet_softwaregroup_aks.id
  }
  identity {
    type = "SystemAssigned"
  }
  addon_profile {
    aci_connector_linux {
      enabled = false
    }
    azure_policy {
      enabled = false
    }
    http_application_routing {
      enabled = false
    }
    kube_dashboard {
      enabled = true
    }
    oms_agent {
      enabled = false
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "sg_node_pool" {
  name                  = "sgnodepool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.softwaregroup_aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
  vnet_subnet_id        = azurerm_subnet.subnet_softwaregroup_aks.id
}
*/
data "azurerm_firewall" "common_firewall" {
  name                = "core-azure-firewall"
  resource_group_name = "we-stg-shared-rg"
}
resource "azurerm_route_table" "wesgrt" {
  name                = var.routetable_sg_aks_name
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_softwaregroup.name

  route {
    name                   = "kubenetfw_fw_r"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = data.azurerm_firewall.common_firewall.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
  subnet_id      = azurerm_subnet.subnet_softwaregroup_aks.id
  route_table_id = azurerm_route_table.wesgrt.id
  depends_on = [azurerm_route_table.wesgrt]
}

resource "azurerm_kubernetes_cluster" "softwaregroup_aks_cluster" {
  name                    = var.softwaregroup_aks_cluster_name
  location                = var.azure_location
  kubernetes_version      = "1.18.10"
  resource_group_name     = azurerm_resource_group.resource_group_softwaregroup.name
  dns_prefix              = "sg-private-aks"
  private_cluster_enabled = true

  default_node_pool {
    name           = "default"
    node_count     = "3"
    vm_size        = "Standard_F4s_v2"
    vnet_subnet_id = azurerm_subnet.subnet_softwaregroup_aks.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.0.5.10"
    network_plugin     = "azure"
    outbound_type      = "userDefinedRouting"
    service_cidr       = "10.0.5.0/24"
  }
  timeouts {
    create = "60m"
    delete = "2h"
    update = "60m"
  }
  }