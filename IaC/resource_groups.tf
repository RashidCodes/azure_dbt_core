# this resource group will be used for the container app job
# don't use it for any other resource
resource "azurerm_resource_group" "new_rg" {
  name     = "new_rg"
  location = "Australia East"
}

resource "azurerm_resource_group" "dbt_core_rg" {
  name     = "dbt_core_rg"
  location = "Australia East"
}
