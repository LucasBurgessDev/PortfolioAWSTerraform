# resource "azurerm_eventhub_namespace" "azure_iot_namespace" {
#   name                = "azure-iot-namespace"
#   resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
#   location            = var.location
#   sku                 = "Basic"
# }

# resource "azurerm_eventhub" "azure_iot_eventhub" {
#   name                = "azure-iot-eventhub"
#   resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
#   namespace_name      = azurerm_eventhub_namespace.azure_iot_namespace.name
#   partition_count     = 1
#   message_retention   = 1
# }

# resource "azurerm_eventhub_authorization_rule" "azure_iot_eventhub_authorization_rule" {
#   resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
#   namespace_name      = azurerm_eventhub_namespace.azure_iot_namespace.name
#   eventhub_name       = azurerm_eventhub.azure_iot_eventhub.name
#   name                = "acctest"
#   send                = true
# }

resource "azurerm_iothub" "azure_iot_iothub" {
  name                = "azure-iot-IoTHub"
  resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
  location            = var.location

  sku {
    name     = "F1"
    capacity = "1"
  }

  endpoint {
    type                       = "AzureIotHub.StorageContainer"
    connection_string          = azurerm_storage_account.azure_iot_storage_account.primary_blob_connection_string
    name                       = "export"
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    container_name             = azurerm_storage_container.azure_iot_storage_container.name
    encoding                   = "Avro"
    file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  }

  /*   endpoint {
    type              = "AzureIotHub.EventHub"
    connection_string = azurerm_eventhub_authorization_rule.azure_iot_eventhub_authorization_rule.primary_connection_string
    name              = "export2"
  } */

  route {
    name           = "export"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export"]
    enabled        = true
  }

  /*   route {
    name           = "export2"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export2"]
    enabled        = true
  } */

  enrichment {
    key            = "tenant"
    value          = "$twin.tags.Tenant"
    endpoint_names = ["export" /* , "export2" */]
  }

  tags = var.tags
}

resource "azurerm_iothub_shared_access_policy" "azure_iot_iothub_shared_access_policy" {
  name                = "azure-iot-iothub-shared-access-policy"
  resource_group_name = azurerm_resource_group.azure_iot_resource_group.name
  iothub_name         = azurerm_iothub.azure_iot_iothub.name

  registry_read  = true
  registry_write = true

    provisioner "local-exec" {
    command = "./setupdevice.bash"
    command = "az config set extension.use_dynamic_install=yes_without_prompt"
    command = "az iot hub device-identity create --device-id raspberrypitemp --hub-name azure-iot-IoTHub"
    # environment = {
    #     hubname = azurerm_resource_group.azure_iot_resource_group.name
    # }
}
}

