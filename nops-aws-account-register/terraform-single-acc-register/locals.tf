locals {
  region         = data.aws_region.current.name
  current_acc_id = data.aws_caller_identity.current.account_id
  nops_acc_id    = "202279780353"
}