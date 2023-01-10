data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
locals {
  identifier = "nops-account-register"
}

resource "aws_cloudformation_stack_set" "member_consolidated_nops_account_register" {
  name             = "member-consolidated-${local.identifier}"
  template_url     = var.member_acc_template_url
  permission_model = "SERVICE_MANAGED"
  auto_deployment {
    enabled                          = true
    retain_stacks_on_account_removal = false
  }

  parameters = {
    nOpsApiKey        = var.nOpsApiKey
    nOpsPrivateKey    = var.nOpsPrivateKey
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

resource "aws_cloudformation_stack_set_instance" "member_consolidated_ou_instances" {
  deployment_targets {
    organizational_unit_ids = toset(var.org_root_id)
  }

  region         = data.aws_region.current.name
  stack_set_name = aws_cloudformation_stack_set.member_consolidated_nops_account_register.name

  operation_preferences {
    failure_tolerance_percentage = "25"
    max_concurrent_percentage = "100"
  }
}
