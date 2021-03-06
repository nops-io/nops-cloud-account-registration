# nOps Account Registration Automation

This document contains the descriptions of the files and folders in `nops-aws-account-register`.

## Prerequisite
* For IaaC (Infrastructure as Code) deployment, **AWS Region** must be "**us-east-1**" (N. Virginia) for _all users_.
* In order to use the nOps API, you must register an API client and an optional signature encryption key. For more detail, see, [Getting started with the nOps developer API](https://docs.nops.io/en/articles/5955764-getting-started-with-the-nops-developer-api).

## cloudformation-single-acc-register

This folder contains _CloudFormation_ template to register a single AWS account, or AWS Organization master payer account, with nOps.

## cloudformation-org-member-accounts-register
This folder contains _CloudFormation_ templates to register multiple AWS organization member accounts to nOps.

## lambda_functions
This folder contains the Python code for the lambda function that registers AWS accounts to nOps.

## terraform-multi-acc-register-via-stacksets
This folder contains a _Terraform_ module that deploys _CloudFormation_ stacksets.

_CloudFormation_ stacksets deploys the _CloudFormation_ template for all accounts defined in the organizational unit (OU).
