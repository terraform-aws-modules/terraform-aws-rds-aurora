output "db_shard_group_arn" {
  description = "ARN of the shard group"
  value       = module.aurora.db_shard_group_arn
}

output "db_shard_group_resource_id" {
  description = "The AWS Region-unique, immutable identifier for the DB shard group"
  value       = module.aurora.db_shard_group_resource_id
}

output "db_shard_group_endpoint" {
  description = "The connection endpoint for the DB shard group"
  value       = module.aurora.db_shard_group_endpoint
}
