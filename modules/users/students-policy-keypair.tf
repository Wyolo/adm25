
resource "aws_iam_policy" "students_aws_key_pair" {
  count = var.enable_student_policy_aws_key_pair ? 1 : 0

  name        = "${module.prefix.value}student-aws-key-pair"
  description = "Set of aws_key_pair rules"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeKeyPairs",
        ],
        "Resource" : "*",
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:ImportKeyPair",
          "ec2:CreateKeyPair",
          "ec2:DeleteKeyPair",
        ],
        "Resource" : "arn:aws:ec2:${var.aws_region}:${var.aws_account}:key-pair/*",
      },
      # {
      #   "Effect" : "Allow",
      #   "Action" : [
      #     "iam:DeleteSSHPublicKey",
      #     "iam:GetSSHPublicKey",
      #     "iam:ListSSHPublicKeys",
      #     "iam:UpdateSSHPublicKey",
      #     "iam:UploadSSHPublicKey"
      #   ],
      #   "Resource" : "arn:aws:iam::*:user/$${aws:username}"
      # },
    ]
  })
  tags = merge(var.tags, {})
}

resource "aws_iam_group_policy_attachment" "users_attach_policy_students_aws_key_pair" {
  count = var.enable_student_policy_aws_key_pair ? 1 : 0

  group      = aws_iam_group.students[0].name
  policy_arn = aws_iam_policy.students_aws_key_pair[0].arn
}
