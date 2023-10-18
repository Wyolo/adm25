
output "instances" {
  description = "Map of instances"
  value = {
    for name in var.instance_names : name => {
      "name"      = name,
      "id"        = aws_instance.items[name].id,
      "public_ip" = aws_instance.items[name].public_ip,
      "key_name"  = local.key_names[name].name,
      "ssh_user"  = var.ssh_user,
    }
  }
}

# TODO: Add other attributes as well
output "ssh_user" {
  description = "Main user"
  value       = var.ssh_user
}
