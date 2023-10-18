

resource "aws_iam_policy" "students_aws_console" {
  count = var.enable_student_policy_aws_console ? 1 : 0

  name        = "${module.prefix.value}students-aws-console"
  description = "Provide permission to work in console"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:GetAccountSummary",
          "iam:ListAccountAliases",
        ],
        # "Resource" : "arn:aws:iam::*:user/$${aws:username}"
        # "Resource" : "arn:aws:iam:${var.aws_region}:${var.aws_account}:user/*"
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:ListAccessKeys",
          "iam:ListMFADevices",
          "iam:GetLoginProfile",
          "iam:GetUser",
          "iam:GetAccessKeyLastUsed",
          "iam:UpdateAccessKey",
          "iam:CreateAccessKey",
          "iam:DeleteAccessKey",
        ],
        "Resource" : "arn:aws:iam::${var.aws_account}:user/$${aws:username}"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:ListAccessKeys",
          "iam:ListMFADevices",
          "iam:ListUsers",
        ],
        "Resource" : "arn:aws:iam::${var.aws_account}:user/"
      }
    ]
  })
  tags = merge(var.tags, {})
}

resource "aws_iam_group_policy_attachment" "users_attach_policy_students_aws_console" {
  count = var.enable_student_policy_aws_console ? 1 : 0

  group      = aws_iam_group.students[0].name
  policy_arn = aws_iam_policy.students_aws_console[0].arn
}

resource "null_resource" "student-login-profiles" {
  for_each = var.enable_student_policy_aws_console ? toset(local.students) : []
  depends_on = [
    aws_iam_user.students
  ]

  triggers = {
    aws_profile = var.aws_profile
    user_name   = local.students_prefixed[each.key]
  }

  provisioner "local-exec" {
    when       = create
    on_failure = fail
    command    = "aws --profile ${self.triggers.aws_profile} iam create-login-profile --user-name ${self.triggers.user_name} --password ${random_password.students[each.key].result} --no-password-reset-required"
  }

  provisioner "local-exec" {
    when       = destroy
    on_failure = continue
    command    = "aws --profile ${self.triggers.aws_profile} iam delete-login-profile --user-name ${self.triggers.user_name}"
  }
}
