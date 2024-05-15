resource "azurerm_log_analytics_workspace" "dbt_log_analytics_workspace" {
  name                = "dbt-log-analytics-workspace"
  location            = azurerm_resource_group.dbt_core_rg.location
  resource_group_name = azurerm_resource_group.dbt_core_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "container_app_env" {
  name                       = "new-environment"
  location                   = azurerm_resource_group.new_rg.location
  resource_group_name        = azurerm_resource_group.new_rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.dbt_log_analytics_workspace.id
}


