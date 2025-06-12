variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_password" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_schema" {
  type = string
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "container_image" {
  type        = string
  description = "The URI of the container image in ECR"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables for the container"
}


