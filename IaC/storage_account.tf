resource "azurerm_storage_account" "sampledbtprojstorageacc" {
  name                     = "sampledbtprojstorageacc"
  resource_group_name      = azurerm_resource_group.dbt_core_rg.name
  location                 = azurerm_resource_group.dbt_core_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a container within the storage account
resource "azurerm_storage_container" "example" {
  name                  = "dbtdocs"
  storage_account_name  = azurerm_storage_account.sampledbtprojstorageacc.name
  container_access_type = "private"
}
