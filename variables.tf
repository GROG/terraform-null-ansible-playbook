###############################################################################

variable "collection" {
  type = object({
    name = string,
    source = string
  })

  description = "Collection to install"
}

variable "playbook" {
  type = string
  description = "Playbook from the collection to run"
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

variable "vars" {
  type = any
  default = {}
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

By default we set the Ansible collections path to be relative to the terraform module
folder. By doing this the versions needed for this module won't interfere with
other versions.
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
  type    = list(string)
  default = []
  description = "Tags to skip when creating the object"
}

#variable "on_destroy_tags" {
  #type = list(string)
  #default = []

  #description = <<EOF
#If set, the playbook will also be run on destruction of the object, using the
#specified tags.
#EOF
#}

#variable "on_destroy_tags_skip" {
  #type = list(string)
  #default = []
  #description = "Tags to skip when destroying the object"
#}

#variable "on_destroy_failure" {
  #type    = string
  #default = "continue"

  #description = <<EOF
#Should we fail if the destroy action failed? ["conftinue","fail"] ("continue")
#EOF
#}

###############################################################################
