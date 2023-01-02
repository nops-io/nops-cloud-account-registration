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

variable "AccNamePreFixToRegister" {
  type        = string
  default     = "child"
  description = "Account name to register in nOps, Default it will be child-<account id>, and if value is provided then it will be <value provided>-<account id>."
}

variable "member_acc_template_url" {
  type        = string
  default     = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/member_consolidated_aws_acc_nops_register-v0.3.0.yaml"
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
