
locals {
  prefix = "${var.value}%{if substr(var.value, -1, 1) != "-"}-%{else}%{endif}%{if terraform.workspace != "default"}${terraform.workspace}-%{else}%{endif}"
}
