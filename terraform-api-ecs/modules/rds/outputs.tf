output "endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.postgresql.endpoint
}

output "database_name" {
  description = "Name of the database"
  value       = aws_db_instance.postgresql.db_name
}

output "port" {
  description = "RDS instance port"
  value       = 5432
}

output "security_group_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds.id
}
