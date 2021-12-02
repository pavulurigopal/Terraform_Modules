variable "resource_group_name" {type = string}
variable "location" {type = string}
variable "virtual_network_name" {type = string}
variable "subnet_name" {type = string}
variable "prefix" {type = string}
variable "size" { type = string }

variable "storage_image_reference" {
  description = "storage_image_reference to specify VM image"
  type        = object ({
    publisher = string //"Canonical"
    offer     = string //"UbuntuServer"
    sku       = string //"18.04-LTS"
    version   = string //"latest"
  })
  
}
variable "storage_os_disk" {
  description = "storage_os_disk to specify VM image"
  type        = object ({
    caching   = string         //"ReadWrite"
    managed_disk_type = string //"Standard_LRS"

  })
}

variable "os_profile" {
    type  = object ({
    computer_name  = string  //"linuxvm1"  
    admin_username = string //"testadmin"
    admin_password = any //"Password1234!" 
    })    
}

/*variable "storage_data_disk" {
    type = object ({
    name          = string //"${var.prefix}-datadisk1"
    create_option = string //"Empty"
    disk_size_gb  = string //"128"
    lun           = string //"1"
    })
    
  }
  variable "boot_diagnostics" {
      type = object ({
      enabled     = bool
      storage_uri =  string  #"https://storageaccount.blob.core.windows.net/"
      })
    
  }*/

variable "tags" {
     type  = map(string)
    default ={}
}

variable "zone"{
  type = list(string)
}
variable "public_ip_allocation_method" { type = string }
variable "assign_public_ip" { 
  type = bool 
  default     = false
  }