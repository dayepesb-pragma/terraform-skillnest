resource "aws_security_group" "rds" {
  name        = "${var.project}-${var.environment}-rds-sg"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.project}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project}-${var.environment}-db-subnet-group"
  }
}

resource "aws_db_instance" "database" {
  identifier          = "${var.project}-${var.environment}-db"
  allocated_storage   = 20
  engine              = "postgres"
  engine_version      = "14.18"
  instance_class      = var.db_instance_class
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  db_name             = var.db_schema

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
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

variable "vpc_id" {
  type        = string
  description = "VPC ID for the RDS instance"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the DB subnet group"
}

output "db_host" {
  value = aws_db_instance.database.endpoint
}

output "db_name" {
  value = aws_db_instance.database.db_name
}
