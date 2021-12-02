
 resource "azurerm_resource_group" "main1" {
  name     = "example-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "main2" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main1.location
  resource_group_name = azurerm_resource_group.main1.name
}

resource "azurerm_subnet" "main3" {
  name                 = "example-net"
  resource_group_name  = azurerm_resource_group.main1.name
  virtual_network_name = azurerm_virtual_network.main2.name
  address_prefixes      = ["10.0.2.0/24"]
}
data "azurerm_key_vault" "kvlt"{
  name = "poctfkv"
  resource_group_name = "pocterraform_RG"
}
data "azurerm_key_vault_secret" "vmpassword"{
  name = "tf-linux-pass"
  key_vault_id = data.azurerm_key_vault.kvlt.id 
}

module "vm" {
  source = "././tf-module"
  prefix               = "example"
  assign_public_ip     = false
  public_ip_allocation_method = "Static"
  resource_group_name  = azurerm_resource_group.main1.name
  virtual_network_name = azurerm_virtual_network.main2.name
  subnet_name          = azurerm_subnet.main3.name
  size                 = "Standard_DS1_v2"
  location             = azurerm_resource_group.main1.location
  zone                 = ["1"]
  storage_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"

  }
  storage_os_disk = {
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }
  os_profile = {
    computer_name  = "linuxvm1"  
    admin_username = "testadmin"
    admin_password = "${data.azurerm_key_vault_secret.vmpassword.value}"  //"Password1234!" 
  }
  /*storage_data_disk = {
    name          = "${var.prefix}-datadisk1"
    create_option = "Empty"
    disk_size_gb  = "128"
    lun           = "1"
  }
  boot_diagnostics = {
    enabled     = true
    storage_uri = "https://storageaccount.blob.core.windows.net/"
  }*/

}