variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map(any)
}

variable "ReportName" {
  type        = string
  default     = "nopsbilling-daily-gzip"
  description = "Nops daily generated report name"
}

variable "s3prefix" {
  type        = string
  default     = "something"
  description = "Nops daily generated reports folder prefix"
}

variable "BucketName" {
  type        = string
  default     = "nopsbucketforlogs"
  description = "s3 bucket name for nops daily reports"
}

variable "ExternalId" {
  type        = string
  sensitive   = true
  description = "External id required for cross account access role for nops"
}

variable "NopsApiKey" {
  type        = string
  sensitive   = true
  description = "Nops api key to register aws accounts"
}

variable "NopsPrivateKey" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Nops private key to generate signature for api request, it should be single line string (optional)."
}

variable "AccNameToRegister" {
  type        = string
  description = "Account name to register in nops."
}

variable "template_url" {
  type        = string
  default     = "https://nops-register-aws-account-us-east-1.s3.amazonaws.com/nops_register_aws_acc.yaml"
  description = "cloudformation template url."
}

variable "list_of_OU_ids" {
  type        = list(string)
  default     = null
  description = "list of organisation unit ids to deploy stacks."
}