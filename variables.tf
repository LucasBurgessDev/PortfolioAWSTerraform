variable "company_code" {
  type        = string
  default     = "lb"
  description = "The abbreviated code for the company."
}

variable "regions" {
  type = map(any)
  default = {
    primaryregion   = "northeurope"
    secondaryregion = "westeurope"
  }
}

variable "region_code" {
  type        = map(any)
  description = "Short code used to identify the Azure region."
  default = {
    "northeurope" = "neu"
    "westeurope"  = "weu"
    "uksouth"     = "uks"
    "ukwest"      = "ukw"
  }
}

variable "resource_group_label" {
  type        = string
  default     = "rg"
  description = "The resource group abbreviated description used for generating the name. The default setting assumes this is rg. Only to be used if more than 1 resource group is required for the same class of service."
}

variable "data_factory_label" {
  type        = string
  default     = "datafactory"
  description = "The data factory abbreviated description used for generating the name. The default setting assumes this is datafactory."
}

variable "datafactory_number" {
  type        = string
  default     = "1"
  description = "(Required) Specifies the number to append to the Datafactory. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
}

variable "location" {
  type        = string
  default     = "northeurope"
  description = "The Azure region the resource group will be created in."
}

variable "tags" {
  type = map(any)
  default = {
    service           = "azureiot"
    environment       = "msdn"
    iacversion        = "1.0"
    expireson         = "never"
    description       = "Home Data Ingestion"
    maintenancewindow = "n/a needs to remain available"
    hoursofoperation  = "24/7/365"
    businessowner     = "Luke Burgess"
    costcentre        = ""
    project           = "Home"
    department        = "Home"
    confidentiality   = ""
    compliance        = ""
  }
}
