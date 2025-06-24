# terraform/aws/variables.tf
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
  
  validation {
    condition = contains([
      "eu-central-1", 
      "eu-west-1", 
      "eu-west-3"
    ], var.aws_region)
    error_message = "AWS region must be in Europe for compliance."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "demo"
}

variable "azure_tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
  default     = "ecf3b07d-1f21-4448-a688-aa0de346eb0b"
}

variable "azure_domain" {
  description = "Azure AD Domain"
  type        = string
  default     = "sebastianmarquezdevgmail.onmicrosoft.com"
}

variable "azure_ad_metadata" {
  description = "Azure AD SAML Metadata XML (will be provided later)"
  type        = string
  default     = ""
}
