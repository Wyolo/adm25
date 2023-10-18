

resource "aws_iam_policy" "students_aws_instance" {
  count = var.enable_student_policy_aws_console ? 1 : 0

  name        = "${module.prefix.value}students-aws-instance"
  description = "Set of aws_instance rules"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeInstanceCreditSpecifications",
          "ec2:DescribeNetworkInterfaces",
        ],
        "Resource" : "*",
      },
      {
        "Effect" : "Allow",
        "Action" : [
          # for web
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeAddresses",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "compute-optimizer:GetEnrollmentStatus",
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:GetInstanceProfile",
          "iam:ListInstanceProfiles"
        ],
        "Resource" : "arn:aws:iam::${var.aws_account}:instance-profile/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:GetMetricStatistics",
        ],
        "Resource" : [
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:instance/*",
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:DescribeAlarms",
        ],
        "Resource" : [
          "arn:aws:cloudwatch:${var.aws_region}:${var.aws_account}:alarm:*",
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:MonitorInstances",
          "ec2:RebootInstances",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
        ],
        "Resource" : [
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:instance/*",
          "arn:aws:ec2:${var.aws_region}::image/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:network-interface/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:security-group/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:subnet/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:volume/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:vpc/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:placement-group/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:capacity-reservation/*",
          "arn:aws:elastic-inference:${var.aws_region}:${var.aws_account}:elastic-inference-accelerator/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:launch-template/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:elastic-gpu/*",
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:key-pair/*",
          "arn:aws:ec2:${var.aws_region}::snapshot/*"
        ]
      },
      {
        "Sid" : "RequireMicroInstanceType",
        "Effect" : "Deny",
        "Action" : "ec2:RunInstances",
        "Resource" : [
          "arn:aws:ec2:${var.aws_region}:${var.aws_account}:instance/*"
        ],
        "Condition" : {
          "ForAnyValue:StringNotEquals" : {
            "ec2:InstanceType" : [
              "t2.micro",
              "t2.nano",
              "t2.small",
            ]
          }
        }
      }
    ]
  })
  tags = merge(var.tags, {})
}

resource "aws_iam_group_policy_attachment" "users_attach_policy_students_aws_instance" {
  count = var.enable_student_policy_aws_console ? 1 : 0

  group      = aws_iam_group.students[0].name
  policy_arn = aws_iam_policy.students_aws_instance[0].arn
}
