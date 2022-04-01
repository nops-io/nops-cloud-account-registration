# Nops Account Registration Automation
- Descriptions of the files and folders are as follows:

## Prerequisite
- AWS Region must be "us-east-1" N.virginia for IaaC deployment.
### cloudformation-single-acc-register
- This folder contains CloudFormation template to register a single AWS account with nOps
  
### lambda_functions
- This folder contains the python code for the lambda function which registers AWS accounts to nops.

### terraform-multi-acc-register-via-stacksets
- This folder contains a Terraform module which deploys CloudFormation stacksets.
- CloudFormation stacksets deploys the CloudFormation template in all accounts defined in OU.

### terraform-single-acc-register
- This folder is a terraform module which is alternative for single AWS account registration via CloudFormation.
- Clients who wants to manage all resource via Terraform can use this module.