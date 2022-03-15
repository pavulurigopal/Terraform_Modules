#Create NIC for comcom XipAdmin VM 1
resource "azurerm_network_interface" "comcom_xipAdmin_vm1_nic" {
  name                = "comcom_xipAdmin_vm1_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_xipAdmin_vm1_nic"
    subnet_id                     = azurerm_subnet.subnet_comcom_xipadmin.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcom_XipAdmin_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom]
}
#Create VM for comcom XipAdmin VM 1
resource "azurerm_virtual_machine" "comcom_xipAdmin_vm1" {
  name                             = var.comcom_xipAdmin_vm1_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = [azurerm_network_interface.comcom_xipAdmin_vm1_nic.id]
  vm_size                          = "Standard_D11_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07 "
  }
  storage_os_disk {
    name              = "${var.comcom_xipAdmin_vm1_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_xipAdmin_vm1_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_xipAdmin_vm1_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, azurerm_network_interface.comcom_xipAdmin_vm1_nic]
}
#####################################################
#Create NIC for comcom XipAdmin VM 2
resource "azurerm_network_interface" "comcom_xipAdmin_vm2_nic" {
  name                = "comcom_xipAdmin_vm2_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_xipAdmin_vm2_nic"
    subnet_id                     = azurerm_subnet.subnet_comcom_xipadmin.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcom_XipAdmin_subnet_address_space, 11)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom]
}
#Create VM for comcom XipAdmin VM 2
resource "azurerm_virtual_machine" "comcom_xipAdmin_vm2" {
  name                             = var.comcom_xipAdmin_vm2_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = [azurerm_network_interface.comcom_xipAdmin_vm2_nic.id]
  vm_size                          = "Standard_D11_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07  "
  }
  storage_os_disk {
    name              = "${var.comcom_xipAdmin_vm2_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_xipAdmin_vm2_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_xipAdmin_vm2_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, azurerm_network_interface.comcom_xipAdmin_vm2_nic]
}
#####################################################
#Create NIC for comcom xipMS VM 1
resource "azurerm_network_interface" "comcom_xipMS_vm1_nic" {
  name                = "comcom_xipMS_vm1_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_xipMS_vm1_nic"
    subnet_id                     = azurerm_subnet.subnet_comcom_xipms.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcom_XipMS_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom]
}
#Create VM for comcom xipMS VM 1
resource "azurerm_virtual_machine" "comcom_xipMS_vm1" {
  name                             = var.comcom_xipMS_vm1_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = [azurerm_network_interface.comcom_xipMS_vm1_nic.id]
  vm_size                          = "Standard_D12_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07 "
  }
  storage_os_disk {
    name              = "${var.comcom_xipMS_vm1_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_xipMS_vm1_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_xipMS_vm1_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, azurerm_network_interface.comcom_xipMS_vm1_nic]
}
#####################################################
#Create NIC for comcom xipMS VM 2
resource "azurerm_network_interface" "comcom_xipMS_vm2_nic" {
  name                = "comcom_xipMS_vm2_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_xipMS_vm2_nic"
    subnet_id                     = azurerm_subnet.subnet_comcom_xipms.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcom_XipMS_subnet_address_space, 11)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom]
}
#Create VM for comcom xipMS VM 2
resource "azurerm_virtual_machine" "comcom_xipMS_vm2" {
  name                             = var.comcom_xipMS_vm2_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = [azurerm_network_interface.comcom_xipMS_vm2_nic.id]
  vm_size                          = "Standard_D12_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07 "
  }
  storage_os_disk {
    name              = "${var.comcom_xipMS_vm2_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_xipMS_vm2_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_xipMS_vm2_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, azurerm_network_interface.comcom_xipMS_vm2_nic]
}
#####################################################
#Create NIC for mcaid XipAdmin VM 1
resource "azurerm_network_interface" "mcaid_xipAdmin_vm1_nic" {
  name                = "mcaid_xipAdmin_vm1_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_xipAdmin_vm1_nic"
    subnet_id                     = azurerm_subnet.subnet_mcaid_xipadmin.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaid_XipAdmin_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid]
}
#Create VM for mcaid XipAdmin VM 1
resource "azurerm_virtual_machine" "mcaid_xipAdmin_vm1" {
  name                             = var.mcaid_xipAdmin_vm1_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = [azurerm_network_interface.mcaid_xipAdmin_vm1_nic.id]
  vm_size                          = "Standard_D11_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07 "
  }
  storage_os_disk {
    name              = "${var.mcaid_xipAdmin_vm1_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_xipAdmin_vm1_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_xipAdmin_vm1_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, azurerm_network_interface.mcaid_xipAdmin_vm1_nic]
}
#Create NIC for mcaid XipAdmin VM 2
resource "azurerm_network_interface" "mcaid_xipAdmin_vm2_nic" {
  name                = "mcaid_xipAdmin_vm2_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_xipAdmin_vm2_nic"
    subnet_id                     = azurerm_subnet.subnet_mcaid_xipadmin.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaid_XipAdmin_subnet_address_space, 11)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid]
}
#Create VM for mcaid XipAdmin VM 2
resource "azurerm_virtual_machine" "mcaid_xipAdmin_vm2" {
  name                             = var.mcaid_xipAdmin_vm2_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = [azurerm_network_interface.mcaid_xipAdmin_vm2_nic.id]
  vm_size                          = "Standard_D11_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07 "
  }
  storage_os_disk {
    name              = "${var.mcaid_xipAdmin_vm2_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_xipAdmin_vm2_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_xipAdmin_vm2_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, azurerm_network_interface.mcaid_xipAdmin_vm2_nic]
}

#Create NIC for mcaid xipMS VM 1
resource "azurerm_network_interface" "mcaid_xipMS_vm1_nic" {
  name                = "mcaid_xipMS_vm1_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_xipMS_vm1_nic"
    subnet_id                     = azurerm_subnet.subnet_mcaid_xipms.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaid_XipMS_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid]
}
#Create VM for mcaid xipMS VM 1
resource "azurerm_virtual_machine" "mcaid_xipMS_vm1" {
  name                             = var.mcaid_xipMS_vm1_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = [azurerm_network_interface.mcaid_xipMS_vm1_nic.id]
  vm_size                          = "Standard_D12_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07 "
  }
  storage_os_disk {
    name              = "${var.mcaid_xipMS_vm1_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_xipMS_vm1_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_xipMS_vm1_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, azurerm_network_interface.mcaid_xipMS_vm1_nic]
}
#Create NIC for mcaid xipMS VM 2
resource "azurerm_network_interface" "mcaid_xipMS_vm2_nic" {
  name                = "mcaid_xipMS_vm2_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_xipMS_vm2_nic"
    subnet_id                     = azurerm_subnet.subnet_mcaid_xipms.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaid_XipMS_subnet_address_space, 11)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid]
}
#Create VM for mcaid xipMS VM 2
resource "azurerm_virtual_machine" "mcaid_xipMS_vm2" {
  name                             = var.mcaid_xipMS_vm2_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = [azurerm_network_interface.mcaid_xipMS_vm2_nic.id]
  vm_size                          = "Standard_D12_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/we_vm_imageCentOS07 "
  }
  storage_os_disk {
    name              = "${var.mcaid_xipMS_vm2_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_xipMS_vm2_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_xipMS_vm2_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://wemtfvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, azurerm_network_interface.mcaid_xipMS_vm2_nic]
}