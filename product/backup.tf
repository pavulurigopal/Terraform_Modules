#####################_Recovery Service Vault_BackUp_##########################################################################
####Create the Recovery Service Vault####

resource "azurerm_recovery_services_vault" "prod_rsv" {
  name                = var.prod_rsv_name
  location            = azurerm_resource_group.resource_group_nc.location
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  sku                 = "Standard"
   tags = {
    Environment = var.environment_tag
    created_by  = var.created_by_tag
    ESF_Program = "Strategic Growth"
    ESF_Program_ID = "fdf457a2-b271-3274-89f2-3514660dbf78"
  }
}

##############_Policy for Prod servers_####################
resource "azurerm_backup_policy_vm" "prod_daily_policy" {
  name                = var.prod_rsv_policy_name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "00:00"
  }

  retention_daily {
    count = 7
  }
instant_restore_retention_days = 2
}
##############_Policy for Prod Internal servers_###############
resource "azurerm_backup_policy_vm" "prod_weekly_policy" {
  name                = var.prod_rsv_weekly_policy_name
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name

  timezone = "UTC"

  backup {
    frequency = "Weekly"
    weekdays = ["Sunday"]
    time      = "00:00"
  }

  retention_weekly {
    count    = 12
    weekdays = ["Sunday"]
  }
instant_restore_retention_days = 5
}

####Onboard COMCOM Admin VM 1 to RSV####

resource "azurerm_backup_protected_vm" "cc_adm_vm1" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.comcom_admin_vm1.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}
####Onboard COMCOM Admin VM 2 to RSV####

resource "azurerm_backup_protected_vm" "cc_adm_vm2" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.comcom_admin_vm2.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}

####Onboard McAID Admin VM 1 to RSV####

resource "azurerm_backup_protected_vm" "mcaid_adm_vm1" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.mcaid_admin_vm1.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}

####Onboard McAID Admin VM 2 to RSV####

resource "azurerm_backup_protected_vm" "mcaid_adm_vm2" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.mcaid_admin_vm2.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}

####Onboard COMCOM MS VM 1 to RSV####

resource "azurerm_backup_protected_vm" "comcom_ms_vm1" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.comcom_admin_ms_vm1.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}

####Onboard COMCOM MS VM 2 to RSV####

resource "azurerm_backup_protected_vm" "comcom_ms_vm2" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.comcom_ms_vm2.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}

####Onboard McAID MS VM 1 to RSV####

resource "azurerm_backup_protected_vm" "mcaid_ms_vm1" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.mcaid_ms_vm1.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}

####Onboard McAID MS VM 2 to RSV####

resource "azurerm_backup_protected_vm" "mcaid_ms_vm2" {
  resource_group_name = azurerm_resource_group.resource_group_nc.name
  recovery_vault_name = azurerm_recovery_services_vault.prod_rsv.name
  source_vm_id        = azurerm_virtual_machine.mcaid_ms_vm2.id
  backup_policy_id    = azurerm_backup_policy_vm.prod_daily_policy.id
}

