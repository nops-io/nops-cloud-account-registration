data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
locals {
  identifier = "nops-account-register"
}

resource "aws_cloudformation_stack" "master_payer_nops_account_register" {
  name                    = "master-payer-${local.identifier}"
  template_url            = var.master_payer_acc_template_url

  parameters = {
    ReportName              = var.ReportName
    s3prefix                = var.s3prefix
    BucketName              = var.BucketName
    nOpsApiKey              = var.nOpsApiKey
    nOpsPrivateKey          = var.nOpsPrivateKey
    AccNamePreFixToRegister = var.AccNamePreFixToRegister
  }
  capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_NAMED_IAM"
  ]
  tags = var.tags
}