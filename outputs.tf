output "root_password" {
  description = "root password"
  value       = resource.random_password.linode_root_password.result
  sensitive   = true
}

output "linode_ip" {
  description = "linode_ip"
  value       = resource.linode_instance.my_akddos_instance.ipv4
  sensitive   = false
}
