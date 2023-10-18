
# About

This module allows you to create list of students and trainers.

# Inputs

| Name             | Description                              | Type          | Default     | Required |
| ---------------- | ---------------------------------------- | ------------- | ----------- | :------: |
| `aws_profile`    | AWS profile to create training resources | `string`      | `"default"` |    no    |
| `training_pause` | True to suspend and free resources       | `bool`        | n/a         |   yes    |
| `prefix`         | Training prefix for resources            | `string`      | n/a         |   yes    |
| `tags`           | A map of tags to add to all resources.   | `map(string)` | n/a         |   yes    |
| `target_account` | AWS account used to create resources     | `string`      | n/a         |   yes    |
| `target_region`  | AWS region used to create resources      | `string`      | n/a         |   yes    |

# Outputs

| Name       | Description      | Type           |
| ---------- | ---------------- | -------------- |
| `students` | List of students | `list(string)` |

# Resources

| Name                                                                                                                                                                                      |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [aws_iam_access_key.student](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)                                                                  |
| [aws_iam_access_key.trainer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)                                                                  |
| [aws_iam_group.students](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)                                                                           |
| [aws_iam_group.trainers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)                                                                           |
| [aws_iam_group_policy_attachment.trainers_attach_policy_AdministratorAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)     |
| [aws_iam_group_policy_attachment.users_attach_policy_student_aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)       |
| [aws_iam_group_policy_attachment.users_attach_policy_student_aws_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)       |
| [aws_iam_group_policy_attachment.users_attach_policy_student_aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)      |
| [aws_iam_group_policy_attachment.users_attach_policy_student_aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) |
| [aws_iam_group_policy_attachment.users_attach_policy_student_general](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)            |
| [aws_iam_policy.student_aws_console](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                              |
| [aws_iam_policy.student_aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                             |
| [aws_iam_policy.student_aws_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                             |
| [aws_iam_policy.student_aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                            |
| [aws_iam_policy.student_aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                       |
| [aws_iam_policy.student_general](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                                  |
| [aws_iam_user.students](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)                                                                             |
| [aws_iam_user.trainers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)                                                                             |
| [aws_iam_user_group_membership.student](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership)                                            |
| [aws_iam_user_group_membership.trainer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership)                                            |
| [local_file.save_users](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)                                                                               |
| [null_resource.student-login-profile](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)                                                              |
| [null_resource.trainer-login-profile](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)                                                              |
| [random_password.student](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                                                                        |
| [random_password.trainer](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                                                                        |

# Data Sources

| Name                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------- |
| [aws_iam_policy.AdministratorAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) |
