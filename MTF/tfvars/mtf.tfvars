#################################### general variables values  ######################################
azure_location = "westeurope"
environment_tag = "mtf"
created_by_tag = "Terraform"
storage_account1_name = "wenmtfstorage01"
app_keyvault_name = "wemtfkeyvault01"
vm_image_rg = "stg_image_rg"
###### Private endpoint and DNS
keyvault_private_endpoint_name = "mtf-keyvault-private-endpoint"
keyvault_private_service_name = "mtf-keyvault-privatelink-service"
private_dns_zone_name = "mtf.mastercard.com"
private_endpoint_mysql_comcom_name = "mtf-mysql-comcom-private-endpoint"
private_service_mysql_comcom_name = "mtf-mysql-comcom-privatelink-service"
private_endpoint_mysql_mcaid_name = "mtf-mysql-mcaid-private-endpoint"
private_service_mysql_mcaid_name = "mtf-mysql-mcaid-privatelink-service"
private_endpoint_sa_name = "mtf-sa-private-endpoint"
private_service_sa_name = "mtf-sa-privatelink-service"
######################################## Secrets, will be moved to key vault #########################

comcom_db_mysql_dbadmin_uid = "dbadmin"
comcom_db_mysql_dbadmin_password = "Trianz@123"

mcaid_db_mysql_dbadmin_uid = "dbadmin"
mcaid_db_mysql_dbadmin_password = "Trianz@123"

softwaregroup_db_ms_sql_dbadmin_uid = "dbadmin"
softwaregroup_db_ms_sql_dbadmin_password = "Trianz@123"
###################################### internal resources variables values ########################
internal_resource_group_name = "wemtfinternal"
internal_windows01_vm_name = "wemtfintwin01"
internal_linux01_vm_name = "wemtfintlinux01"

internal_subnet_name  = "wemtfinternalsubnet"
internal_subnet_address_space =  "10.10.5.224/27"
#################################### comcom variables values  ######################################
comcom_resource_group_name = "wemtfcomcomrg"
comcom_nsg_name = "mtf_nsg_comcom"
comcom_db_mysql_server_name = "wemtfccmysql01"

comcom_xipAdmin_vm1_name = "wemtfcomcomxipadminvm01"
comcom_xipAdmin_vm2_name = "wemtfcomcomxipadminvm02"

comcom_xipMS_vm1_name = "wemtfcomcomxipmsvm01"
comcom_xipMS_vm2_name = "wemtfcomcomxipmsvm02"
##Subnets
comcom_XipAdmin_subnet_name  = "wemtfcomcomadminsubnet"
comcom_XipAdmin_subnet_address_space  = "10.10.5.0/27"

comcom_XipMS_subnet_name    = "wemtfcomcommssubnet"
comcom_XipMS_subnet_address_space  = "10.10.5.32/27"

#################################### mcaid variables values  ######################################
mcaid_resource_group_name = "wemtfmcaidrg"
mcaid_nsg_name = "mtf_nsg_mcaid"
mcaid_db_mysql_server_name = "wemtfmcaidmysql01"

mcaid_xipAdmin_vm1_name = "wemtfmcaidxipadminvm01"
mcaid_xipAdmin_vm2_name = "wemtfmcaidxipadminvm02"

mcaid_xipMS_vm1_name = "wemtfmcaidxipmsvm01"
mcaid_xipMS_vm2_name = "wemtfmcaidxipmsvm02"

##Subnets
mcaid_XipAdmin_subnet_name = "wemtfmcaidadminsubnet"
mcaid_XipAdmin_subnet_address_space = "10.10.5.64/27"

mcaid_XipMS_subnet_name   =    "wemtfmcaidmssubnet"
mcaid_XipMS_subnet_address_space  =  "10.10.5.96/27"

#################################### software group variables values  ######################################
softwaregroup_resource_group_name = "wemtfsgrg"
softwaregroup_aks_nsg_name = "mtf_nsg_softwaregroup_aks"
softwaregroup_aks_cluster_name = "wemtfsgaks01"
aks_cluster_dns_prefix = "sg-aks"
sg_container_registry_name = "wemtfsgacr01"
softwaregroup_db_ms_sql_server_name = "wemtfsgsql01"
softwaregroup_db_ms_sql_elastic_pool_name = "softwaregroup-mssql-ep"
routetable_sg_aks_name = "wemtfsgrt01"
##Subnets
softwaregroup_aks_subnet_name   =   "wemtfsgakssubnet"
softwaregroup_aks_subnet_address_space = "10.10.6.0/24"
#################################### network components group variables values  ######################################
nc_resource_group_name = "we-mtf-shared-rg"
### VNet ###

### Subnets ###

### NSG ###

### DNS ###
private_dns_domain_name = "mcinternal.com"

