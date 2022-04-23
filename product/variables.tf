################################# secrets variables declaration ######################################
variable "create_resource" { type = bool }
variable "client_id" { type = string }
variable "client_secret" { type = string }
variable "subscription_id" { type = string }
variable "tenant_id" { type = string }
variable "linux_username" { type = string }
variable "linux_pwd" { type = string }
variable "keyvault_private_endpoint_name" { type = string }
variable "keyvault_private_endpoint2_name" { type = string }
variable "private_dns_zone_name" { type = string }
variable "private_dns_zone_name2" { type = string }
##################################    general variables declaration   #################################
variable "azure_location" { type = string }
variable "storage_account1_name" { type = string }
variable "storage_account2_name" {type = string }
variable "app_keyvault_name" { type = string }
variable "app_keyvault2_name" { type = string }
variable "vm_image_rg" { type = string }
######################################   internal resources variables declaration ###################
variable "internal_resource_group_name" { type = string }
variable "internal_subnet_name" { type = string }
variable "internal_subnet_address_space" { type = string }
variable "internal_windows01_vm_name" { type = string }
variable "internal_linux01_vm_name" { type = string }
variable "sophos_vm_name" { type = string  }

##################################    COMCOM variables declaration   #################################
variable "comcom_resource_group_name" { type = string }
### subnets ###
variable "comcomadmin_subnet_name" { type = string }
variable "comcomadmin_subnet_address_space" { type = string }
variable "comcomms_subnet_name" { type = string }
variable "comcomms_subnet_address_space" { type = string }

### NSG ###
variable "comcom_nsg_name" { type = string }
### DB ###
variable "comcom_db_mysql_server_name" { type = string }
variable "comcom_db_mysql_dbadmin_uid" { type = string }
variable "comcom_db_mysql_dbadmin_password" { type = string }
### VMs ###
variable "comcom_admin_vm01_name" { type = string }
variable "comcom_admin_vm02_name" { type = string }
variable "comcom_ms_vm01_name" { type = string }
variable "comcom_ms_vm02_name" { type = string }
##################################    MCAid variables declaration   #################################
variable "mcaid_resource_group_name" { type = string }
### subnets ###
variable "mcaidadmin_subnet_name" { type = string }
variable "mcaidadmin_subnet_address_space" { type = string }
variable "mcaidms_subnet_name" { type = string }
variable "mcaidms_subnet_address_space" { type = string }

### NSG ###
variable "mcaid_nsg_name" { type = string }
### DB ###
variable "mcaid_db_mysql_server_name" { type = string }
variable "mcaid_db_mysql_dbadmin_uid" { type = string }
variable "mcaid_db_mysql_dbadmin_password" { type = string }
### VM ###
variable "mcaid_admin_vm01_name" { type = string }
variable "mcaid_admin_vm02_name" { type = string }
variable "mcaid_ms_vm01_name" { type = string }
variable "mcaid_ms_vm02_name" { type = string }
##################################    Software Group variables declaration   #################################
variable "softwaregroup_resource_group_name" { type = string }
### subnets ###
variable "softwaregroup_aks_subnet_name" { type = string }
variable "softwaregroup_aks_subnet_address_space" { type = string }
###   NSG ###
variable "softwaregroup_aks_nsg_name" { type = string }
### DB ###
variable "softwaregroup_db_ms_sql_server_name" { type = string }
variable "softwaregroup_db_ms_sql_dbadmin_uid" { type = string }
variable "softwaregroup_db_ms_sql_dbadmin_password" { type = string }
variable "softwaregroup_db_ms_sql_elastic_pool_name" { type = string }
variable "softwaregroup_db_ms_sql_db_name" { type = string }
### AKS ###
variable "softwaregroup_aks_cluster_name" { type = string }
variable "aks_cluster_dns_prefix" { type = string }
variable "sg_container_registry_name" { type = string }
variable "routetable_sg_aks_name" { type = string }
##################################    Network components group variables declaration   #################################
variable "nc_resource_group_name" { type = string }
### VNET ###
variable "network_vnet_name" { type = string }
variable "network_vnet_address_space" { type = string }
### Subnets ###
variable "bastion_subnet_name" { type = string }
variable "bastion_subnet_address_space" { type = string }
variable "firewall_subnet_name" { type = string }
variable "firewall_subnet_address_space" { type = string }
variable "netscalar_management_subnet_name" { type = string }
variable "netscalar_management_subnet_address_space" { type = string }
### NSG ###
variable "bastion_nsg_name" { type = string }
variable "citrix_nsg_name" { type = string }
### Bastion host ###
variable "bastion_host_name" { type = string }
### DNS & Private link ###
variable "private_dns_domain_name" { type = string }
variable "private_endpoint_mysql_comcom_name" { type = string }
variable "private_service_mysql_comcom_name" { type = string }
variable "private_endpoint_mysql_mcaid_name" { type = string }
variable "private_service_mysql_mcaid_name" { type = string }
variable "keyvault_private_service_name" { type = string }
variable "keyvault_private_service2_name" { type = string }
variable "private_endpoint_sa_name" { type = string }
variable "private_service_sa_name" { type = string }
variable "private_endpoint_mssql_sg_name" { type = string }
variable "private_service_mssql_sg_name" { type = string }



### VM ###
variable "citrix_vm01_name" { type = string }
variable "citrix_vm02_name" { type = string }
variable "citrix_username" { type = string }
variable "citrix_pwd" { type = string }
############################## Locals #############################
variable "network_local_s_prefix1" {
  type        = string
  default     = "/subscriptions/"
  description = "network_local_s_prefix1"
}
variable "network_local_s_prefix2" {
  type        = string
  default     = "/resourceGroups/"
  description = "network_local_s_prefix2"
}
variable "network_local_s_prefix3" {
  type        = string
  default     = "/providers/Microsoft.Network/virtualNetworks/"
  description = "network_local_s_prefix3"
}
variable "network_local_s_prefix4" {
  type        = string
  default     = "/subnets/"
  description = "network_local_s_prefix4"
}
variable "network_local_s_prefix" {
  type        = string
  default     = null
  description = "network_local_s_prefix"
}
############################## Tags #############################
variable "environment_tag" { type = string }
variable "created_by_tag" { type = string }
############################## Environment name dependency Tag #############################
#####Firewall IP config, DDOS, firewall nat
variable "env_tag" { type = string}

###############################_RSV Variables_##############################
variable "prod_rsv_name" { type = string}
variable "prod_rsv_policy_name" { type = string } 
variable "prod_rsv_weekly_policy_name" { type = string }
  