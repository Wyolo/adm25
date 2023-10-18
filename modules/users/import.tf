locals {
  trainers_raw = [
    for line in split("\n", file(var.file_trainers)) :
    trimspace(line)
  ]

  trainers = [
    for line in local.trainers_raw :
    line if length(line) > 0 && substr(line, 0, 1) != "#"
  ]

  trainers_prefixed = {
    for trainer in local.trainers :
    trainer => "${module.prefix.value}${trainer}"
  }

  students_raw = [
    for line in split("\n", file(var.file_students)) :
    trimspace(line)
  ]

  students = [
    for line in local.students_raw :
    line if length(line) > 0 && substr(line, 0, 1) != "#"
  ]

  students_prefixed = {
    for student in local.students :
    student => "${module.prefix.value}${student}"
  }
}
