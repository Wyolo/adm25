
variable "computers" {
  description = "List of computers"
  type        = map(any)
}

variable "filename" {
  description = "Filename for hosts"
  type        = string
  default     = "hosts"
}

variable "group_name" {
  description = "Group name for inventory hosts (skip if empty)"
  type        = string
  default     = ""
}

variable "keys" {
  description = "AWS key names (single value for all instances or multiple values per instance)"
  type        = map(map(any))
  default     = {}
}

variable "key_dir" {
  description = "Directory where keys are stored (needed for properties)"
  type        = string
  default     = ""
}
