module "AzureRmLoadBalancer" {
  source = "././tf-module"
  lb_name                    = "mytestlb1"
  resource_group_name        = azurerm_resource_group.testrg.name
  lb_sku                     = "Standard"
  tags                       = azurerm_resource_group.testrg.tags
  subnet_id                  = azurerm_subnet.testsubnet.id
  frontend_name_private      = "internallb"
  frontend_name_public       = "publiclb"
  zone                       = ["1"]
  bknd_pool_name             = "azlbbkndpool"
  lb_pip_name                = "testpip"
  lbrg_location              = azurerm_resource_group.testrg.location
  type                       = "public"
  
  load_balancer_rules = [{
      protocol      = "Tcp",
      frontend_port = 80,
      backend_port  = 8080 
      },
    {
      protocol      = "Tcp",
      frontend_port = 443,
      backend_port  = 8443
      
    }
  ]
}





############################# variables####################################
#############################################################################
 resource "azurerm_resource_group" "testrg"{
  name =  "importrg"
  location = "West Europe"
}
resource "azurerm_virtual_network" "testvnet" {
  name                = "lb-vnet"
  resource_group_name = azurerm_resource_group.testrg.name
  location            = azurerm_resource_group.testrg.location
  address_space       = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "testsubnet" {
  name                 = "lb-subnet"
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvnet.name
  address_prefixes     = ["10.0.0.0/26"]
}
#################################################
variable "type" {
    type = string
    default     = "public" //private
}
variable "lb_name" {
  type = string
  default = "mytestlb"
}
variable "lb_sku" {
    type = string 
    default = "Standard"
}
variable "tags" {
    type = map(string)
    default = { 
      tag = "mytlb"
    }
}
variable "frontend_private_ip_address" {
  description = "(Optional) Private ip address to assign to frontend. Use it with type = private"
  type        = string
  default     = "10.0.0.2"
}

variable "frontend_private_ip_address_allocation" {
  description = "(Optional) Frontend ip allocation type (Static or Dynamic)"
  type        = string
  default     = "Dynamic" //Static
}


variable "frontend_name_private" {
    type = string
    default = "internallb"
  
}
variable "frontend_name_public" {
    type = string
    default = "publiclb"
  
}

variable "bknd_pool_name" {
  type = string
  default = "azlbbkndpool"
}

/////////////////////////////////////////////////////////

/*
Public loadbalancer example:

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-lb"
  location = "West Europe"
}

module "mylb" {
  source              = "Azure/loadbalancer/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  name                = "lb-terraform-test"
  pip_name            = "pip-terraform-test"

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }

  lb_probe = {
    http = ["Tcp", "80", ""]
  }

  depends_on = [azurerm_resource_group.example]
}
Usage in Terraform 0.12
Public loadbalancer example:

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-lb"
  location = "West Europe"
}

module "mylb" {
  source              = "Azure/loadbalancer/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  prefix              = "terraform-test"

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }

  lb_probe = {
    http = ["Tcp", "80", ""]
  }

}
Private loadbalancer example:

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-lb"
  location = "West Europe"
}

module "mylb" {
  source                                 = "Azure/loadbalancer/azurerm"
  resource_group_name                    = azurerm_resource_group.example.name
  type                                   = "private"
  frontend_subnet_id                     = module.network.vnet_subnets[0]
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = "10.0.1.6"
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard" #`pip_sku` must match `lb_sku` 

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http  = ["80", "Tcp", "80"]
    https = ["443", "Tcp", "443"]
  }

  lb_probe = {
    http  = ["Tcp", "80", ""]
    http2 = ["Http", "1443", "/"]
  }

  tags = {
    cost-center = "12345"
    source      = "terraform"
  }
}*/