data "aws_iam_policy_document" "AWSCloudFormationStackSetAdministrationRole_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = ["cloudformation.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy" {
  statement {
    actions   = ["sts:AssumeRole"]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:role/AWSCloudFormationStackSetExecutionRole-nOps"]
  }
}

resource "aws_iam_role" "AWSCloudFormationStackSetAdministrationRole" {
  assume_role_policy = data.aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_assume_role_policy.json
  name               = "AWSCloudFormationStackSetAdministrationRole-nOps"
}

resource "aws_iam_role_policy" "AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy" {
  name   = "ExecutionPolicy"
  policy = data.aws_iam_policy_document.AWSCloudFormationStackSetAdministrationRole_ExecutionPolicy.json
  role   = aws_iam_role.AWSCloudFormationStackSetAdministrationRole.name
}

resource "aws_cloudformation_stack" "execution_role_creation" {
  name         = "create-cloudformation-executionrole"
  template_url = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/cloudformation_execution_role.yaml"
  parameters = {
    AdministratorAccountId = data.aws_caller_identity.current.account_id
  }
  capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_NAMED_IAM"
  ]
  tags = var.tags
  depends_on = [
    aws_iam_role.AWSCloudFormationStackSetAdministrationRole
  ]
}

resource "aws_cloudformation_stack_set" "execution_role_creation" {
  name             = "create-stackset-executionrole"
  template_url     = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/cloudformation_execution_role.yaml"
  permission_model = "SERVICE_MANAGED"
  auto_deployment {
    enabled                          = true
    retain_stacks_on_account_removal = false
  }
  parameters = {
    AdministratorAccountId = data.aws_caller_identity.current.account_id
  }
  capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_NAMED_IAM"
  ]
  tags = var.tags
  depends_on = [
    aws_cloudformation_stack.execution_role_creation
  ]
}

resource "aws_cloudformation_stack_set_instance" "execution_role_creation" {
  deployment_targets {
    organizational_unit_ids = toset(var.org_root_id)
  }

  region         = data.aws_region.current.name
  stack_set_name = aws_cloudformation_stack_set.execution_role_creation.name

  operation_preferences {
    failure_tolerance_percentage = "25"
    max_concurrent_percentage = "100"
  }
  depends_on = [
    aws_cloudformation_stack.execution_role_creation,
    aws_cloudformation_stack_set.execution_role_creation
  ]
}
