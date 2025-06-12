provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  project     = var.project
  environment = var.environment
}

module "alb" {
  source = "./modules/alb"

  project     = var.project
  environment = var.environment

  container_port = var.container_port
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.public_subnet_ids
}

module "ecs" {
  source = "./modules/ecs"

  project     = var.project
  environment = var.environment

  container_image = var.container_image
  container_port  = var.container_port
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids

  environment_variables = var.environment_variables
  alb_security_group_id = module.alb.security_group_id
  target_group_arn      = module.alb.target_group_arn
}

module "rds" {
  source = "./modules/rds"

  project            = var.project
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  db_password       = var.db_password
  db_username       = var.db_username
  db_schema         = var.db_schema
  db_instance_class = var.db_instance_class

  ecs_security_group_id = module.ecs.security_group_id
}

module "apigateway" {
  source = "./modules/apigateway"

  project     = var.project
  environment = var.environment

  alb_dns_name     = module.alb.alb_dns_name
  alb_listener_arn = module.alb.listener_arn
}
