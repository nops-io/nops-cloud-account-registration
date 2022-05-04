
# nOps Account Registration Automation
- Descriptions of the files and folders are as follows:

## Prerequisite
 * For IaaC deployment **AWS Region** must be ""**us-east-1**" (N. Virginia) for _all users_.
 * In order to use the nOps API, you must register an API client and optionally a signature encryption key. See more detail in nOps developer documentation:

     https://docs.nops.io/en/articles/5955764-getting-started-with-the-nops-developer-api


## Following is the list of folders and a description of the items they contain:

### cloudformation-single-acc-register
This folder contains CloudFormation template to register a single AWS account with nOps.

### cloudformation-org-accounts-register
This folder contains CloudFormation template to register AWS accounts with consolidated billing and organisation to nOps.

### lambda_functions
This folder contains the python code for the lambda function which registers AWS accounts to nOps.

### terraform-multi-acc-register-via-stacksets
This folder contains a Terraform module which deploys CloudFormation stacksets.
CloudFormation stacksets deploys the CloudFormation template for all accounts defined in the organizational unit (OU).

### terraform-single-acc-register
This folder contains a Terraform module which is an alternative for a single AWS account registration via CloudFormation.
Any customer who wants to manage all resources through Terraform can use this module.
