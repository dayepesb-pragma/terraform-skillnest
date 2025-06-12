resource "aws_security_group" "rds" {
  name        = "${var.project}-${var.environment}-rds-sg"
  description = "RDS security group"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }
}

resource "aws_db_instance" "database" {
  identifier          = "${var.project}-${var.environment}-db"
  allocated_storage   = 20
  engine              = "postgres"
  engine_version      = "13.7"
  instance_class      = var.db_instance_class
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  db_name             = var.db_schema

  vpc_security_group_ids = [aws_security_group.rds.id]
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_schema" {
  type = string
}

variable "ecs_security_group_id" {
  type        = string
  description = "Security group ID of the ECS service"
}

output "db_host" {
  value = aws_db_instance.database.endpoint
}

output "db_name" {
  value = aws_db_instance.database.db_name
}
