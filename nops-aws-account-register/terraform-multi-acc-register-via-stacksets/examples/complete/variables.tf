variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map(any)
}

variable "ReportName" {
  type        = string
  description = "nOps daily generated report name"
}

variable "s3prefix" {
  type        = string
  description = "nOps daily generated reports folder prefix"
}

variable "BucketName" {
  type        = string
  description = "s3 bucket name for nOps daily reports"
}

variable "ExternalId" {
  type        = string
  sensitive   = true
  description = "External id required for cross account access role for nOps"
}

variable "nOpsApiKey" {
  type        = string
  sensitive   = true
  description = "nOps api key to register aws accounts"
}

variable "nOpsPrivateKey" {
  type        = string
  sensitive   = true
  description = "nOps private key to generate signature for api request, It must be single line string (optional)."
}

variable "AccNameToRegister" {
  type        = string
  description = "Account name to register in nOps."
}

variable "list_of_OU_ids" {
  type        = list(string)
  description = "list of Organization unit ids to deploy stacks."
}

variable "org_root_id" {
  type        = list(string)
  description = "AWS Organization root id."
}

variable "master_payer_acc_id" {
  type        = string
  description = "AWS org Consolidated billing master payer account id."
}
