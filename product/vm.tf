#Create public IP for Bastion host
resource "azurerm_public_ip" "bastion_publicIP" {
  name                = "bastion-host-publicip"
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  location            = var.azure_location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
}
#Create Bastion host
resource "azurerm_bastion_host" "host_bastion" {
  name                = var.bastion_host_name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  location            = var.azure_location
  ip_configuration {
    name                 = "IpConf"
    subnet_id            = "${local.network_local_s_prefix}${var.bastion_subnet_name}"
    public_ip_address_id = azurerm_public_ip.bastion_publicIP.id
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet]
}
#Create NIC for comcom_admin VM1
resource "azurerm_network_interface" "comcom_admin_vm01_nic" {
  name                = "comcom_admin_vm01_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_admin_vm01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.comcomadmin_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcomadmin_subnet_address_space, 5)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet]
}
#Create VM1 for comcom_admin
resource "azurerm_virtual_machine" "comcom_admin_vm1" {
  name                             = var.comcom_admin_vm01_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = ["${azurerm_network_interface.comcom_admin_vm01_nic.id}"]
  vm_size                          = "Standard_D11_v2"
  zones                            = ["1"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.comcom_admin_vm01_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_admin_vm01_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_admin_vm01_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application = "Community Commerce Bank Integration Layer"
    ESF_Application_ID = "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Offline Stored Value Account Service"
    ESF_Service_ID = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet, azurerm_network_interface.comcom_admin_vm01_nic]
}
#Create NIC for comcom_admin VM2
resource "azurerm_network_interface" "comcom_admin_vm02_nic" {
  name                = "comcom_admin_vm02_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_admin_vm02_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.comcomadmin_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcomadmin_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet]
}
#Create VM2 for comcom_admin
resource "azurerm_virtual_machine" "comcom_admin_vm2" {
  name                             = var.comcom_admin_vm02_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = ["${azurerm_network_interface.comcom_admin_vm02_nic.id}"]
  vm_size                          = "Standard_D11_v2"
  zones                            = ["2"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.comcom_admin_vm02_name}-osdisk1_1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_admin_vm02_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_admin_vm02_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application = "Community Commerce Bank Integration Layer"
    ESF_Application_ID = "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Offline Stored Value Account Service"
    ESF_Service_ID = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet, azurerm_network_interface.comcom_admin_vm02_nic]
}
#Create NIC for mcaid_admin VM1
resource "azurerm_network_interface" "mcaid_admin_vm01_nic" {
  name                = "mcaid_admin_vm01_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_admin_vm01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.mcaidadmin_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaidadmin_subnet_address_space, 5)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet]
}
#Create VM1 for mcaid_admin
resource "azurerm_virtual_machine" "mcaid_admin_vm1" {
  name                             = var.mcaid_admin_vm01_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = ["${azurerm_network_interface.mcaid_admin_vm01_nic.id}"]
  vm_size                          = "Standard_D11_v2"
  zones                            = ["1"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.mcaid_admin_vm01_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_admin_vm01_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_admin_vm01_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Mastercard Aid"
    ESF_Service_ID = "94cfda38-0957-31a9-ae82-29e027bdc8b4"
    ESF_Application = "MC Aid Nextgen"
    ESF_Application_ID = "a34a8685-6dbf-3931-acb8-2b5f4d209a58"
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet, azurerm_network_interface.mcaid_admin_vm01_nic]
}

