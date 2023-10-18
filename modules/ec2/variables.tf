
variable "aws_account" {
  type        = string
  description = "AWS account used to create resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region used to create resources"
}

variable "prefix" {
  type        = string
  description = "Training prefix for resources"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "training_pause" {
  type        = bool
  description = "True to suspend and free resources"
  default     = false
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_ingress_id" {
  description = "Security group ID to access in"
  type        = string
}

variable "security_group_egress_id" {
  description = "Security group ID to access out"
  type        = string
}

variable "enable_elastic_ip" {
  description = "Enable elastic IP"
  type        = bool
  default     = false
}

variable "instance_names" {
  description = "List of instances"
  type        = list(string)
  default     = []
}

variable "instance_type" {
  # see https://aws.amazon.com/ru/ec2/instance-types/
  description = "AWS instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_disk_size" {
  description = "AWS instance disk size (Gb)"
  type        = number
  default     = 10
}

variable "instance_ami_id" {
  description = "AWS AMI ID"
  type        = string
}

# for many values, each key must be ec2 name
variable "keys" {
  description = "AWS key names (single value for all instances or multiple values per instance)"
  type        = map(map(any))
  default     = {}
}

# can be used later using Ansible
variable "ssh_user" {
  description = "User for SSH connection"
  type        = string
  default     = ""
}
