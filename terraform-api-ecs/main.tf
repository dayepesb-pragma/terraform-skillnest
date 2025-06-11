# Application Load Balancer
module "alb" {
  source = "./modules/alb"

  name_prefix                = local.name_prefix
  vpc_id                     = var.vpc_id
  public_subnets             = var.public_subnet_ids
  container_port             = var.container_port
  vpc_link_security_group_id = module.apigateway.vpc_link_security_group_id
  tags                       = local.common_tags
}

# ECS Cluster and Service
module "ecs" {
  source = "./modules/ecs"

  name_prefix           = local.name_prefix
  vpc_id                = var.vpc_id
  private_subnets       = var.private_subnet_ids
  container_image       = var.container_image
  container_port        = var.container_port
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
  aws_region            = var.aws_region

  # Task configuration
  task_cpu    = var.task_cpu
  task_memory = var.task_memory

  # Auto-scaling configuration
  max_capacity              = var.max_capacity
  min_capacity              = var.min_capacity
  target_cpu_utilization    = var.target_cpu_utilization
  target_memory_utilization = var.target_memory_utilization
  service_desired_count     = var.service_desired_count

  container_environment = [
    {
      name  = "DB_HOST"
      value = split(":", module.rds.endpoint)[0]
    },
    {
      name  = "DB_PORT"
      value = tostring(module.rds.port)
    },
    {
      name  = "DB_NAME"
      value = module.rds.database_name
    },
    {
      name  = "DB_SCHEMA"
      value = var.db_schema
    },
    {
      name  = "DB_USERNAME"
      value = var.db_username
    },
    {
      name  = "DB_PASSWORD"
      value = var.db_password
    },
    {
      name  = "URL_CITY_SERVICE"
      value = var.environment_variables["URL_CITY_SERVICE"]
    },
    {
      name  = "TOKEN_NINJA_API"
      value = var.environment_variables["TOKEN_NINJA_API"]
    }
  ]

  tags = local.common_tags
}

# API Gateway
module "apigateway" {
  source = "./modules/apigateway"

  name_prefix      = local.name_prefix
  vpc_id           = var.vpc_id
  private_subnets  = var.private_subnet_ids
  alb_listener_arn = module.alb.listener_arn
  alb_dns_name     = module.alb.load_balancer_dns
  tags             = local.common_tags
}

# RDS Instance
module "rds" {
  source = "./modules/rds"

  name_prefix           = local.name_prefix
  vpc_id                = var.vpc_id
  private_subnet_ids    = var.private_subnet_ids
  ecs_security_group_id = module.ecs.task_security_group_id

  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  database_password = var.db_password
  database_username = var.db_username
  database_schema   = var.db_schema

  tags = local.common_tags
}

# Outputs
output "api_endpoint" {
  description = "API Gateway endpoint URL"
  value       = module.apigateway.api_endpoint
}

output "api_endpoints" {
  description = "Available API endpoints"
  value = {
    register = "${module.apigateway.api_endpoint}/user/register"
    login    = "${module.apigateway.api_endpoint}/user/login"
  }
}

output "alb_dns" {
  description = "DNS name of the ALB"
  value       = module.alb.load_balancer_dns
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "container_image" {
  description = "Container image being used"
  value       = var.container_image
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.endpoint
}

output "database_connection_info" {
  description = "Database connection information"
  value = {
    host     = split(":", module.rds.endpoint)[0]
    port     = module.rds.port
    database = module.rds.database_name
    username = "skillnettest"
    schema   = "skillnettest"
  }
  sensitive = false
}
