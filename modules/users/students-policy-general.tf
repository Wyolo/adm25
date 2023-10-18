data "aws_iam_policy_document" "students_general" {

  statement {
    sid = "DenyUnapprovedAction"
    actions = [
      "ds:*",
      "iam:CreateUser",
      "cloudtrail:StopLogging",
    ]
    resources = ["*"]
    effect    = "Deny"
  }

  statement {
    actions = [
      "sts:GetCallerIdentity",
      "ec2:DescribeAccountAttributes",
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  dynamic "statement" {
    for_each = var.training_start == "" ? [] : [var.training_start]
    content {
      effect    = "Deny"
      actions   = ["*"]
      resources = ["*"]
      condition {
        test     = "DateLessThan"
        values   = [var.training_start]
        variable = "aws:CurrentTime"
      }
    }
  }

  dynamic "statement" {
    for_each = var.training_finish == "" ? [] : [var.training_finish]
    content {
      effect    = "Deny"
      actions   = ["*"]
      resources = ["*"]
      condition {
        test     = "DateGreaterThan"
        values   = [var.training_finish]
        variable = "aws:CurrentTime"
      }
    }
  }

}

resource "aws_iam_policy" "students_general" {
  count = var.create_student_iam_user ? 1 : 0

  name        = "${module.prefix.value}students-general"
  description = "Set of general rules"
  policy      = data.aws_iam_policy_document.students_general.json
  tags        = merge(var.tags, {})
}

resource "aws_iam_group_policy_attachment" "users_attach_policy_students_general" {
  count = var.create_student_iam_user ? 1 : 0

  group      = aws_iam_group.students[0].name
  policy_arn = aws_iam_policy.students_general[0].arn
}
