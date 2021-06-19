# terraform-null-ansible-collection-playbook

[![Latest tag][tag_image]][tag_url]
[![Gitter chat][gitter_image]][gitter_url]

A Terraform module for applying Ansible playbooks from a collection.

## Usage

```hcl
# A resource we will configure with ansible
resource "aws_instance" "node" {
    # ...
}

# Add ansible module
module "node-ansible-config" {
  source = "GROG/ansible-collection-playbook/null"

  collection = {
    name   = "my.collection"
    source = "https://github.com/my/ansible-collection"
  }

  playbook = "my.collection.bootstrap.yml"

  # Target, this can be a comma separated list
  hosts = "${aws_instance.node.public_ip}"

  tags = ["deploy"]

  # Pass variables to the role
  vars = {
    test     = "1,2,3,4"
    list_var = ["one", "two", "three", "four"]

    number = 1234

    complex = {
        key1 = "value1",
        key2 = "value2"
    }

  }
}
```

## Requirements

- ansible-core-2.11.0 +

## Inputs

| Variable | Description | Type | Default value |
|----------|-------------|------|---------------|
| `hosts` | Single host or comma separated list on which the roles will be applied | `string` | |
| `vars` | Ansible variables which will be passed with `-e` | `map` | |
| `args` | Ansible command arguments | `[]string` | `["-b"]` |
| `env` | Environment variables that are set | `[]string` | `["ANSIBLE_NOCOWS=true", "ANSIBLE_RETRY_FILES=false", "ANSIBLE_HOST_KEY_CHECKING=false"]` |
| `tags` | Tags to use when creating the resource | `[]string`  | `[]` |
| `skip` | Tags to skip when creating the resource | `[]string`  | `[]` |
<!--| `on_destroy_tags` | Tags to use when destroying the resource | `[]string`  | `[]` |-->
<!--| `on_destroy_tags_skip` | Tags to skip when destroying the resource | `[]string`  | `[]` |-->

## Outputs

| Variable | Description | Type |
|----------|-------------|------|
| `id` | Resource ID | `string` |

## Contributing

All assistance, changes or ideas [welcome][issues]!

## Author

By [G. Roggemans][groggemans]

## License

MIT

[tag_image]:    https://img.shields.io/github/tag/GROG/terraform-null-ansible-collection-playbook.svg
[tag_url]:      https://github.com/GROG/terraform-null-ansible-collection-playbook
[gitter_image]: https://badges.gitter.im/GROG/chat.svg
[gitter_url]:   https://gitter.im/GROG/chat

[issues]:       https://github.com/GROG/terraform-null-ansible-collection-playbook
[groggemans]:   https://github.com/groggemans
