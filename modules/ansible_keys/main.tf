
resource "local_file" "pem_files" {
  for_each = var.keys

  content  = each.value.pem
  filename = "${local.output_dir_prefixed}${each.key}"
}

resource "local_file" "pub_files" {
  for_each = var.keys

  content  = each.value.pub
  filename = "${local.output_dir_prefixed}${each.key}.pub"
}
