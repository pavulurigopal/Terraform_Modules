
locals {
  resource_group_name = var.resource_group_name
  
  location            = var.lbrg_location
  pip_name            = var.lb_pip_name != "" ? var.lb_pip_name : format("%s-publicIP", var.prefix)
   
  load_balancer_rules_map = {
    for rule in var.load_balancer_rules :
    join("-", [ rule.frontend_port, rule.backend_port,rule.protocol]) => {
      name          = join("-", [ rule.frontend_port,  rule.backend_port, rule.protocol])
      protocol      = rule.protocol
      frontend_port = rule.frontend_port
      backend_port  = rule.backend_port
      
    }
  }
}
#######################3 Load Balance #############################

resource "azurerm_public_ip" "lbip" {
  count               = var.type == "public" ? 1 : 0  
  name                = local.pip_name
  resource_group_name = local.resource_group_name
  location            = local.location
  //allocation_method   = var.allocation_method 
  allocation_method   = "Static" 
  sku                 = "Standard"
  zones               =  var.zone
  timeouts {
    create = "10m"
    delete = "30m"
  }
}
resource "azurerm_lb" "azlb" {
  name                = var.lb_name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.lb_sku
  tags                = var.tags
  

  frontend_ip_configuration {
    name                          = var.type == "public" ? var.frontend_name_public : var.frontend_name_private
    public_ip_address_id          = var.type == "public" ? join("", azurerm_public_ip.lbip.*.id) : ""
    subnet_id                     = var.type == "public" ? "" :  var.subnet_id        
    private_ip_address            = var.frontend_private_ip_address
    private_ip_address_allocation = var.frontend_private_ip_address_allocation
    
  }
  timeouts {
    create = "10m"
    delete = "30m"
  }
}
resource "azurerm_lb_backend_address_pool" "bkndlb" {
  resource_group_name = local.resource_group_name
  loadbalancer_id     = azurerm_lb.azlb.id
  name                = var.bknd_pool_name
  timeouts {
    create = "10m"
    delete = "30m"
  }
}
resource "azurerm_lb_probe" "lb_probe" {
  for_each            = local.load_balancer_rules_map
  resource_group_name = local.resource_group_name
  name                = each.value.backend_port
  port                =  each.value.backend_port
  protocol            = each.value.protocol
  #request_path        = each.value["probe_protocol"] == "Tcp" ? "" : each.value["request_path"]
  depends_on          = [azurerm_lb.azlb]
  loadbalancer_id     = azurerm_lb.azlb.id
  timeouts {
    create = "10m"
    delete = "30m"
  }
}
resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = local.load_balancer_rules_map
  resource_group_name            = local.resource_group_name
  name                           = each.value.name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = var.type == "public" ? var.frontend_name_public : var.frontend_name_private
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bkndlb.id
  probe_id                       = azurerm_lb_probe.lb_probe[each.value.name].id
  load_distribution              = "Default"
  idle_timeout_in_minutes        = 4
  depends_on                     = [azurerm_lb.azlb]
  loadbalancer_id                = azurerm_lb.azlb.id
  disable_outbound_snat          = var.disable_outbound_snat 
  enable_tcp_reset               = var.enable_tcp_reset
  enable_floating_ip             = var.enable_floating_ip
  timeouts {
    create = "10m"
    delete = "30m"
  }
}

/*resource "azurerm_lb_nat_rule" "azlb" {
  count                          = length(var.remote_port)
  name                           = "VM-${count.index}"
  resource_group_name            = var.azurerm_resource_group
  loadbalancer_id                = azurerm_lb.azlb.id
  protocol                       = "tcp"
  frontend_port                  = "5000${count.index + 1}"
  backend_port                   = element(var.remote_port[element(keys(var.remote_port), count.index)], 1)
  frontend_ip_configuration_name = var.frontend_name
}*/
/*resource "azurerm_lb_outbound_rule" "outbound" {
  count = var.enable_nat ? 1 : 0

  name                = "default"
  resource_group_name = var.resource_group_name

  backend_address_pool_id  = azurerm_lb_backend_address_pool.default_pool.id
  loadbalancer_id          = azurerm_lb.lb.id
  protocol                 = var.nat_protocol
  allocated_outbound_ports = var.nat_allocated_outbound_ports

  frontend_ip_configuration {
    name = local.ip_configuration_name
  }
}*/