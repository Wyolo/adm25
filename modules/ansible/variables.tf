
variable "hosts_filename" {
  description = "Inventory filename for hosts (use every computer if not specified)"
  type        = string
}

variable "limits" {
  description = "specify --limits for Ansible"
  type        = string
  default     = ""
}

variable "playbooks" {
  description = "List of Ansible playbooks to apply"
  type        = list(string)
}
