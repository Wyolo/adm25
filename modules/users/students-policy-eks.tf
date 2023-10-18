
resource "aws_iam_policy" "students_eks" {
  count = var.enable_student_policy_aws_eks ? 1 : 0

  name        = "${module.prefix.value}students-eks"
  description = "Permissions for students"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:AccessKubernetesApi",
          "ssm:GetParameter",
          "eks:ListUpdates",
          "eks:ListFargateProfiles"
        ]
        Effect = "Allow"
        # TODO: restrict access more
        Resource = "*"
      },
    ]
  })
  tags = merge(var.tags, {})
}

resource "aws_iam_group_policy_attachment" "students_attach_policy_students_eks" {
  count = var.enable_student_policy_aws_eks ? 1 : 0

  group      = aws_iam_group.students[0].name
  policy_arn = aws_iam_policy.students_eks[0].arn
}
