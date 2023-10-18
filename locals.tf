
data "aws_caller_identity" "current" {}

locals {
  aws_account = data.aws_caller_identity.current.account_id
  aws_region  = var.aws_region
}
