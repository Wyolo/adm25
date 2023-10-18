
resource "aws_iam_policy" "students_aws_s3_bucket" {
  count = var.enable_student_policy_aws_s3 ? 1 : 0

  name        = "${module.prefix.value}students-aws-s3-bucket"
  description = "Set of aws_s3_bucket rules"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:GetBucketAcl",
          "s3:GetBucketCors",
          "s3:GetBucketWebsite",
          "s3:GetBucketVersioning",
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketLogging",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:GetBucketReplication",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketEncryption",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketTagging",
          "s3:ListBucketVersions",
        ],
        "Resource" : "arn:aws:s3:::*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:PutBucketVersioning",
        ],
        "Resource" : "arn:aws:s3:::*"
        # TODO: потом добавить ограничение по региону + свои бакеты, если можно
      },
      {
        "Effect" : "Allow",
        "Action" : [
          # See https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazons3.html
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectTagging",
          "s3:DeleteObject",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload",
        ],
        "Resource" : "arn:aws:s3:::*/*"
      },
    ]
  })
  tags = merge(var.tags, {})
}

resource "aws_iam_group_policy_attachment" "users_attach_policy_students_aws_s3_bucket" {
  count = var.enable_student_policy_aws_s3 ? 1 : 0

  group      = aws_iam_group.students[0].name
  policy_arn = aws_iam_policy.students_aws_s3_bucket[0].arn
}
