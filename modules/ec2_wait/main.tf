
resource "null_resource" "wait_connection" {
  for_each = var.computers

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]
    # TODO: add timeout to limit waiting time
    # See https://github.com/hashicorp/terraform/issues/17387

    connection {
      type        = "ssh"
      host        = each.value.public_ip
      user        = each.value.ssh_user
      private_key = var.keys[each.value.key_name].pem
    }
  }
}
