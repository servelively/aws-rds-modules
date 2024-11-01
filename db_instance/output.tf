output "db_instance_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.db_instance.*.address
}

output "db_instance_id" {
  description = "The database name"
  value       = aws_db_instance.db_instance.*.id
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.db_instance.*.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.db_instance.*.endpoint
}