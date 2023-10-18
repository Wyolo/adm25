
variable "prefix" {
  type        = string
  description = "Training prefix for resources"
  default     = ""
}

variable "names" {
  description = "List of names of keys"
  type        = list(string)
}
