
output "trainers" {
  description = "Map of trainers info"
  value = {
    for name in local.trainers :
    name => {
      name_prefixed     = local.trainers_prefixed[name],
      arn               = var.create_trainer_iam_user ? aws_iam_user.trainers[name].arn : null,
      password          = random_password.trainers[name].result,
      access_key        = var.create_trainer_iam_user ? aws_iam_access_key.trainers[name].id : null,
      secret_access_key = var.create_trainer_iam_user ? aws_iam_access_key.trainers[name].secret : null,
    }
  }
}

output "trainers_group" {
  description = "Trainer group info"
  value = {
    name = local.trainers_groupname,
    arn  = var.create_trainer_iam_user ? aws_iam_group.trainers[0].arn : null,
  }
}

output "students" {
  description = "List of students"
  value = {
    for name in local.students :
    name => {
      name_prefixed     = local.students_prefixed[name],
      arn               = var.create_student_iam_user ? aws_iam_user.students[name].arn : null,
      password          = random_password.students[name].result,
      access_key        = var.create_student_iam_user ? aws_iam_access_key.students[name].id : null,
      secret_access_key = var.create_student_iam_user ? aws_iam_access_key.students[name].secret : null,
    }
  }
}

output "students_group" {
  description = "Student group info"
  value = {
    name = local.students_groupname,
    arn  = var.create_student_iam_user ? aws_iam_group.students[0].arn : null,
  }
}
