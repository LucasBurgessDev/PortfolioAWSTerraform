# -----------------------------------------------------------------------------------------------------------
# Create Resource Group
# -----------------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "azure_iot_resource_group" {
  name     = join("-", [lower(var.company_code), replace((lower(var.tags["service"])), " ", "-"), replace((lower(var.tags["environment"])), " ", "-"), lookup(var.region_code, var.location), lower(var.resource_group_label)])
  location = var.location
  tags     = var.tags
}

/* # Create "Azure RG Servicename Environment STW Cloud Engineers" Azure AD Group
resource "azuread_group" "prod_a7m_stw_cloud_engineers" {
  display_name            = join(" ", ["Azure RG", replace((title(var.tags["service"])), " ", "-"), replace((title(var.tags["environment"])), " ", "-"), upper(lookup(var.region_code, var.location)), "STW Cloud Engineers"])
  description             = "STW Cloud Engineers RBAC Group - Lifecycle Managed By Terraform"
  prevent_duplicate_names = true
}

# Assign The "STW Cloud Engineers" Role To The "Azure RG Servicename Environment STW Cloud Engineers" Azure AD Group At The Resource Group Level
resource "azurerm_role_assignment" "prod_a7m_stw_cloud_engineers_resource_group" {
  scope                = azurerm_resource_group.prod_a7m_resource_group.id    # The scope where the role assignment applies
  role_definition_name = "Contributor"  # The role that is assigned to the scope
  principal_id         = azuread_group.prod_a7m_stw_cloud_engineers.object_id  # The group that is assigned to the role
  lifecycle {
    ignore_changes = [
      role_definition_name,
    ]
  }
}

# Create "Azure RG Servicename Environment Read Only Access" Azure AD Group
resource "azuread_group" "prod_a7m_stw_read_only_access" {
  display_name            = join(" ", ["Azure RG", replace((title(var.tags["service"])), " ", "-"), replace((title(var.tags["environment"])), " ", "-"), upper(lookup(var.region_code, var.location)), "Read Only Access"])
  description             = "Read Only Access RBAC Group - Lifecycle Managed By Terraform"
  prevent_duplicate_names = true
}

# Assign The "Reader" Role To The "Azure RG Servicename Environment Read Only Access" Azure AD Group At The Resource Group Level
resource "azurerm_role_assignment" "prod_a7m_stw_read_only_access_resource_group" {
  scope                = azurerm_resource_group.prod_a7m_resource_group.id   # The scope where the role assignment applies
  role_definition_name = "Reader"   # The role that is assigned to the scope
  principal_id         = azuread_group.prod_a7m_stw_read_only_access.object_id   # The group that is assigned to the role
  lifecycle {
    ignore_changes = [
      role_definition_name,
    ]
  }
}

# Create "Azure A7M Prod ReadOnly" Azure AD Group
resource "azuread_group" "prod_a7m_aad_readonly_group" {
  name        = "Azure A7M Prod ReadOnly"
  description = "A7M, Production Environment, Read-only Platform-level role"
}

# Create "Azure A7M Prod Admin" Azure AD Group
resource "azuread_group" "prod_a7m_aad_admin_group" {
  name        = "Azure A7M Prod Admin"
  description = "A7M, Production Environment, Admin Platform-level role"
}

# Create "Azure A7M Prod SQL Personal" Azure AD Group
resource "azuread_group" "prod_a7m_aad_sql_personal_group" {
  name        = "Azure A7M Prod SQL Personal"
  description = "A7M, Production Environment, User Access role to access Personal/Sensitive data"
}

# Create "Azure A7M Prod SQL Unmarked" Azure AD Group
resource "azuread_group" "prod_a7m_aad_sql_unmarked_group" {
  name        = "Azure A7M Prod SQL Unmarked"
  description = "A7M, Production Environment, User Access role to access non Sensitive data"
}

# Map Resource Group to Azure Ad Group
resource "azurerm_role_assignment" "prod_a7m_aad_readonly_group_resource_group" {
  scope              = azurerm_resource_group.prod_a7m_resource_group.id
  role_definition_id = data.azurerm_role_definition.reader.id
  principal_id       = azuread_group.prod_a7m_aad_readonly_group.object_id
  lifecycle {
    ignore_changes = [
       role_definition_id,
    ]
  } 
}

resource "azurerm_role_assignment" "prod_a7m_aad_admin_group_resource_group" {
  scope              = azurerm_resource_group.prod_a7m_resource_group.id
  role_definition_id = data.azurerm_role_definition.owner.id
  principal_id       = azuread_group.prod_a7m_aad_admin_group.object_id
  lifecycle {
    ignore_changes = [
      role_definition_id,
    ]
  } 
} */