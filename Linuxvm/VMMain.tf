/*# =============================================
# data/locals
# =============================================

data "azurerm_subscription" "current" {}

locals {
  create_ssh_key = var.ssh_key == ""
  ssh_key        = var.ssh_key != "" ? var.ssh_key : tls_private_key.ssh.public_key_openssh
  subnet_id      = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.vnet_name}/subnets/${var.subnet_name}"
  admin_username = "${var.name}user"
}




# =============================================
# secrets
# =============================================

resource "tls_private_key" "ssh" {
  count = local.create_ssh_key ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 2048
}

# =============================================
# vm
# =============================================

resource "azurerm_public_ip" "this" {
  count = var.assign_public_ip ? 1 : 0

  name                = "${var.name}-publicip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method

  tags = var.tags
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-ipconfig"
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = var.assign_public_ip ? azurerm_public_ip.this[0].id : ""
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "this" {
  name                  = "${var.name}-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.this.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name          = "${var.name}-disc"
    create_option = "FromImage"
  }

  storage_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }

  os_profile {
    computer_name  = "${var.name}host"
    admin_username = local.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = replace(local.ssh_key, "\n", "")
      path     = "/home/${local.admin_username}/.ssh/authorized_keys"
    }
  }

  tags = var.tags
}*/