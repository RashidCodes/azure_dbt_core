terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.60.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  # client_id       = var.CLIENT_ID
  # client_secret   = var.CLIENT_SECRET
  # tenant_id       = var.TENANT_ID
  # subscription_id = var.SUBSCRIPTION_ID
}


# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = var.TENANT_ID
}
