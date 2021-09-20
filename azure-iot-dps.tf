# Create a Device Provisioning Service
resource "azurerm_iothub_dps" "raspberry_pi_temp" {
  name                = "raspberrypitemp"
  resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
  location            = var.location
  #allocation_policy   = "Hashed"

  sku {
    name     = "S1"
    capacity = 1
  }

  linked_hub {
    connection_string = azurerm_iothub_shared_access_policy.azure_iot_iothub_shared_access_policy.primary_connection_string
    location          = var.location
  }
  tags=var.tags
}

resource "azurerm_iothub_dps_shared_access_policy" "raspberry_pi_temp_shared_access_policy" {
  name                = "raspberry-pi-temp-shared-access-policy"
  resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
  iothub_dps_name     = azurerm_iothub_dps.raspberry_pi_temp.name
  enrollment_write    = true
  enrollment_read     = true
  registration_read   = true
  registration_write  = true

    lifecycle {
ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      enrollment_write,
      enrollment_read,
      registration_read,
      registration_write,
    ]
  }
}