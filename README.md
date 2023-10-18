# About

This is Terraform and Ansible scripts to deploy infrastructure for ADM-025 Terraform training.

Base commit `45b44eacd011216b7366265d91b096d88e9f9a2e`.

`main.tf` contains current configuration for different training. You should add current (ongoing or nearest) training there.

# Prerequisites

You must install the following software:

- AWS CLI
- Terraform
- Ansible

See instructions below.

## AWS CLI

1. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

You _may_ specify AWS profile:

```console
$ export AWS_DEFAULT_PROFILE=profile-name
```

Configure your AWS account (use your own credentials):

```console
$ aws configure
AWS Access Key ID [None]: AKIA5D6UABM3DLTYI3M4
AWS Secret Access Key [None]: YRPwNl2GqQK4kQ8qB2LGqPrZL0M1b/gruRn5eh7n
Default region name [None]: eu-central-1
Default output format [None]: json
```

Check your identity:

```console
$ aws sts get-caller-identity
Account: '901850860342'
Arn: arn:aws:iam::901850860342:user/your-account-name
UserId: AKIA5D6UABM3DLTYI3M4
```

## Terraform

Install [Terraform CLI](https://www.terraform.io/downloads.html).

## Ansible

Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

☝ For Windows, it could be an issue to install Ansible. Use WSL or Docker containers to run it.

Install dependencies:

```console
$ cd ansible
$ ansible-galaxy install -r requirements.yml
```

# ADM-025 Terraform

## Configure global settings

A few variables are defined in `variables.tf`. To override these variables, use file `terraform.tfvars`, e.g.:

```hcl
aws_profile = "terraform-msuslov"
```

## Before training

See `README.md` in the root directory for global configuration.

1. Specify list of trainers and students

Create a folder `data/adm025`.

Edit `data/adm025/trainers.txt` file to provide list of trainers. In most cases there is one trainer. For example:

```text
trainer
# akovalenko
# ddubovitskii
```

or

```text
# trainer
akovalenko
ddubovitskii
```

☝ Lines started with `#` are ignored.

Edit `data/adm025/students.txt` files to provide list of students. You may use accounts by pattern `userXX` or named accounts. For example:

```text
user01
user02
# user03
```

☝ You may use different folder and filenames, just put right ones in the configuration below.

2. Update `/main.tf` (in the root directory) with training configuration by adding the module invocation, e.g.:

```hcl
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
  ec2_create      = false
}
```

If some students can not install `aws` and `terraform` locally, then you may create a dedicated workstation to work on:

```hcl
module "adm025" {
  ...
  ec2_create = true
  ec2_instance_type = "t2.micro"
  ec2_instance_disk_size = 10
}
```

There are other useful parameters:
- `ec2_instance_type`
- `ec2_instance_disk_size`

Information on how to connect there is in the generated `data/adm025/generated/TrainingInfo.md` file.

3. Then run the following commands:

```console
$ terraform init
$ terraform apply
(provide yes to confirm creation)
```

4. Pack the folder `data/adm025/generated` and provide it to a trainer. It contains instructions and keys for connection.

## During the training

For night periods, it would be nice to:

- deactivate keys
- stop ec2

Partially, it archive by setting `training_pause` to `true` or `false`:

```hcl
module "adm025" {
  ...
  training_pause = true
}
```

and then applying changes:

```console
$ terraform apply
```

## After training

Destroy the infrastructure:

```console
$ terraform destroy
```

Also, remove manually the following resources:

- keys
- security groups
- ec2 instances
- ec2 volumes
- s3 buckets

# Troubleshooting

## Profile name in remote state

Use the same AWS profile for different admins. It is needed to delete accounts using AWS CLI.

Root cause is in the keeping profile name in triggers:

```text
# null_resource.trainer-login-profile["trainer"] will be created
+ resource "null_resource" "trainer-login-profile" {
    + id       = (known after apply)
    + triggers = {
        + "aws_profile" = "terraform-msuslov"
        + "user_name"   = "kube-trainer"
      }
  }
```

## Access troubleshooting

In rare cases, you may want to debug access rules (policies). You may do this using [`iamlive`](https://github.com/iann0036/iamlive) tool:

```console
$ iamlive --set-ini --profile terraform-msuslov --output-file policy.json --fails-only  --refresh-rate 1 --sort-alphabetical --host 127.0.0.1 --background
```

# HowTo

## How to add or remove users during the training

Update student's list in `students.txt` file of training settings and apply changes:

```console
$ terraform apply
```

The same for trainers.