#Create NIC for mcaid_admin VM2
resource "azurerm_network_interface" "mcaid_admin_vm02_nic" {
  name                = "mcaid_admin_vm02_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_admin_vm02_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.mcaidadmin_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaidadmin_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet]
}
#Create VM2 for mcaid_admin
resource "azurerm_virtual_machine" "mcaid_admin_vm2" {
  name                             = var.mcaid_admin_vm02_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = ["${azurerm_network_interface.mcaid_admin_vm02_nic.id}"]
  vm_size                          = "Standard_D11_v2"
  zones                            = ["2"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.mcaid_admin_vm02_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_admin_vm02_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_admin_vm02_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Mastercard Aid"
    ESF_Service_ID = "94cfda38-0957-31a9-ae82-29e027bdc8b4"
    ESF_Application = "MC Aid Nextgen"
    ESF_Application_ID = "a34a8685-6dbf-3931-acb8-2b5f4d209a58"
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet, azurerm_network_interface.mcaid_admin_vm02_nic]
}
#Create NIC for comcom_ms VM1
resource "azurerm_network_interface" "comcom_ms_vm01_nic" {
  name                = "comcom_ms_vm01_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_ms_vm01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.comcomms_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcomms_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet]
}
#Create VM1 for comcom_ms
resource "azurerm_virtual_machine" "comcom_admin_ms_vm1" {
  name                             = var.comcom_ms_vm01_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = ["${azurerm_network_interface.comcom_ms_vm01_nic.id}"]
  vm_size                          = "Standard_D12_v2"
  zones                            = ["1"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.comcom_ms_vm01_name}-osdisk1.1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_ms_vm01_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_ms_vm01_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application = "Community Commerce Bank Integration Layer"
    ESF_Application_ID = "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Offline Stored Value Account Service"
    ESF_Service_ID = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet, azurerm_network_interface.comcom_ms_vm01_nic]
}
#Create NIC for comcom_ms VM2
resource "azurerm_network_interface" "comcom_ms_vm02_nic" {
  name                = "comcom_ms_vm02_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_comcom.name
  ip_configuration {
    name                          = "comcom_ms_vm02_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.comcomms_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.comcomms_subnet_address_space, 11)
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet]
}
#Create VM1 for comcom_ms
resource "azurerm_virtual_machine" "comcom_ms_vm2" {
  name                             = var.comcom_ms_vm02_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_comcom.name
  network_interface_ids            = ["${azurerm_network_interface.comcom_ms_vm02_nic.id}"]
  vm_size                          = "Standard_D12_v2"
  zones                            = ["2"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.comcom_ms_vm02_name}-osdisk1.1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.comcom_ms_vm02_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.comcom_ms_vm02_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Application = "Community Commerce Bank Integration Layer"
    ESF_Application_ID = "26da93dd-e0a9-36d9-8ce2-50fdb90aefb4"
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Offline Stored Value Account Service"
    ESF_Service_ID = "1ff860f0-f1e7-37c5-894b-5f1cf0af8abc"
  }
  depends_on = [azurerm_resource_group.resource_group_comcom, module.network_vnet, azurerm_network_interface.comcom_ms_vm02_nic]
}
#Create NIC for mcaid_ms VM1
resource "azurerm_network_interface" "mcaid_ms_vm01_nic" {
  name                = "mcaid_ms_vm01_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_ms_vm01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.mcaidms_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaidms_subnet_address_space, 5)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet]
}
#Create VM1 for mcaid_ms
resource "azurerm_virtual_machine" "mcaid_ms_vm1" {
  name                             = var.mcaid_ms_vm01_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = ["${azurerm_network_interface.mcaid_ms_vm01_nic.id}"]
  vm_size                          = "Standard_D12_v2"
  zones                            = ["1"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.mcaid_ms_vm01_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_ms_vm01_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_ms_vm01_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Mastercard Aid"
    ESF_Service_ID = "94cfda38-0957-31a9-ae82-29e027bdc8b4"
    ESF_Application = "MC Aid Nextgen"
    ESF_Application_ID = "a34a8685-6dbf-3931-acb8-2b5f4d209a58"
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet, azurerm_network_interface.mcaid_ms_vm01_nic]
}

#Create NIC for mcaid_ms VM2
resource "azurerm_network_interface" "mcaid_ms_vm02_nic" {
  name                = "mcaid_ms_vm02_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_mcaid.name
  ip_configuration {
    name                          = "mcaid_ms_vm02_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.mcaidms_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.mcaidms_subnet_address_space, 10)
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet]
}
#Create VM2 for mcaid_ms
resource "azurerm_virtual_machine" "mcaid_ms_vm2" {
  name                             = var.mcaid_ms_vm02_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_mcaid.name
  network_interface_ids            = ["${azurerm_network_interface.mcaid_ms_vm02_nic.id}"]
  vm_size                          = "Standard_D12_v2"
  zones                            = ["2"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vm_image_rg}/providers/Microsoft.Compute/images/CentOS07-Prod-23-03-2021"
  }
  storage_os_disk {
    name              = "${var.mcaid_ms_vm02_name}-osdisk1_1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.mcaid_ms_vm02_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_data_disk {
    name          = "${var.mcaid_ms_vm02_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
    ESF_Service = "Mastercard Aid"
    ESF_Service_ID = "94cfda38-0957-31a9-ae82-29e027bdc8b4"
    ESF_Application = "MC Aid Nextgen"
    ESF_Application_ID = "a34a8685-6dbf-3931-acb8-2b5f4d209a58"
  }
  depends_on = [azurerm_resource_group.resource_group_mcaid, module.network_vnet, azurerm_network_interface.mcaid_ms_vm02_nic]
}
/*#Create NIC for Citrix VM1
resource "azurerm_network_interface" "citrix_VM1_nic" {
  name                = "citrix_vm01_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ip_configuration {
    name                          = "citrix_vm01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.netscalar_management_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.netscalar_management_subnet_address_space, 5)
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet]
  lifecycle {
    ignore_changes = all
  }
}
#accept T&C
/* resource "azurerm_marketplace_agreement" "citrix_tandc" {
  publisher = "Citrix"
  offer     = "netscalervpx-130-byol"
  plan      = "netscalerbyol"
}
#Create VM1 for Citrix
resource "azurerm_virtual_machine" "citrix_vm1" {
  name                             = var.citrix_vm01_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_nc.name
  network_interface_ids            = ["${azurerm_network_interface.citrix_VM1_nic.id}"]
  vm_size                          = "Standard_D12_v2"
  zones                            = ["1"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    publisher = "Citrix"
    offer     = "netscalervpx-130-byol"
    sku       = "netscalerbyol"
    version   = "latest"
  }
  plan {
    name      = "netscalerbyol"
    product   = "netscalervpx-130-byol"
    publisher = "citrix"
  }
  storage_os_disk {
    name              = "${var.citrix_vm01_name}-osdisk1"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.citrix_vm01_name
    admin_username = var.citrix_username
    admin_password = var.citrix_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  storage_data_disk {
    name          = "${var.citrix_vm01_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "100"
    lun           = "1"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, azurerm_network_interface.citrix_VM1_nic]
  lifecycle {
    ignore_changes = all
  }
}

#Create NIC for Citrix VM2
resource "azurerm_network_interface" "citrix_VM2_nic" {
  name                = "citrix_vm02_nic01"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  ip_configuration {
    name                          = "citrix_vm02_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.netscalar_management_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.netscalar_management_subnet_address_space, 4)
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet]
  lifecycle {
    ignore_changes = all
  }
}
#accept T&C
/* resource "azurerm_marketplace_agreement" "citrix_tandc" {
  publisher = "Citrix"
  offer     = "netscalervpx-130-byol"
  plan      = "netscalerbyol"
} 
#Create VM2 for Citrix
resource "azurerm_virtual_machine" "citrix_vm2" {
  name                             = var.citrix_vm02_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_nc.name
  network_interface_ids            = ["${azurerm_network_interface.citrix_VM2_nic.id}"]
  vm_size                          = "Standard_D12_v2"
  zones                            = ["2"]
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    publisher = "Citrix"
    offer     = "netscalervpx-130-byol"
    sku       = "netscalerbyol"
    version   = "latest"
  }
  plan {
    name      = "netscalerbyol"
    product   = "netscalervpx-130-byol"
    publisher = "citrix"
  }
  storage_os_disk {
    name              = "${var.citrix_vm02_name}-osdisk1"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.citrix_vm02_name
    admin_username = var.citrix_username
    admin_password = var.citrix_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  storage_data_disk {
    name          = "${var.citrix_vm02_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "100"
    lun           = "1"
  }
  tags = {
    environment = var.environment_tag
    created_by  = var.created_by_tag
  }
  depends_on = [azurerm_resource_group.resource_group_nc, module.network_vnet, azurerm_network_interface.citrix_VM2_nic]
  lifecycle {
    ignore_changes = all
  }
}*/
##### Create nic for internal Windows01 #####
resource "azurerm_network_interface" "internal_windows01_nic" {
  name                = "internal_windows01_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_internal.name
  enable_ip_forwarding          = true

  ip_configuration {
    name                          = "internal_windows01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.internal_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.internal_subnet_address_space, 16)
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet]
}
#Create VM for internal Windows01
resource "azurerm_virtual_machine" "internal_windows01_vm" {
  name                             = var.internal_windows01_vm_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_internal.name
  network_interface_ids            = ["${azurerm_network_interface.internal_windows01_nic.id}"]
  vm_size                          = "Standard_D11_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.internal_windows01_vm_name}-osdisk1"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.internal_windows01_vm_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  storage_data_disk {
    name          = "${var.internal_windows01_vm_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "100"
    lun           = "1"
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
	  ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet, azurerm_network_interface.internal_windows01_nic]
  }
