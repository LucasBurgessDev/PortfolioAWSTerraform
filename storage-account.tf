resource "azurerm_storage_account" "azure_iot_storage_account" {
  name                     = lower(replace(join("", [var.company_code, substr(var.tags["service"], 0, 10), var.tags["environment"], "stor"]), " ", ""))
  location                 = var.location
  resource_group_name      = azurerm_resource_group.azure_iot_resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "azure_iot_storage_container" {
  name                  = lower(replace(join("-", [var.company_code, var.tags["service"], var.tags["environment"], "stor-blob"]), " ", ""))
  storage_account_name  = azurerm_storage_account.azure_iot_storage_account.name
  container_access_type = "private"
}