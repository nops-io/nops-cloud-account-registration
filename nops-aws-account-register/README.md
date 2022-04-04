
# Nops Account Registration Automation
- Descriptions of the files and folders are as follows:

## Prerequisite
**Note:** For IaaC deployment **AWS Region** must be ""**us-east-1**" (N. Virginia) for _all users_.


Following is the list of folders and a description of the items they contain:

### cloudformation-single-acc-register
This folder contains CloudFormation template to register a single AWS account with nOps

### lambda_functions
This folder contains the python code for the lambda function which registers AWS accounts to nops.

### terraform-multi-acc-register-via-stacksets
This folder contains a Terraform module which deploys CloudFormation stacksets.
CloudFormation stacksets deploys the CloudFormation template in all accounts defined in the organizational unit (OU).

### terraform-single-acc-register
This folder contains a Terraform module which is an alternative for a single AWS account registration via CloudFormation.
Any Clients who wants to manage all resource through Terraform can use this module.
