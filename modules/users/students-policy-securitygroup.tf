
# Based on:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_ec2_securitygroups-vpc.html
resource "aws_iam_policy" "students_aws_security_group" {
  count = var.enable_student_policy_aws_security_group ? 1 : 0

  name        = "${module.prefix.value}student-aws-security-group"
  description = "Set of aws_security_group rules"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeTags",
          # new rule (-s) comparing with reference above
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSubnets",
          "ec2:CreateTags",
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:ModifySecurityGroupRules"
        ],
        "Resource" : [
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:security-group-rule/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateSecurityGroup",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSecurityGroups",
        ],
        "Resource" : "arn:aws:ec2:${var.aws_region}:${var.aws_account}:*",
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:ModifySecurityGroupRules",
          "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
          "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
          # new rule (-s) comparing with reference above
          "ec2:DeleteSecurityGroup",
        ],
        "Resource" : "arn:aws:ec2:${var.aws_region}:${var.aws_account}:security-group/*",

      },
    ]
  })
  tags = merge(var.tags, {})
}

resource "aws_iam_group_policy_attachment" "users_attach_policy_students_aws_security_group" {
  count = var.enable_student_policy_aws_security_group ? 1 : 0

  group      = aws_iam_group.students[0].name
  policy_arn = aws_iam_policy.students_aws_security_group[0].arn
}
