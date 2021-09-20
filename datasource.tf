data "azurerm_role_definition" "reader" {
  name = "Reader"
}

data "azurerm_role_definition" "owner" {
  name = "Owner"
}

/* data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "stw-monitoring-ss-weu-logaw-1"
  resource_group_name = "st-monitoring-ss-weu-rg"
}
 */

data "azurerm_client_config" "current" {
}

data "azuread_service_principal" "lb-iot" {
  application_id = "cbc00257-722b-402f-84f8-a3712b9139e7"
}