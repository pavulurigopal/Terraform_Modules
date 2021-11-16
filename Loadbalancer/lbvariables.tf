variable "lb_pip_name" {
  type = string
  
}
variable "zone"{
  type = list(string)
}
  

variable "frontend_name_public" {
  type = string
  
}
variable "frontend_name_private" {
    type = string
  
}
variable "prefix" {
  type = string
  default = "az-lb"
  
}
variable "lbrg_location" {
  type = string
}
variable "resource_group_name" {
  type = string
  
}
variable "subnet_id" {
  type = string
  
}
variable "type" {
    type = string
    default     = "public"
}
variable "lb_sku" {
    type = string 
}
variable "tags" {
    type = map(string)
    default = {}
}
variable "frontend_private_ip_address" {
  description = "(Optional) Private ip address to assign to frontend. Use it with type = private"
  type        = string
  default     = ""
}

variable "frontend_private_ip_address_allocation" {
  description = "(Optional) Frontend ip allocation type (Static or Dynamic)"
  type        = string
  default     = "Dynamic"
}

variable "bknd_pool_name" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "disable_outbound_snat" {
  type = bool
  default = false
}
variable "enable_tcp_reset"{
  type = bool
  default = false
}
variable "enable_floating_ip"{
  type = bool
  default = false
}

variable "load_balancer_rules" {
  description = "Array of load balancer rules."
  type = list(object({
    protocol      = string
    frontend_port = number
    backend_port  = number
    
    
  }))

  // Simple default added here - couldn't see this default being overridden much.
  // Set to [] if allowing load_balancer_rules_map into the default object.
  default = [{
    protocol      = "Tcp",
    frontend_port = 443,
    backend_port  = 443
    

    }
  ]
}
