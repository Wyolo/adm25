
variable "users" {
  description = "List of users"
  type        = map(map(string))
  default     = {}
}

variable "var_name" {
  description = "Variable name for users"
  type        = string
  default     = "users"
}

variable "filename" {
  description = "Filename for users"
  type        = string
}
