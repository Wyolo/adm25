
resource "local_file" "inventory_users" {
  content = templatefile(
    "${path.module}/users.jinja",
    {
      "var_name" = var.var_name,
      "users" = {
        for user, params in var.users :
        user => {
          "password" = params.password,
        }
      }
    }
  )
  filename = var.filename
}
