
locals {
  limits = var.limits != "" ? "--limit ${var.limits}" : ""
}

resource "null_resource" "run_ansible" {
  triggers = {
    always    = uuid()
    playbooks = join(" ", var.playbooks)
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.hosts_filename} ${local.limits} ${join(" ", var.playbooks)}"
    # command = "ansible-playbook -i inventory/${var.hosts_filename} ${local.limits} ${join(" ", var.playbooks)}"
    # --limit ${each.value.public_ip} --private-key ${each.value.pem_file}
    working_dir = "ansible"
  }
}
