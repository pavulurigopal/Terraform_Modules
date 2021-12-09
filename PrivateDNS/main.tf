data "azurerm_subscription" "current" {}

locals{
    resource_group_name  = var.resource_group_name
    
    virtual_network_id   = var.virtual_network_id
    //zone = var.create_zone == true ? azurerm_private_dns_zone.pzone[0].name : var.zone_name
}
    
resource "azurerm_private_dns_zone" "pzone" {
  name                = var.zone_name
  resource_group_name = local.resource_group_name
  tags  = var.tags
  //count = var.create_zone == true ? 1 : 0
  timeouts {
    create = "10m"
    delete = "30m"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {

  name                  = var.vnet_link
  resource_group_name   = local.resource_group_name
  private_dns_zone_name = var.zone_name
  virtual_network_id    = local.virtual_network_id
  registration_enabled  = var.registration
  timeouts {
    create = "10m"
    delete = "30m"
  }
}

resource "azurerm_private_dns_a_record" "this" {
  for_each = { for record in var.a_recordsets : record.name => record }

  name                = lower(each.value.name)
  zone_name           = var.zone_name
  resource_group_name = local.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.record
  depends_on =  [azurerm_private_dns_zone.pzone ]
  timeouts {
    create = "10m"
    delete = "30m"
  }
 
}