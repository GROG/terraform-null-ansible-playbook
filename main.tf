###############################################################################

locals {
  # Prepare variables to pass them to the ansible playbook command
  vars = jsonencode(var.vars)
  args = join(" ", compact(var.args))
  env  = join(" ", var.env)

  collections_paths = var.collections_paths != "" ? "ANSIBLE_COLLECTIONS_PATHS=${var.collections_paths} " : ""

  # Format tags
  tags      = length(var.tags) > 0 ? "--tags ${join(",", var.tags)}" : ""
  tags_skip = length(var.tags_skip) > 0 ? "--skip-tags ${join(",", var.tags_skip)}" : ""

  # These commands run the ansible playbook included in this module with the
  # correct parameters and environment variables
  ansible_command = "${local.collections_paths}${local.env} ansible-playbook ${var.playbook} -e '${local.vars}' -i '${var.hosts},' ${local.args}"
  create_command  = "${local.ansible_command} ${local.tags} ${local.tags_skip}"
  #destroy_command = "${local.ansible_command} ${local.tags} ${local.tags_skip}"
}

###############################################################################
# @TODO: reduce to single resource when #19679 is fixed

# on_destroy_failure == "continue"
resource "null_resource" "playbook" {
  #count = var.on_destroy_failure == "continue" ? 1 : 0

  # @TODO: Remove when #23679 is fixed
  #triggers = {
    #destroy_command = local.destroy_command
  #}
  #lifecycle {
    #ignore_changes = [
      #triggers["destroy_command"]
    #]
  #}

  # Create
  provisioner "local-exec" {
    command = local.create_command
  }

  # Destroy
  #provisioner "local-exec" {
    #when       = destroy
    #command    = self.triggers.destroy_command
    #on_failure = continue
  #}
}

# on_destroy_failure == "fail"
#resource "null_resource" "playbook_fail" {
  #count = var.on_destroy_failure == "fail" ? 1 : 0

  # @TODO: Remove when #23679 is fixed
  #triggers = {
    #destroy_command = local.destroy_command
  #}
  #lifecycle {
    #ignore_changes = [
      #triggers["destroy_command"]
    #]
  #}

  # Create
  #provisioner "local-exec" {
    #command = local.create_command
  #}

  # Destroy
  #provisioner "local-exec" {
    #when       = destroy
    #command    = self.triggers.destroy_command
    #on_failure = fail
  #}
#}

###############################################################################
