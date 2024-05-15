resource "azurerm_container_registry" "acr" {
  name                = "midrangepullup"
  resource_group_name = azurerm_resource_group.dbt_core_rg.name
  location            = azurerm_resource_group.dbt_core_rg.location
  sku                 = "Premium"
  admin_enabled       = true
}
