# terraform/azure/outputs.tf
output "resource_group_identity_name" {
  description = "Name of the identity resource group"
  value       = azurerm_resource_group.identity.name
}

output "resource_group_monitoring_name" {
  description = "Name of the monitoring resource group"
  value       = azurerm_resource_group.monitoring.name
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main.name
}

output "azure_ad_groups" {
  description = "Azure AD Groups created"
  value = {
    finance_admins     = azuread_group.finance_admins.display_name
    aws_users         = azuread_group.aws_users.display_name
    developers        = azuread_group.developers.display_name
    security_auditors = azuread_group.security_auditors.display_name
  }
}

output "azure_ad_group_ids" {
  description = "Azure AD Group IDs for reference"
  value = {
    finance_admins_id     = azuread_group.finance_admins.object_id
    aws_users_id         = azuread_group.aws_users.object_id
    developers_id        = azuread_group.developers.object_id
    security_auditors_id = azuread_group.security_auditors.object_id
  }
}

output "tenant_id" {
  description = "Azure AD Tenant ID"
  value       = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  description = "Azure Subscription ID"
  value       = data.azurerm_client_config.current.subscription_id
}

