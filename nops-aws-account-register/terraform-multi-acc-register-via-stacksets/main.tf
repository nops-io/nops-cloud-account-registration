data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
locals {
  identifier = "nops-account-register"
}

resource "aws_cloudformation_stack_set" "master_payer_consolidated_nops_account_register" {
  name                    = "master-payer-consolidated-${local.identifier}"
  template_url            = var.master_payer_acc_template_url
  permission_model        = "SELF_MANAGED"
  administration_role_arn = aws_iam_role.AWSCloudFormationStackSetAdministrationRole.arn
  execution_role_name     = "AWSCloudFormationStackSetExecutionRole-nOps"

  parameters = {
    ReportName = var.ReportName
    s3prefix   = var.s3prefix
    BucketName = var.BucketName
  }
  capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_NAMED_IAM"
  ]
  tags = var.tags
  depends_on = [
    aws_iam_role.AWSCloudFormationStackSetAdministrationRole,
    aws_cloudformation_stack_set_instance.execution_role_creation
  ]
}

resource "aws_cloudformation_stack_set_instance" "master_payer_consolidated_ou_instances" {
  account_id     = var.master_payer_acc_id
  region         = data.aws_region.current.name
  stack_set_name = aws_cloudformation_stack_set.master_payer_consolidated_nops_account_register.name
}


resource "aws_cloudformation_stack_set" "child_consolidated_nops_account_register" {
  name             = "child-consolidated-${local.identifier}"
  template_url     = var.child_acc_template_url
  permission_model = "SERVICE_MANAGED"
  auto_deployment {
    enabled                          = true
    retain_stacks_on_account_removal = false
  }


  parameters = {
    ReportName        = var.ReportName
    BucketName        = var.BucketName
    ExternalId        = var.ExternalId
    nOpsApiKey        = var.nOpsApiKey
    nOpsPrivateKey    = var.nOpsPrivateKey
    AccNameToRegister = var.AccNameToRegister
  }
  capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_NAMED_IAM"
  ]
  tags = var.tags
}

resource "aws_cloudformation_stack_set_instance" "child_consolidated_ou_instances" {
  deployment_targets {
    organizational_unit_ids = toset(var.list_of_OU_ids)
  }

  region         = data.aws_region.current.name
  stack_set_name = aws_cloudformation_stack_set.child_consolidated_nops_account_register.name
}
