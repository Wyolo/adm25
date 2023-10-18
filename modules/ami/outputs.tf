
output "ubuntu16" {
  description = "AWS AMI for Ubuntu 16"
  value = {
    ami_id   = data.aws_ami.ubuntu16.id,
    ssh_user = "ubuntu",
  }
}

output "ubuntu20" {
  description = "AWS AMI for Ubuntu 20"
  value = {
    ami_id   = data.aws_ami.ubuntu20.id,
    ssh_user = "ubuntu",
  }
}

output "ubuntu21" {
  description = "AWS AMI for Ubuntu 21"
  value = {
    ami_id   = data.aws_ami.ubuntu21.id,
    ssh_user = "ubuntu",
  }
}
