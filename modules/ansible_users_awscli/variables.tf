
variable "users" {
  description = "List of users"
  type        = map(map(string))
  default     = {}
}

variable "aws_region" {
  type        = string
  description = "AWS region used to create resources"
}

variable "filename" {
  description = "Filename for users (skip if empty)"
  type        = string
  default     = ""
}
