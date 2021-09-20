resource "azurerm_key_vault" "key_vault" {
  name                = lower(replace(join("", [var.company_code, substr(var.tags["service"], 0, 10), var.tags["environment"], lookup(var.region_code, var.location), "kv"]), " ", ""))
  location            = lower(var.location)
  resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "Set",
    "List",
    "Delete",
    "Set",
  ]
}

resource "azurerm_key_vault_access_policy" "access_policy_spn" {
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_service_principal.lb-iot.object_id

  secret_permissions = [
    "Get",
    "Set",
    "List",
    "Delete",
    "Set",
  ]
}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = "AZURE-IOT-HUB-DEVICE-CONNECTION-STRING"
  value        = azurerm_iothub_dps_shared_access_policy.raspberry_pi_temp_shared_access_policy.primary_connection_string
  key_vault_id = azurerm_key_vault.key_vault.id
}