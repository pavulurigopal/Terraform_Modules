variable "zone_name" {
  type = string
  description = "DNS zone to manage"
}

variable "virtual_network_id" {
  type    = string
}
variable "resource_group_name" {
  type = string
}

variable "registration" {
  type = bool
  
}

variable "a_recordsets" {
  type = list(object({
    name   = string
    ttl    = number
    record = list(string)
  }))
  
}

variable "vnet_link" {
  type = string
}

variable "create_zone" {
  default = true
}

variable "tags" {
     type  = map(string)
    default ={}
}