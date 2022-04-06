data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
locals {
  identifier = "nops-account-register"
}
resource "aws_cloudformation_stack_set" "nops-account-register" {
  name                    = local.identifier
  template_url = var.template_url
  permission_model        = "SERVICE_MANAGED"
  auto_deployment {
    enabled = true
    retain_stacks_on_account_removal = false
  }
  

  parameters = {
    ReportName        = var.ReportName
    s3prefix          = var.s3prefix
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

resource "aws_cloudformation_stack_set_instance" "ou_instances" {
  deployment_targets {
    organizational_unit_ids = toset(var.list_of_OU_ids)
  }

  region         = data.aws_region.current.name
  stack_set_name = aws_cloudformation_stack_set.nops-account-register.name
}
