# nOps Account Registration Automation

This document contains the descriptions of the files and folders in `nops-aws-account-register`.

## Prerequisite
* For IaaC (Infrastructure as Code) deployment, **AWS Region** must be "**us-east-1**" (N. Virginia) for _all users_.
* In order to use the nOps API, you must register an API client and an optional signature encryption key. For more detail, see, [Getting started with the nOps developer API](https://docs.nops.io/en/articles/5955764-getting-started-with-the-nops-developer-api).

## cloudformation-single-acc-register

This [folder](https://github.com/nops-io/nops-cloud-account-registration/tree/main/nops-aws-account-register/cloudformation-single-acc-register) contains _CloudFormation_ template to register a single AWS account, or AWS Organization master payer account, with nOps.
- **AWS Cloudformation** -> **stacks** -> [nops_register_aws_acc.yaml](https://github.com/nops-io/nops-cloud-account-registration/blob/main/nops-aws-account-register/cloudformation-single-acc-register/nops_register_aws_acc.yaml)
- Add Parameters, for API/Private Key, check Prerequisite 

## cloudformation-org-member-accounts-register
This [folder](https://github.com/nops-io/nops-cloud-account-registration/tree/main/nops-aws-account-register/cloudformation-org-member-accounts-register) contains _CloudFormation_ templates to register multiple AWS organization member accounts to nOps.
- **AWS Cloudformation** -> **stacksets** -> [member_consolidated_aws_acc_nops_register.yaml](https://github.com/nops-io/nops-cloud-account-registration/blob/main/nops-aws-account-register/cloudformation-org-member-accounts-register/member_consolidated_aws_acc_nops_register.yaml)
- Add Parameters, for API/Private Key, check Prerequisite

## lambda_functions
This folder contains the Python code for the lambda function that registers AWS accounts to nOps.

## terraform-master-payer-register
This folder contains a _Terraform_ module that deploys a _CloudFormation_ stack.

This should be deployed on single aws account or organization's master payer account only.
## terraform-multiple-child-accs-register-via-stacksets
This folder contains a _Terraform_ module that deploys _CloudFormation_ stacksets.

_CloudFormation_ stacksets deploys the _CloudFormation_ template for all child accounts defined in the organizational unit (OU).

Terraform: [Adding Multiple AWS Accounts to nOps with Terraform](https://docs.nops.io/en/articles/6464661-adding-multiple-aws-accounts-to-nops-with-terraform)