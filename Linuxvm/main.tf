data "azurerm_subscription" "current" {}
/*data "azurerm_key_vault_secret" "vmpassword" {
  name = var.kvltname
  key_vault_id = var.kvl_id
}*/

locals{
    resource_group_name  = var.resource_group_name
    location             = var.location
    virtual_network_name = var.virtual_network_name
    subnet_name          = var.subnet_name
    subnet_id            = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.subnet_name}"
}
resource "azurerm_public_ip" "pip" {
  count = var.assign_public_ip ? 1 : 0

  name                = "${var.prefix}-publicip"
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  zones               = var.zone
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vmnic" {
  name                = "${var.prefix}-nic"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "${var.prefix}-ip_config1"
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.assign_public_ip ? azurerm_public_ip.pip[0].id : ""

  }
    timeouts {
    create = "10m"
    delete = "30m"
  }
}

resource "azurerm_virtual_machine" "linuxvm1" {
  name                  = var.prefix
  location              = local.location
  resource_group_name   = local.resource_group_name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = var.size   //"Standard_DS1_v2"
  zones                 = var.zone
  delete_os_disk_on_termination = false
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }
  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = var.storage_os_disk.caching     //"ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.storage_os_disk.managed_disk_type   //"Standard_LRS"
  }
  os_profile {
    computer_name  = var.os_profile.computer_name  //"hostname"
    admin_username = var.os_profile.admin_username //"testadmin"
    admin_password = var.os_profile.admin_password //"${data.azurerm_key_vault_secret.vmpassword.value}" 
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  /*storage_data_disk {
    name          = "${var.prefix}-datadisk1"
    create_option = var.create_option //"Empty"
    disk_size_gb  = var.datadisk_size //"128"
    lun           = var.lun //"1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri =  var.storage_account_uri #"https://storageaccount.blob.core.windows.net/"
  }*/
  tags = var.tags

    timeouts {
    create = "10m"
    delete = "30m"
  }
    
}