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
| aws  | < 4.0   |

## Providers

| Name                  | Version |
|-----------------------|---------|
| [AWS](./providers.tf) | < 4.0   |

## Resources

| Name                                                                                                                                                                                         | Type        | Details                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|----------------------------------------------------------------------|
| [aws_cloudformation_stack.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)                                         | resource    | setup-stacksets-permissions.tf (line:32)                             |
| [aws_cloudformation_stack_set.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set)                                 | resource    | setup-stacksets-permissions.tf (line:48)                             |
| [aws_cloudformation_stack_set.master_payer_consolidated_nops_account_register](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set)         | resource    | main.tf (line:7)                                                     |
| [aws_cloudformation_stack_set.member_consolidated_nops_account_register](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set)               | resource    | main.tf (line:40)                                                    |
| [aws_cloudformation_stack_set_instance.execution_role_creation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance)               | resource    | setup-stacksets-permissions.tf (line:69)                             |
| [aws_cloudformation_stack_set_instance.master_payer_consolidated_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance)   | resource    | main.tf (line:33)                                                    |
| [aws_cloudformation_stack_set_instance.member_consolidated_ou_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance)      | resource    | main.tf (line:61)                                                    |
| [aws_iam_role.AWSCloudFormationStackSetAdministrationRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                             | resource    | setup-stacksets-permissions.tf (line:21)                             |
| [aws_iam_role_policy.AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)               | resource    | setup-stacksets-permissions.tf (line:26)                             |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                                                                | data source | setup-stacksets-permissions.tf (line:36, line:57)                    |
| [aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)    | data source | setup-stacksets-permissions.tf (line:13)                             |
| [aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source | setup-stacksets-permissions.tf (line:1)                              |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                                                                  | data source | main.tf (line:35, line:66), setup-stacksets-permissions.tf (line:46) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AccNameToRegister"></a> [AccNameToRegister](#input\_AccNameToRegister) | Account name to register in nOps. | `string` | n/a | yes |
| <a name="input_BucketName"></a> [BucketName](#input\_BucketName) | s3 bucket name for nOps daily reports | `string` | `"nopsbucketforlogs"` | no |
| <a name="input_ReportName"></a> [ReportName](#input\_ReportName) | nOps daily generated report name | `string` | `"nopsbilling-daily-gzip"` | no |
| <a name="input_list_of_OU_ids"></a> [list\_of\_OU\_ids](#input\_list\_of\_OU\_ids) | list of Organization unit ids to deploy stacks on member AWS accounts. | `list(string)` | n/a | yes |
| <a name="input_master_payer_acc_id"></a> [master\_payer\_acc\_id](#input\_master\_payer\_acc\_id) | AWS org Consolidated billing master payer account id. | `string` | n/a | yes |
| <a name="input_master_payer_acc_template_url"></a> [master\_payer\_acc\_template\_url](#input\_master\_payer\_acc\_template\_url) | CloudFormation template url for consolidated billing master payer AWS account. | `string` | `"https://nops-register-aws-account-us-east-1.s3.amazonaws.com/nops_register_aws_acc.yaml"` | no |
| <a name="input_member_acc_template_url"></a> [member\_acc\_template\_url](#input\_member\_acc\_template\_url) | CloudFormation template url for member accounts. | `string` | `"https://nops-register-aws-account-us-east-1.s3.amazonaws.com/member_consolidated_aws_acc_nops_register.yaml"` | no |
| <a name="input_nOpsApiKey"></a> [nOpsApiKey](#input\_nOpsApiKey) | nOps api key to register AWS accounts | `string` | n/a | yes |
| <a name="input_nOpsPrivateKey"></a> [nOpsPrivateKey](#input\_nOpsPrivateKey) | nOps private key to generate signature for api request, it should be single line string (optional). | `string` | `""` | no |
| <a name="input_org_root_id"></a> [org\_root\_id](#input\_org\_root\_id) | AWS Organization root id for CloudFormation stackset execution role. | `list(string)` | n/a | yes |
| <a name="input_s3prefix"></a> [s3prefix](#input\_s3prefix) | nOps daily generated reports folder prefix | `string` | `"something"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the resource | `map(any)` | `{}` | no |



## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | n/a |
