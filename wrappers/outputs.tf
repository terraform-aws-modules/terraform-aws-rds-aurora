output "wrapper" {
  description = "Map of outputs of a wrapper."
  value       = module.wrapper
  sensitive   = true # At least one sensitive module output (cluster_master_password) found (requires Terraform 0.14+)
}
