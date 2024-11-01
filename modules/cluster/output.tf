//instance
output "rds_cluster_instance_identifier" {
    value = var.create_cluster ? aws_rds_cluster_instance.cluster_instances.*.identifier : []
}
output "rds_cluster_instance_id" {
    value = var.create_cluster ? aws_rds_cluster_instance.cluster_instances.*.id : []
}
output "rds_cluster_instance_endpoint" {
    value = var.create_cluster ? aws_rds_cluster_instance.cluster_instances.*.endpoint : []
}

//cluster
output "rds_cluster_endpoint" {
    value = var.create_cluster ? aws_rds_cluster.postgresql.0.endpoint : null
}
output "rds_cluster_reader_endpoint" {
    value = var.create_cluster ? aws_rds_cluster.postgresql.0.reader_endpoint : null
}
output "rds_cluster_arn" {
    value = var.create_cluster ?aws_rds_cluster.postgresql.0.arn : null
}
output "rds_cluster_id" {
    value = var.create_cluster ? aws_rds_cluster.postgresql.0.id : null
}
output "rds_cluster_resource_id" {
    value = var.create_cluster ? aws_rds_cluster.postgresql.0.cluster_resource_id : null
}
output "rds_cluster_members" {
    value = var.create_cluster ? aws_rds_cluster.postgresql.0.cluster_members : null
}
//security group
output "rds_security_group_id" {
  value = var.create_security_group ? aws_security_group.cluster_sg.0.id : null
}