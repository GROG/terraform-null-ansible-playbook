###############################################################################

output "id" {
  #value = var.on_destroy_failure == "continue" ? null_resource.playbook_continue.0.id : null_resource.playbook_fail.0.id
  value = null_resource.playbook.id

  description = <<EOF
Resource ID

This can be used to trigger updates for other resources.
EOF

}

###############################################################################