######## create nic for Sophos VM ########
resource "azurerm_network_interface" "internal_Sophos_nic" {
  name                = "weprdsophos01_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_internal.name
  ip_configuration {
    name                          = "weprdsophos01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.internal_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.internal_subnet_address_space, 18)
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet]
  
}
### Create VM for Sophos ###
resource "azurerm_virtual_machine" "sophos_vm" {
  name                             = var.sophos_vm_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_internal.name
  network_interface_ids            = ["${azurerm_network_interface.internal_Sophos_nic.id}"]
  vm_size                          = "Standard_D11_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  
  storage_os_disk {
    name              = "${var.sophos_vm_name}-osdisk1"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = var.sophos_vm_name
    admin_username = var.linux_username
    admin_password = var.linux_pwd
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
	  ESF_Program = "Strategic Growth"
	  ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet, azurerm_network_interface.internal_Sophos_nic]
}
#Create nic for linux01 internal
resource "azurerm_network_interface" "internal_linux01_nic" {
  name                = "internal_linux01_nic"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.resource_group_internal.name
  ip_configuration {
    name                          = "internal_linux01_nicconfig"
    subnet_id                     = "${local.network_local_s_prefix}${var.internal_subnet_name}"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.internal_subnet_address_space, 15)
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet]
  lifecycle {
    ignore_changes = all
  }
}
#Create VM for linux01 internal
resource "azurerm_virtual_machine" "internal_linux01_vm" {
  name                             = var.internal_linux01_vm_name
  location                         = var.azure_location
  resource_group_name              = azurerm_resource_group.resource_group_internal.name
  network_interface_ids            = ["${azurerm_network_interface.internal_linux01_nic.id}"]
  primary_network_interface_id     = "/subscriptions/0d112973-c892-4f54-802d-badd74ca2026/resourceGroups/weprdinternal/providers/Microsoft.Network/networkInterfaces/internal_linux01_nic"
  vm_size                          = "Standard_D11_v2"
  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false
  zones                            = []
  storage_image_reference {
    id = "/subscriptions/0d112973-c892-4f54-802d-badd74ca2026/resourceGroups/prd-mastercard-terraform/providers/Microsoft.Compute/images/we_vm_imageCentOS07"
  }
  storage_os_disk {
    name              = "${var.internal_linux01_vm_name}-osdisk1"
    os_type           = "Linux"
    managed_disk_type = "StandardSSD_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    #disk_size_gb      = "70"
  }
  os_profile {
    computer_name  = "weprdintlinux01"
    admin_username = "tlinuxadm"
    admin_password = var.linux_pwd
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  /*storage_data_disk {
    name          = "${var.internal_linux01_vm_name}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "100"
    lun           = "1"
  }*/
  boot_diagnostics {
    enabled     = true
    storage_uri = "https://weprdvmbootdiagnostics.blob.core.windows.net/"
  }
  tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
	  ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
  depends_on = [azurerm_resource_group.resource_group_internal, module.network_vnet, azurerm_network_interface.internal_linux01_nic]
 
}