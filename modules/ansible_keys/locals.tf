locals {

  output_dir = "${var.output_dir}%{if substr(var.output_dir, -1, 1) != "/"}/%{else}%{endif}"

  output_dir_prefixed = "${local.output_dir}${var.output_file_prefix}"

}
