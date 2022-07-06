
# nOps Account Registration Automation
- Descriptions of the files and folders are as follows:

## Prerequisite
 * For IaaC deployment **AWS Region** must be ""**us-east-1**" (N. Virginia) for _all users_.
 * In order to use the nOps API, you must register an API client and optionally a signature encryption key. See more detail in nOps developer documentation:

     https://docs.nops.io/en/articles/5955764-getting-started-with-the-nops-developer-api


## Following is the list of folders and a description of the items they contain:

### cloudformation-single-acc-register
This folder contains CloudFormation template to register a single AWS account (No AWS organization) or Organization master payer account with nOps.

### cloudformation-org-member-accounts-register
This folder contains CloudFormation templates to register multiple AWS organization member accounts to nOps.

### lambda_functions
This folder contains the python code for the lambda function which registers AWS accounts to nOps.

### terraform-multi-acc-register-via-stacksets
This folder contains a Terraform module which deploys CloudFormation stacksets.
CloudFormation stacksets deploys the CloudFormation template for all accounts defined in the organizational unit (OU).

Push Check.
