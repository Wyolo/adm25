
variable "aws_region" {
  type        = string
  description = "AWS region for cluster"
  default     = "eu-central-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile to create training resources"
  default     = "default"
}
