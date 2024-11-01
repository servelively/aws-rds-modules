// Primary -Aurora module
output "primary_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_primary.rds_cluster_arn
}

output "primary_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_primary.rds_cluster_id
}
output "primary_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_primary.rds_cluster_resource_id
}
output "primary_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_primary.rds_cluster_members
}
output "primary_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_primary.rds_cluster_endpoint
}
output "primary_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_primary.rds_cluster_reader_endpoint
}
output "primary_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_primary.rds_security_group_id
}

// Secondary -Aurora module

output "secondary_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_secondary.rds_cluster_arn
}

output "secondary_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_secondary.rds_cluster_id
}
output "secondary_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_secondary.rds_cluster_resource_id
}
output "secondary_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_secondary.rds_cluster_members
}
output "secondary_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_secondary.rds_cluster_endpoint
}
output "secondary_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_secondary.rds_cluster_reader_endpoint
}
output "secondary_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_secondary.rds_security_group_id
}