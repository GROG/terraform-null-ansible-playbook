###############################################################################

locals {
  # Prepare variables to pass them to the ansible playbook command
  vars = jsonencode(var.vars)
  args = join(" ", compact(var.args))
  env  = join(" ", var.env)

  collections_path = var.collections_path != "" ? "ANSIBLE_COLLECTIONS_PATH=${var.collections_path} " : ""

  # Format tags
  tags      = length(var.tags) > 0 ? "--tags ${join(",", var.tags)}" : ""
  tags_skip = length(var.tags_skip) > 0 ? "--skip-tags ${join(",", var.tags_skip)}" : ""

  # These commands run the ansible playbook included in this module with the
  # correct parameters and environment variables
  ansible_command = "${local.collections_path}${local.env} ansible-playbook ${var.playbook} -e '${local.vars}' -i '${var.hosts},' ${local.args}"
  create_command  = "${local.ansible_command} ${local.tags} ${local.tags_skip}"
}

###############################################################################

resource "null_resource" "playbook" {
  # Create
  provisioner "local-exec" {
    command = local.create_command
  }
}

###############################################################################
