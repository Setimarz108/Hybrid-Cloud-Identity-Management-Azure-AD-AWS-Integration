# terraform/aws/outputs.tf (Phase 1 - ohne SAML Provider)

output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS Region"
  value       = data.aws_region.current.name
}

output "finance_admin_role_arn" {
  description = "ARN of the Finance Administrator role"
  value       = aws_iam_role.finance_admin_role.arn
}

output "finance_admin_role_name" {
  description = "Name of the Finance Administrator role"
  value       = aws_iam_role.finance_admin_role.name
}

output "developer_role_arn" {
  description = "ARN of the Developer role"
  value       = aws_iam_role.developer_role.arn
}

output "developer_role_name" {
  description = "Name of the Developer role"
  value       = aws_iam_role.developer_role.name
}

output "aws_user_role_arn" {
  description = "ARN of the AWS User role"
  value       = aws_iam_role.aws_user_role.arn
}

output "aws_user_role_name" {
  description = "Name of the AWS User role"
  value       = aws_iam_role.aws_user_role.name
}

output "security_auditor_role_arn" {
  description = "ARN of the Security Auditor role"
  value       = aws_iam_role.security_auditor_role.arn
}

output "security_auditor_role_name" {
  description = "Name of the Security Auditor role"
  value       = aws_iam_role.security_auditor_role.name
}

output "cloudtrail_name" {
  description = "Name of the CloudTrail"
  value       = aws_cloudtrail.main.name
}

output "cloudtrail_arn" {
  description = "ARN of the CloudTrail"
  value       = aws_cloudtrail.main.arn
}

output "cloudtrail_s3_bucket" {
  description = "S3 bucket for CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_logs.id
}

output "cloudtrail_s3_bucket_arn" {
  description = "ARN of the S3 bucket for CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_logs.arn
}

# Diese Outputs werden später für SAML-Konfiguration verwendet
output "role_mappings_for_azure_ad" {
  description = "Role mappings for Azure AD SAML configuration"
  value = {
    "Finance Administrators" = aws_iam_role.finance_admin_role.arn
    "Developer Team"        = aws_iam_role.developer_role.arn
    "AWS Users"            = aws_iam_role.aws_user_role.arn
    "Security Auditors"    = aws_iam_role.security_auditor_role.arn
  }
}