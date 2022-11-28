# nOps Cloud Account Registration
This project contains a set of tools and example code to configure IAM permissions and register your accounts with the nOps application using IaaC code. You can register single accounts or multiple accounts using the AWS Organization hierarchy.

## Table of contents
- [Overview](#overview)
- [AWS Account Registration](nops-aws-account-register/README.md)


## Overview
nOps requires safe, secure, and AWS approved access to your Cloud accounts in order to give you the analysis, dashboards, and reports that you need.

This repo contains IaaC code to automate Cloud Account registration process.

In Automatic Setup, nOps takes care of creating the IAM policy and the CloudFormation stack for the account. If you have more than 10 accounts that you want to onboard, Automatic Setup also provides you the option to use the IaaC setup process to onboard all accounts simultaneously.

### Prerequisites
To successfully set up the AWS account(s), the AWS user must possess:
- Access to the master payer account, if you are using AWS Organizations.
- Permission to create and run an AWS CloudFormation stack.
- Permission to create AWS Identity and Access Management (IAM) roles in your account.
- The name of an Amazon S3 bucket where your AWS Cost and Usage Reports (CURs) will be written. (nOps will create a bucket with the provided name, if one does not exist.)
- CURs enabled in the account.

Pro Tip: If you add an AWS child account instead of a Master Payer Account, nOps will only see the cost details of the specific child account instead of the cost details of the entire organization.

Terraform: [Adding Multiple AWS Accounts to nOps with Terraform](https://docs.nops.io/en/articles/6464661-adding-multiple-aws-accounts-to-nops-with-terraform)