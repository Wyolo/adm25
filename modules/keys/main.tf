
module "prefix" {
  source = "../prefix"
  value  = var.prefix
}

resource "tls_private_key" "items" {
  for_each = toset(var.names)

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "items" {
  for_each = toset(var.names)

  key_name   = "${module.prefix.value}${each.value}"
  public_key = tls_private_key.items[each.key].public_key_openssh
}
