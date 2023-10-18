
data "aws_caller_identity" "current" {}

locals {

  prefix = "${var.prefix}%{if substr(var.prefix, -1, 1) != "-"}-%{else}%{endif}%{if terraform.workspace != "default"}${terraform.workspace}-%{else}%{endif}"

  target_account = data.aws_caller_identity.current.account_id
  target_region  = var.aws_region
}
