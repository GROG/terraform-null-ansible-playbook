###############################################################################

output "id" {
  value       = null_resource.playbook.id
  description = <<EOF
Resource ID

This can be used to trigger updates for other resources.
EOF

}

###############################################################################
