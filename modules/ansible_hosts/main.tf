
locals {
  key_dir_prefix = var.key_dir == "" ? "" : "${var.key_dir}/"
}

resource "local_file" "inventory_hosts" {
  content = templatefile(
    "${path.module}/hosts.jinja",
    {
      "group_name" = var.group_name,
      "computers" = {
        for computer, params in var.computers :
        computer => {
          "ip"       = params.public_ip,
          "ssh_user" = params.ssh_user,
          "file"     = "${local.key_dir_prefix}${params.key_name}",
          "hostname" = replace(computer, "_", "-"),
          "prefix"   = var.group_name,
        }
      }
    }
  )
  filename = var.filename
}
