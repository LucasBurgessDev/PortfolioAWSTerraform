terraform {
  backend "azurerm" {
    storage_account_name = "stiaclbmsdnstor"
    container_name       = "iac-msdn-stor-blob"
    key                  = "azure-iot.terraform.tfstate"
    use_azuread_auth     = true
  }
} 