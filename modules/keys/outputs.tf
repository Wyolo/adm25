
output "keys" {
  description = "Map of keys"
  value = {
    for name in var.names : name => {
      "name"          = name,
      "name_prefixed" = aws_key_pair.items[name].key_name,
      "pem"           = tls_private_key.items[name].private_key_pem,
      "pub"           = tls_private_key.items[name].public_key_openssh,
    }
  }
}
