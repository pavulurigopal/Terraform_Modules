
data "azurerm_resource_group" "default_workspace_rg" {
  name     = "DefaultResourceGroup-WEU" 
}

data "azurerm_log_analytics_workspace" "default_workspace" {
  name                = "DefaultWorkspace-0d112973-c892-4f54-802d-badd74ca2026-WEU"
  resource_group_name = data.azurerm_resource_group.default_workspace_rg.name
}

resource "azurerm_security_center_workspace" "Azuresecurity" {
  scope        = "/subscriptions/${var.subscription_id}"
  workspace_id = data.azurerm_log_analytics_workspace.default_workspace.id
}