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

variable "ExternalId" {
  type        = string
  sensitive   = true
  description = "External id required for cross account access role for nOps"
}

variable "NopsApiKey" {
  type        = string
  sensitive   = true
  description = "nOps api key to register AWS accounts"
}

variable "NopsPrivateKey" {
  type        = string
  sensitive   = true
  default     = ""
  description = "nOps private key to generate signature for api request, it should be single line string (optional)."
}

variable "AccNameToRegister" {
  type        = string
  description = "Account name to register in nOps."
}

variable "template_url" {
  type        = string
  default     = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/nops_register_aws_acc.yaml"
  description = "CloudFormation template url."
}

variable "list_of_OU_ids" {
  type        = list(string)
  description = "list of organisation unit ids to deploy stacks."
}