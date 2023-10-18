
variable "keys" {
  description = "AWS key names (single value for all instances or multiple values per instance)"
  type        = map(map(any))
  default     = {}
}

variable "output_dir" {
  description = "Directory to save keys"
  type        = string
  default     = ""
}

variable "output_file_prefix" {
  description = "Prefix for output files"
  type        = string
  default     = ""
}
