# Register Aws Accounts in OUs To n0ps Terraform Module

This Terraform module creates CloudFormation stacksets and creates resources required to register AWS accounts to nOps using provided Organization Unit IDs.

## Usage
```hcl
    module "register_aws_acc_to_nops" {
        source                  = "./"

        ExternalId              = "12345"
        NopsApiKey              = "12345"
        AccNameToRegister       = "demo"
        list_of_OU_ids          = ["ou-abcdefgh", "ou-ijklmn"]
    }
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack_set.nops-account-register](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.ou_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|:----------------------------|---------|---------|:--------:|
| <a name="input_AccNameToRegister"></a> [AccNameToRegister](#input\_AccNameToRegister) | This Account name is registered in nOps. | `string` | n/a | yes |
| <a name="input_BucketName"></a> [BucketName](#input\_BucketName) | S3 bucket name for nOps daily reports | `string` | `"nopsbucketforlogs"` | no |
| <a name="input_ExternalId"></a> [ExternalId](#input\_ExternalId) | External id required to enable cross account access role for nOps | `string` | n/a | yes |
| <a name="input_NopsApiKey"></a> [NopsApiKey](#input\_NopsApiKey) | nOps API key to register AWS accounts | `string` | n/a | yes |
| <a name="input_NopsPrivateKey"></a> [NopsPrivateKey](#input\_NopsPrivateKey) | nOps private key to generate a signature for the API request (optional). If used, this should be a single line string that is 'escaped' eg. \\\n instead of \n | `string` | `""` | no |
| <a name="input_ReportName"></a> [ReportName](#input\_ReportName) | Name for the report generated daily by nOps | `string` | `"nopsbilling-daily-gzip"` | no |
| <a name="input_list_of_OU_ids"></a> [list\_of\_OU\_ids](#input\_list\_of\_OU\_ids) | List of organization unit IDs to deploy stacks. | `list(string)` | n/a | yes |
| <a name="input_s3prefix"></a> [s3prefix](#input\_s3prefix) | nOps daily generated reports folder prefix | `string` | `"something"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the resource | `map(any)` | `{}` | no |
| <a name="input_template_url"></a> [template\_url](#input\_template\_url) | CloudFormation template url | `string` | `"https://nops-register-aws-account-us-east-1.s3.amazonaws.com/nops_register_aws_acc.yaml"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | n/a |
