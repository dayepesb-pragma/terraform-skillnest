# Security Group for RDS
resource "aws_security_group" "rds" {
  name        = "${var.name_prefix}-rds-sg"
  description = "Security group for RDS PostgreSQL instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }

  tags = var.tags
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds" {
  name       = "${var.name_prefix}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = var.tags
}

# Parameter group
resource "aws_db_parameter_group" "postgres" {
  family = "postgres14"
  name   = "${var.name_prefix}-pg"

  parameter {
    name  = "search_path"
    value = var.database_schema
  }

  tags = var.tags
}

# RDS Instance
resource "aws_db_instance" "postgresql" {
  identifier        = "${var.name_prefix}-db"
  engine            = "postgres"
  engine_version    = "14.18"
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password

  # Initialize schema
  parameter_group_name = aws_db_parameter_group.postgres.name

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds.name

  skip_final_snapshot = true
  multi_az            = false

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  tags = var.tags
}
