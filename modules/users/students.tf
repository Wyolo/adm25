
locals {
  students_groupname = "${module.prefix.value}students"
}

resource "aws_iam_group" "students" {
  count = var.create_student_iam_user ? 1 : 0

  name = local.students_groupname
}

resource "aws_iam_user" "students" {
  for_each = var.create_student_iam_user ? toset(local.students) : []

  name          = local.students_prefixed[each.key]
  force_destroy = true
  tags          = merge(var.tags, {})
}

resource "aws_iam_access_key" "students" {
  for_each = var.create_student_iam_user ? toset(local.students) : []

  user   = aws_iam_user.students[each.value].name
  status = var.training_pause ? "Inactive" : "Active"
  # status = "Inactive" # TODO: for Terraform training
}

resource "aws_iam_user_group_membership" "students" {
  for_each = var.create_student_iam_user ? toset(local.students) : []
  depends_on = [
    aws_iam_user.students
  ]

  user = local.students_prefixed[each.key]
  groups = [
    aws_iam_group.students[0].name,
  ]
}

# Password is used for AWS console, login into ec2, attach to VNC
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_account-policy.html#default-policy-details
resource "random_password" "students" {
  for_each = toset(local.students)

  length           = 8
  override_special = "_"
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}
