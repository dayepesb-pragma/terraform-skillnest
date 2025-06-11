variable "name_prefix" {
  description = "Prefix to use for resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "container_image" {
  description = "Docker image to run in the ECS cluster"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 3000
}

variable "container_environment" {
  description = "Environment variables for the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "task_cpu" {
  description = "CPU units for the task (1 vCPU = 1024)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for the task (in MiB)"
  type        = number
  default     = 512
}

variable "service_desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 2
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
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
