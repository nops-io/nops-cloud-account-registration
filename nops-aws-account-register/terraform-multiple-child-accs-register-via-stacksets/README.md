# Register AWS Accounts in OUs To n0ps Terraform Module

This Terraform module creates CloudFormation stacksets and creates resources required to register AWS accounts to nOps using provided Organization Unit IDs.

Before you continue, make sure that you possess the:

- List of Organizational Unit IDs
- nOps API Key
- nOps Private Key.
- Organization Root ID

## Usage
```hcl
    module "register_aws_acc_to_nops" {
        source                  = "./"

        list_of_OU_ids          = ["ou-abcdefgh", "ou-ijklmn"]
        org_root_id             = ["r-123b"]
        nOpsApiKey              = "0000.375a41c2eb019d054662e0954a554098c"
        nOpsPrivateKey          = "-----BEGIN PRIVATE KEY-----\\nMIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALVnq/iUVsZkDGSG\\n/ZFtW62M8x/4MXndl8HKovEKOm4Cdk4Bl2gvX7z2RplKPR1HQWI1AiIhDAoTQncr\\nZEbJjO4uO4RzXCVVCH4zumDl2V6hsgLr9bBZA/xxql+/AtY59Q9jhSFkpiHAhMGa\\nD9V9jiLmZODoQFX58VGnfcBD+5nbAgMBAAECgYBFeIBpYBWjQGlmjjPJX8H+Qr5Q\\n/fGko/IcKwgfmzUpMBQyZ3WeVpYpfX8n8UBaWBF4FKjOfS1pJlsL3Dg4y7MGVh5T\\n9rWTX9HgDw/y9/z1YNEuHVDycm/9dPDXP5InDb4sDlvSwT5NinMigqobGfXAYF42\\n6bPpETzqk7+NWRNywQJBAO3RSs9zDGjrvulG+D34snQAV3wq6YopJ8vm3eVN8Pnv\\nWWgfMjsykndU+laPTez1yPbebbR+6Z2kYdFOwOcGAcsCQQDDRj0ZAuxF1tujJms0\\n17P5PWZ/+pjAQ6rhEEVHTTyQM8vtUsmiqFjUnSyID28lM14jB3zPuc5kMg0vflzk\\nD4YxAkAsQZqOaHaSv+xTNSXVQobTF40wSjwTvfzt8RSyK4MAwA3/Vm7enVasZl//\\n48M4qbSwXExGHqgS8hhR/znexDtpAkACRHmHJdKKiREp1tNd3LdZSI49JDLL4L1G\\nOcMkLdBrOD7A9bojqmLFrUGMHunCe9M3Auo/G0A7R52BlK0NdOSxAkEAgUc1bCmq\\nXuF2n3VFzXgve41JIgGNg2l7mjmQkgwfr5HBXRTSk5p2UPKydwkeL/4EuFDw1IxN\\nHvZERf2Pm7HSZg==\\n-----END PRIVATE KEY-----\\n"
        
    }
```

Inside the `nops-cloud-account-registration/tree/main/nops-aws-account-register/terraform-multi-acc-register-via-stacksets` directory, run —

- terraform init
- terraform plan
- terraform apply

This will start the onboarding process. You can monitor the progress from the terminal where you ran the Terraform commands or you can also monitor the progress from the AWS CloudFormation console. In the CloudFormation console, find the stack with the name member-consolidated-nops-account-register, open it and go to the Stack Instances tab to see the progress.

After a few minutes (depending on the number of accounts) all stacks should be in state “CURRENT”.

To learn more, see [documentation](https://docs.nops.io/en/articles/6464661-adding-multiple-aws-accounts-to-nops-with-terraform)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.48.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack_set.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set.member_consolidated_nops_account_register](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_cloudformation_stack_set_instance.member_consolidated_ou_instances](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_iam_role.AWSCloudFormationStackSetAdministrationRole](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/4.48.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_BucketName"></a> [BucketName](#input\_BucketName) | s3 bucket name for nOps daily cost usage reports (CUR). | `string` | `"nopsbucketforcostusagereports"` | no |
| <a name="input_ReportName"></a> [ReportName](#input\_ReportName) | nOps daily generated report name | `string` | `"nopsbilling-daily-gzip"` | no |
| <a name="input_member_acc_template_url"></a> [member\_acc\_template\_url](#input\_member\_acc\_template\_url) | CloudFormation template url for member accounts. | `string` | `"https://nops-register-aws-account-us-east-1.s3.amazonaws.com/member_consolidated_aws_acc_nops_register.yaml"` | no |
| <a name="input_nOpsApiKey"></a> [nOpsApiKey](#input\_nOpsApiKey) | nOps api key to register AWS accounts | `string` | n/a | yes |
| <a name="input_nOpsPrivateKey"></a> [nOpsPrivateKey](#input\_nOpsPrivateKey) | nOps private key to generate signature for api request, it should be single line string (optional). | `string` | n/a | yes |
| <a name="input_org_root_id"></a> [org\_root\_id](#input\_org\_root\_id) | AWS Organization root id for CloudFormation stackset to deploy stacks on member AWS accounts. | `list(string)` | n/a | yes |
| <a name="input_s3prefix"></a> [s3prefix](#input\_s3prefix) | nOps daily generated reports folder prefix | `string` | `"nOpsbilling"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the resource | `map(any)` | `{}` | no |

## Outputs

No outputs.
