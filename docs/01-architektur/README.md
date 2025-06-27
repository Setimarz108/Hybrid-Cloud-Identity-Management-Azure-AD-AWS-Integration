# Architecture Documentation

## Overview
This hybrid cloud identity solution integrates Azure AD with AWS IAM using SAML 2.0 federation.

## Components

### Azure AD
- 4 Security Groups for role-based access
- Enterprise Application for AWS SAML
- Multi-factor authentication enforcement

### AWS
- SAML Identity Provider
- 4 IAM Roles with trust policies
- CloudTrail for audit logging
- S3 bucket for encrypted log storage

## Security Design
- Zero Trust architecture
- Least privilege access
- Complete audit trail
- EU data residency (Frankfurt)
