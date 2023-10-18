
module "prefix" {
  source = "../prefix"
  value  = var.prefix
}

resource "aws_instance" "items" {
  for_each = toset(var.instance_names)

  subnet_id     = var.subnet_id
  ami           = var.instance_ami_id
  instance_type = var.instance_type
  key_name      = local.key_names[each.key].name_prefixed
  # TODO: use var.enable_elastic_ip?
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = var.instance_disk_size
  }

  vpc_security_group_ids = [
    var.security_group_ingress_id,
    var.security_group_egress_id,
  ]

  tags = merge(var.tags, {
    Name = local.instance_names_prefixed[each.key]
  })
}

data "aws_subnet" "items" {
  for_each = toset(var.instance_names)

  id = aws_instance.items[each.key].subnet_id
}

locals {
  items_ip = var.enable_elastic_ip ? toset(var.instance_names) : []
}

resource "aws_eip" "items" {
  for_each = local.items_ip

  instance = aws_instance.items[each.key].id
  vpc      = true
}
