# Register AWS Accounts in OUs To n0ps Terraform Module

This Terraform module creates CloudFormation stacksets and creates resources required to register AWS accounts to nOps using provided Organization Unit IDs.

## Usage
```hcl
    module "register_aws_acc_to_nops" {
        source                  = "./"

        ExternalId              = "12345"
        NopsApiKey              = "12345"
        AccNameToRegister       = "demo"
        master_payer_acc_id     = "98123576903"
        list_of_OU_ids          = ["ou-abcdefgh", "ou-ijklmn"]
        org_root_id             = ["r-123b"]
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
| [aws_cloudformation_stack.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack_set.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set.master_payer_consolidated_nops_account_register](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_cloudformation_stack_set_instance.master_payer_consolidated_ou_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_iam_role.AWSCloudFormationStackSetAdministrationRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AccNameToRegister"></a> [AccNameToRegister](#input\_AccNameToRegister) | Account name to register in nOps. | `string` | n/a | yes |
| <a name="input_BucketName"></a> [BucketName](#input\_BucketName) | s3 bucket name for nOps daily reports | `string` | `"nopsbucketforlogs"` | no |
| <a name="input_ExternalId"></a> [ExternalId](#input\_ExternalId) | External id required for cross account access role for nOps | `string` | n/a | yes |
| <a name="input_ReportName"></a> [ReportName](#input\_ReportName) | nOps daily generated report name | `string` | `"nopsbilling-daily-gzip"` | no |
| <a name="input_child_acc_template_url"></a> [child\_acc\_template\_url](#input\_child\_acc\_template\_url) | CloudFormation template url for child accounts. | `string` | `"https://nops-register-aws-account-us-east-1.s3.amazonaws.com/child_consolidated_aws_acc_nops_register.yaml"` | no |
| <a name="input_list_of_OU_ids"></a> [list\_of\_OU\_ids](#input\_list\_of\_OU\_ids) | list of organisation unit ids to deploy stacks on child AWS accounts. | `list(string)` | n/a | yes |
| <a name="input_master_payer_acc_id"></a> [master\_payer\_acc\_id](#input\_master\_payer\_acc\_id) | AWS org Consolidted billing master payer account id. | `string` | n/a | yes |
| <a name="input_master_payer_acc_template_url"></a> [master\_payer\_acc\_template\_url](#input\_master\_payer\_acc\_template\_url) | CloudFormation template url for consolidated billing master payer AWS account. | `string` | `"https://nops-register-aws-account-us-east-1.s3.amazonaws.com/master_payer_consolidated_aws_acc_nops_register.yaml"` | no |
| <a name="input_nOpsApiKey"></a> [nOpsApiKey](#input\_nOpsApiKey) | nOps api key to register AWS accounts | `string` | n/a | yes |
| <a name="input_nOpsPrivateKey"></a> [nOpsPrivateKey](#input\_nOpsPrivateKey) | nOps private key to generate signature for api request, it should be single line string (optional). | `string` | `""` | no |
| <a name="input_org_root_id"></a> [org\_root\_id](#input\_org\_root\_id) | AWS Organisation root id. | `list(string)` | n/a | yes |
| <a name="input_s3prefix"></a> [s3prefix](#input\_s3prefix) | nOps daily generated reports folder prefix | `string` | `"something"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the resource | `map(any)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | n/a |
