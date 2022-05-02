terraform {
  required_version = "0.15.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "nops_aws_acc_register" {
  source = "../../"

  ReportName        = var.ReportName
  s3prefix          = var.s3prefix
  BucketName        = var.BucketName
  ExternalId        = var.ExternalId
  nOpsApiKey        = var.nOpsApiKey
  nOpsPrivateKey    = var.nOpsPrivateKey
  AccNameToRegister = var.AccNameToRegister
  tags              = var.tags
}