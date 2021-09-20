terraform {
  required_version = "<= 1.0.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.60.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  subscription_id = "8901ed04-6fb1-4777-a541-382777c05b66"
  #client_id       = "..."
  #client_secret   = "..."
  tenant_id = "e15c1e99-7be3-495c-978e-eca7b8ea9f31"
}