# run this without docker-compose
data "azuread_client_config" "current" {}

# create an azure ad application
resource "azuread_application" "dbt" {
  display_name = "dbt"
  owners       = [data.azuread_client_config.current.object_id]
  description  =  "An azure ad application that will be used to trigger containerapp jobs"
}

# create a service principal for the application
resource "azuread_service_principal" "dbt_service_principal" {
  client_id                    = azuread_application.dbt.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

# this sp should be allowed contributor access over the new_rg resource group
# TODO: Figure out client_id
# resource "azuread_service_principal" "container_app_service_principal" {
#   client_id                    = azuread_application.dbt.client_id
#   app_role_assignment_required = false
#   owners                       = [data.azuread_client_config.current.object_id]
# }

# get the attributes of the contributor role defintion
# TODO: Use a role on the containerapp job level
data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

<<<<<<< HEAD
data "azurerm_role_definition" "storage_blob_data_contributor"{
  name = "Storage Blob Data Contributor"
}

data "azurerm_storage_account" "dbt_storage_acc" {
  name                = "sampledbtprojstorageacc"
  resource_group_name = "dbt_core_rg"
}

data "azurerm_container_app_environment" "new_environment" {
  name                = "new-environment"
  resource_group_name = "new_rg"
}

# SP is assigned the contributor role on the container app
resource "azurerm_role_assignment" "dbt_containerapp_role_assignment" {
  scope              = var.CONTAINERAPP_JOB_SCOPE
  role_definition_id = "${var.CONTAINERAPP_JOB_SCOPE}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azuread_service_principal.dbt_service_principal.object_id
}

# SP is assigned the storage blob data contributor role on the storage account
resource "azurerm_role_assignment" "dbt_storage_acc_role_assignment" {
  scope              = "${data.azurerm_storage_account.dbt_storage_acc.id}"
  role_definition_id = "${data.azurerm_storage_account.dbt_storage_acc.id}${data.azurerm_role_definition.storage_blob_data_contributor.id}"
  principal_id       = azuread_service_principal.dbt_service_principal.object_id
}

# SP is assigned the contributor role on the containerapp environment
resource "azurerm_role_assignment" "dbt_containerapp_environment_role_assignment" {
  scope              = "${data.azurerm_container_app_environment.new_environment.id}"
  role_definition_id = "${data.azurerm_container_app_environment.new_environment.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azuread_service_principal.dbt_service_principal.object_id
}
=======
# Perhaps
data "azurerm_role_definition" "reader" {
  name = "Reader"
}

# get the attributes of the new_rg resource group
# data "azurerm_resource_group" "new_rg" {
#   name = azurerm_resource_group.new_rg.name
# }

# # get the attributes of the dbt_core_rg resource group
# data "azurerm_resource_group" "dbt_core_rg" {
#   name = azurerm_resource_group.dbt_core_rg.name
# }

resource "azurerm_role_assignment" "dbt_role_assignment" {
  # scope              = data.azurerm_resource_group.dbt_core_rg.id
  scope              = var.CONTAINERAPP_JOB_SCOPE
  role_definition_id = "${var.CONTAINERAPP_JOB_SCOPE}${data.azurerm_role_definition.reader.id}"
  principal_id       = azuread_service_principal.dbt_service_principal.object_id
}

# resource "azurerm_role_assignment" "new_rg_role_assignment" {
#   scope              = data.azurerm_resource_group.new_rg.id
#   role_definition_id = "${data.azurerm_resource_group.new_rg.id}${data.azurerm_role_definition.contributor.id}"
#   principal_id       = azuread_service_principal.dbt_service_principal.object_id
# }
>>>>>>> 6b1c4b182a4c67cee7312ea88670d8b671141bba
