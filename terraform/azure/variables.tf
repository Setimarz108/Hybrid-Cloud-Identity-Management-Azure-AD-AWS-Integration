# terraform/azure/variables.tf
variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "West Europe"
  
  validation {
    condition = contains([
      "West Europe", 
      "Germany West Central", 
      "North Europe"
    ], var.location)
    error_message = "Location must be in Europe for compliance reasons."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "demo"
  
  validation {
    condition     = contains(["dev", "staging", "prod", "demo"], var.environment)
    error_message = "Environment must be dev, staging, prod, or demo."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "hybrid-identity"
}

variable "admin_group_members" {
  description = "List of user principal names to add to admin groups"
  type        = list(string)
  default     = []
}

variable "enable_monitoring" {
  description = "Enable monitoring and logging features"
  type        = bool
  default     = true
}

variable "key_vault_sku" {
  description = "SKU for Key Vault"
  type        = string
  default     = "standard"
  
  validation {
    condition     = contains(["standard", "premium"], var.key_vault_sku)
    error_message = "Key Vault SKU must be standard or premium."
  }
}
