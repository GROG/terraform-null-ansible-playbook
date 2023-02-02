###############################################################################

variable "playbook" {
  type        = string
  description = <<EOF
Playbook to run

The module won't install the playbook, you should make sure it's available on
the system.
EOF
}

variable "hosts" {
  type = string

  description = <<EOF
Host(s) to target with Ansible

This can be a comma separated list or single host.
EOF
}

###############################################################################
# Optional parameters

variable "collections_path" {
  type        = string
  default     = ""
  description = "Collections path to be used during playbook run"
}

variable "vars" {
  type        = any
  default     = {}
  description = "Ansible variables to pass to the playbook"
}

variable "args" {
  type    = list(string)
  default = ["-b"]

  description = <<EOF
Command line arguments passed to ansible
EOF
}

variable "env" {
  type = list(string)

  default = [
    "ANSIBLE_NOCOWS=true",
    "ANSIBLE_RETRY_FILES_ENABLED=false",
    "ANSIBLE_HOST_KEY_CHECKING=false",
  ]

  description = <<EOF
Environment variables that will be set when running the playbook.
EOF
}

variable "tags" {
  type    = list(string)
  default = []

  description = <<EOF
A list of tags to use when running the playbook during creation of the object.
By default no tags are used and all tasks will be executed.

This can be used to run specific tasks form the playbook when creating an
image, deploying the image, or destroying the instance.
EOF
}

variable "tags_skip" {
  type        = list(string)
  default     = []
  description = "Tags to skip when creating the object"
}

###############################################################################
