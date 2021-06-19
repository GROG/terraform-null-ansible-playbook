###############################################################################

locals {
  # Prepare variables to pass them to the ansible playbook command
  vars = jsonencode(var.vars)
  args = join(" ", compact(var.args))
  env  = join(" ", var.env)

  # SHA1 of the collection source (which includes the version)
  collection_source_sha1 = sha1(vars.collection.source)
  # Use customized collections path to avoid conflicting version issues
  collections_path = "${abspath(path.root)}/.ansible/collections/${local.collection_source_sha1}"

  install_command = "ansible-galaxy install -p ${local.collections_path} ${var.collection.source}"

  # These commands run the ansible playbook included in this module with the
  # correct parameters and environment variables
  ansible_command = "ANSIBLE_COLLECTIONS_PATHS=${local.collections_path} ${local.env} ansible-playbook ${var.playbook} -e '${local.vars}' -i '${var.hosts},' ${local.args}"
  create_command  = "TAGS_RUN='${join(",", var.tags)}' TAGS_SKIP='${join(",", var.tags_skip)}' ${local.ansible_command}"
  #destroy_command = "TAGS_RUN='${join(",", var.on_destroy_tags)}' TAGS_SKIP='${join(",", var.on_destroy_tags_skip)}' ${local.ansible_command}"
}

###############################################################################
# @TODO: reduce to single resource when #19679 is fixed

# on_destroy_failure == "continue"
resource "null_resource" "playbook" {
  #count = var.on_destroy_failure == "continue" ? 1 : 0

  # @TODO: Remove when #23679 is fixed
  #triggers = {
    #install_command = local.install_command
    #destroy_command = local.destroy_command
  #}
  #lifecycle {
    #ignore_changes = [
      #triggers["install_command"],
      #triggers["destroy_command"]
    #]
  #}

  # Create
  provisioner "local-exec" {
    command = local.install_command
  }
  provisioner "local-exec" {
    command = local.create_command
  }

  # Destroy
  #provisioner "local-exec" {
    #when    = destroy
    #command = local.install_command
    #on_failure = continue
  #}
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
    #install_command = local.install_command
    #destroy_command = local.destroy_command
  #}
  #lifecycle {
    #ignore_changes = [
      #triggers["install_command"],
      #triggers["destroy_command"]
    #]
  #}

  # Create
  #provisioner "local-exec" {
    #command = local.install_command
  #}
  #provisioner "local-exec" {
    #command = local.create_command
  #}

  # Destroy
  #provisioner "local-exec" {
    #when    = destroy
    #command = self.triggers.install_command
    #on_failure = fail
  #}
  #provisioner "local-exec" {
    #when       = destroy
    #command    = self.triggers.destroy_command
    #on_failure = fail
  #}
#}

###############################################################################
