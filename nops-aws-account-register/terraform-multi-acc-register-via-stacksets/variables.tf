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
  default     = "something"
  description = "nOps daily generated reports folder prefix"
}

variable "BucketName" {
  type        = string
  default     = "nopsbucketforlogs"
  description = "s3 bucket name for nOps daily reports"
}

variable "nOpsApiKey" {
  type        = string
  sensitive   = true
  description = "nOps api key to register AWS accounts"
}

variable "nOpsPrivateKey" {
  type        = string
  sensitive   = true
  default     = ""
  description = "nOps private key to generate signature for api request, it should be single line string (optional)."
}

variable "AccNameToRegister" {
  type        = string
  description = "Account name to register in nOps."
}

variable "master_payer_acc_template_url" {
  type        = string
  default     = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/nops_register_aws_acc-v0.1.10.yaml"
  description = "CloudFormation template url for consolidated billing master payer AWS account."
}

variable "member_acc_template_url" {
  type        = string
  default     = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/member_consolidated_aws_acc_nops_register-v0.1.10.yaml"
  description = "CloudFormation template url for member accounts."
}

variable "list_of_OU_ids" {
  type        = list(string)
  description = "list of Organization unit ids to deploy stacks on member AWS accounts."
}

variable "org_root_id" {
  type        = list(string)
  description = "AWS Organization root id for CloudFormation stackset execution role."
}

variable "master_payer_acc_id" {
  type        = string
  description = "AWS org Consolidated billing master payer account id."
}
