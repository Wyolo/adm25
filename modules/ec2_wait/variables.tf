variable "computers" {
  description = "List of computers"
  type        = map(any)
}

variable "keys" {
  description = "AWS key names (single value for all instances or multiple values per instance)"
  type        = map(map(any))
  default     = {}
}
