variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map(any)
}

variable "ReportName" {
  type        = string
  default     = "nopsbilling-daily-gzip"
  description = "nOps daily generated report name"
}

variable "s3prefix" {
  type        = string
  default     = "nOpsbilling"
  description = "nOps daily generated reports folder prefix"
}

variable "BucketName" {
  type        = string
  default     = "nopsbucketforcostusagereports"
  description = "s3 bucket name for nOps daily cost usage reports (CUR)."
}

variable "nOpsApiKey" {
  type        = string
  sensitive   = true
  description = "nOps api key to register AWS accounts"
}

variable "nOpsPrivateKey" {
  type        = string
  sensitive   = true
  description = "nOps private key to generate signature for api request, it should be single line string (optional)."
}

variable "master_payer_acc_template_url" {
  type        = string
  default     = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/nops_register_aws_acc-v0.4.0.yaml"
  description = "CloudFormation template url for consolidated billing master payer AWS account."
}

