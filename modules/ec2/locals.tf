locals {

  instance_names_prefixed = {
    for name in var.instance_names :
    name => "${module.prefix.value}${name}"
  }

  key_names = {
    for i, name in var.instance_names :
    name => length(var.keys) > 1 ? var.keys[name] : values(var.keys)[0]
  }

}
