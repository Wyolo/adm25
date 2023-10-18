
# About

This module allows to run ansible playbooks on the specified computers.

# Requirements

The module requires the following programs should be installed:

- `ansible`
- `ssh`

# Inputs

| Name                | Description                        | Type           | Default    | Required |
| ------------------- | ---------------------------------- | -------------- | ---------- | :------: |
| `ansible_playbooks` | List of Ansible playbooks to apply | `list(string)` | n/a        |   yes    |
| `computers`         | List of computers                  | `map(any)`     | n/a        |   yes    |
| `ssh_user`          | User for SSH connection            | `string`       | `"ubuntu"` |    no    |

# Outputs

No outputs.

# Resources

| Name                                                                                                                   |
| ---------------------------------------------------------------------------------------------------------------------- |
| [local_file.inventory_computers](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)   |
| [local_file.inventory_pem_files](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)   |
| [null_resource.run_ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)     |
| [null_resource.wait_connection](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |
