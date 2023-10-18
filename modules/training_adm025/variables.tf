
variable "file_students" {
  type        = string
  description = "Path to list of students"
}

variable "file_trainers" {
  type        = string
  description = "Path to list of trainers"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile to create training resources"
  default     = "default"
}

variable "aws_region" {
  type        = string
  description = "AWS region for cluster"
  default     = "eu-central-1"
}

variable "aws_account" {
  type        = string
  description = "AWS account used to create resources"
}

variable "prefix" {
  type        = string
  description = "Training prefix for resources"
  default     = "adm025"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "training_pause" {
  type        = bool
  description = "True to suspend and free resources"
  default     = false
}

variable "training_lang" {
  type        = string
  description = "Language for instruction (eng, rus)"
  default     = "eng"

  validation {
    condition     = contains(["eng", "rus"], var.training_lang)
    error_message = "Valid languages are: eng, rus."
  }
}

variable "output_dir" {
  description = "Directory to save training info"
  type        = string
}

variable "training_start" {
  type        = string
  description = "Training start datetime (e.g. 2021-11-02T00:00:00Z)"
}

variable "training_finish" {
  type        = string
  description = "Training finish datetime (e.g. 2021-11-05T23:59:59Z)"
}

# These parameters are used to create ec2 instance for students to work from.

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  type = list(string)
  default = [
    "10.0.1.0/24",
  ]
}

variable "vpc_public_subnets" {
  type = list(string)
  default = [
    "10.0.11.0/24",
  ]
}

variable "vpc_open_ports" {
  description = "List of open ports"
  type        = list(number)
  default     = [22, 80, 8080]
}

variable "ec2_create" {
  type        = bool
  description = "Create EC2 instance for students"
  default     = false
}

variable "ec2_instance_type" {
  # see https://aws.amazon.com/ru/ec2/instance-types/
  description = "AWS instance type"
  type        = string
  default     = "t2.small"
}

variable "ec2_instance_disk_size" {
  description = "AWS instance disk size (Gb)"
  type        = number
  default     = 10
}

variable "ec2_ansible_playbooks" {
  description = "List of Ansible playbooks to apply"
  type        = list(string)
  default = [
    "playbooks/adm-025-terraform.yml",
  ]
}
