# terraform/azure/main.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Configure the Azure Active Directory Provider
provider "azuread" {}

# Data sources
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

# Local variables
locals {
  project_name = "hybrid-identity"
  location     = var.location
  environment  = var.environment
  
  common_tags = {
    Project     = "HybridIdentity"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "CloudEngineer"
    CostCenter  = "Demo"
  }
}

# Resource Groups
resource "azurerm_resource_group" "identity" {
  name     = "rg-${local.project_name}-${local.environment}-${substr(local.location, 0, 2)}"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "monitoring" {
  name     = "rg-monitoring-${local.environment}-${substr(local.location, 0, 2)}"
  location = local.location
  tags     = local.common_tags
}

# Log Analytics Workspace for monitoring
resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${local.project_name}-${local.environment}"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
}

# Key Vault for storing secrets
resource "azurerm_key_vault" "main" {
  name                = "kv-${local.project_name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.identity.location
  resource_group_name = azurerm_resource_group.identity.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  
  # Enable for template deployment
  enabled_for_template_deployment = true
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  
  # Soft delete and purge protection
  soft_delete_retention_days = 7
  purge_protection_enabled   = false # Keep false for demo environment
  
  tags = local.common_tags
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# Key Vault Access Policy for current user
resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List", "Create", "Delete", "Update", "Purge", "Recover"
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge", "Recover"
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Delete", "Update", "Purge", "Recover"
  ]
}

# Azure AD Groups for role-based access
resource "azuread_group" "finance_admins" {
  display_name     = "Finance Administrators"
  description      = "Administrators for financial applications and AWS access"
  security_enabled = true
  
  owners = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "aws_users" {
  display_name     = "AWS Users"
  description      = "Users with access to AWS resources via Azure AD SSO"
  security_enabled = true
  
  owners = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "developers" {
  display_name     = "Developer Team"
  description      = "Development team members"
  security_enabled = true
  
  owners = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "security_auditors" {
  display_name     = "Security Auditors"
  description      = "Security auditing and compliance team"
  security_enabled = true
  
  owners = [data.azuread_client_config.current.object_id]
}

