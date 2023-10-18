
resource "local_file" "inventory_awscli_users" {
  content = templatefile(
    "${path.module}/awscli_users.jinja",
    {
      "users" = {
        for user, params in var.users :
        user => {
          "access_key"        = params.access_key,
          "secret_access_key" = params.secret_access_key,
          "region"            = var.aws_region,
        }
      }
    }
  )
  filename = var.filename
}
