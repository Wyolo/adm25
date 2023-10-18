
module "adm025" {
  source        = "./modules/training_adm025"
  file_students = "data/adm025/students.txt"
  file_trainers = "data/adm025/trainers.txt"
  output_dir    = "data/adm025/generated"
  tags = {
    training = "adm-025 terraform"
    creator  = "Egor Khaziev"
    trainer  = "Dmitrii Dubovitskii"
  }
  training_pause  = false
  training_lang   = "rus"
  aws_profile     = var.aws_profile
  aws_region      = local.aws_region
  aws_account     = local.aws_account
  training_start  = "2022-01-02T00:00:00Z"
  training_finish = "2022-02-02T00:00:00Z"
}
