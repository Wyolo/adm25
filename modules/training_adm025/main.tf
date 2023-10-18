
module "prefix" {
  source = "../prefix"
  value  = var.prefix
}

module "users" {
  source          = "../users"
  file_students   = var.file_students
  file_trainers   = var.file_trainers
  aws_profile     = var.aws_profile
  aws_account     = var.aws_account
  aws_region      = var.aws_region
  prefix          = module.prefix.value
  tags            = var.tags
  training_pause  = var.training_pause
  training_start  = var.training_start
  training_finish = var.training_finish

  create_student_iam_user                  = true
  create_trainer_iam_user                  = true
  enable_student_policy_aws_console        = true
  enable_student_policy_aws_ec2            = true
  enable_student_policy_aws_key_pair       = true
  enable_student_policy_aws_s3             = true
  enable_student_policy_aws_security_group = true
  enable_trainer_policy_aws_admin          = true
  enable_trainer_policy_aws_console        = true
}

module "vpc" {
  count = var.ec2_create ? 1 : 0

  source          = "../vpc"
  prefix          = module.prefix.value
  tags            = var.tags
  cidr            = var.vpc_cidr
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
  open_ports      = var.vpc_open_ports
}

module "ami" {
  count = var.ec2_create ? 1 : 0

  source = "../ami"
}

locals {
  # key for default user
  ec2_name = "server"

  user_names = [
    for user, params in merge(
      module.users.trainers,
      module.users.students,
    ) :
    user
  ]

  key_names = concat(local.user_names, [local.ec2_name])
}

module "keys" {
  count = var.ec2_create ? 1 : 0

  source = "../keys"
  prefix = module.prefix.value
  names  = local.key_names
}

module "ec2" {
  count = var.ec2_create ? 1 : 0

  source                    = "../ec2"
  aws_account               = var.aws_account
  aws_region                = var.aws_region
  prefix                    = module.prefix.value
  tags                      = var.tags
  subnet_id                 = module.vpc[0].vpc_public_subnets[0]
  security_group_ingress_id = module.vpc[0].security_group_ingress_id
  security_group_egress_id  = module.vpc[0].security_group_egress_id
  enable_elastic_ip         = true
  instance_type             = var.ec2_instance_type
  instance_names            = [local.ec2_name]
  instance_disk_size        = var.ec2_instance_disk_size
  instance_ami_id           = module.ami[0].ubuntu21.ami_id
  keys                      = module.keys[0].keys
  ssh_user                  = module.ami[0].ubuntu21.ssh_user
}

module "ansible_users_trainers" {
  count = var.ec2_create ? 1 : 0

  source   = "../ansible_users"
  users    = module.users.trainers
  filename = "${path.root}/ansible/inventory/host_vars/${var.prefix}_${local.ec2_name}/trainers"
  var_name = "trainers"
}

module "ansible_users_students" {
  count = var.ec2_create ? 1 : 0

  source   = "../ansible_users"
  users    = module.users.students
  filename = "${path.root}/ansible/inventory/host_vars/${var.prefix}_${local.ec2_name}/students"
  var_name = "students"
}

module "ansible_users_awscli" {
  count = var.ec2_create ? 1 : 0

  source = "../ansible_users_awscli"
  users = merge(
    module.users.trainers,
    module.users.students,
  )
  filename   = "${path.root}/ansible/inventory/host_vars/${var.prefix}_${local.ec2_name}/awscli_users"
  aws_region = var.aws_region
}

module "ansible_keys_ansible" {
  count = var.ec2_create ? 1 : 0

  source     = "../ansible_keys"
  keys       = module.keys[0].keys
  output_dir = "${path.root}/ansible/keys/${var.prefix}"
}

module "ansible_hosts" {
  count = var.ec2_create ? 1 : 0

  source     = "../ansible_hosts"
  computers  = module.ec2[0].instances
  filename   = "${path.root}/ansible/inventory/${var.prefix}"
  group_name = var.prefix
  key_dir    = "keys/${var.prefix}"
}

module "ec2_wait" {
  count = var.ec2_create ? 1 : 0
  depends_on = [
    module.ec2,
  ]

  source    = "../ec2_wait"
  computers = module.ec2[0].instances
  keys      = module.keys[0].keys
}

module "ansible" {
  count = var.ec2_create ? 1 : 0
  depends_on = [
    module.ansible_users_trainers[0],
    module.ansible_users_students[0],
    module.ansible_users_awscli[0],
    module.ansible_keys_ansible[0],
    module.ansible_hosts[0],
    module.ec2_wait[0],
  ]

  source         = "../ansible"
  hosts_filename = "inventory/${var.prefix}"
  playbooks      = var.ec2_ansible_playbooks
}

resource "local_file" "training_info" {
  content = templatefile(
    "${path.module}/template.${var.training_lang}.md.jinja",
    {
      "instance" = {
        "present"   = var.ec2_create,
        "main_key"  = var.ec2_create ? local.ec2_name : null,
        "main_user" = var.ec2_create ? module.ec2[0].ssh_user : null,
        "ip"        = var.ec2_create ? module.ec2[0].instances[local.ec2_name].public_ip : null,
      },
      "trainers" = {
        for user, params in module.users.trainers :
        user => {
          "password" = params.password,
          "access"   = params.access_key,
          "secret"   = params.secret_access_key,
        }
      },
      "students" = {
        for user, params in module.users.students :
        user => {
          "password" = params.password,
          "access"   = params.access_key,
          "secret"   = params.secret_access_key,
        }
      },
    }
  )
  filename = "${var.output_dir}/TrainingInfo.md"
}
