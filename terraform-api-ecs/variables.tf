variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "container_image" {
  description = "The container image to use (format: repository:tag)"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 3000
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}

variable "default_tags_environment" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "task_cpu" {
  description = "CPU units for the ECS task (256 = 0.25 vCPU)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for the ECS task (in MiB)"
  type        = number
  default     = 512
}

variable "max_capacity" {
  description = "Maximum number of tasks the service can scale to"
  type        = number
  default     = 4
}

variable "min_capacity" {
  description = "Minimum number of tasks the service must maintain"
  type        = number
  default     = 1
}

variable "target_cpu_utilization" {
  description = "Target CPU utilization percentage for auto-scaling"
  type        = number
  default     = 70
}

variable "target_memory_utilization" {
  description = "Target memory utilization percentage for auto-scaling"
  type        = number
  default     = 70
}

variable "service_desired_count" {
  description = "Initial number of tasks to run in the service"
  type        = number
  default     = 1
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS instance in GB"
  type        = number
  default     = 20
}

variable "db_password" {
  description = "Master password for RDS instance"
  type        = string
  sensitive   = true
}

variable "db_schema" {
  description = "Database schema name"
  type        = string
  default     = "skillnettest"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "skillnettest"
}

variable "environment_variables" {
  description = "Environment variables for external services"
  type        = map(string)
  default = {
    URL_CITY_SERVICE = "https://api.api-ninjas.com/v1/city"
    TOKEN_NINJA_API  = "gQUmlderYD2Mz9BiX+0Hdg==pvmSDmPKKdBfSTvv"
  }
}
