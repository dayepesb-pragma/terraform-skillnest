variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "message-processor"
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "message-processor"
    ManagedBy   = "terraform"
  }
}

variable "TF_VAR_S3_BUCKET" {
  description = "S3 bucket name for storing Lambda code"
  type        = string
  default     = "message-processor-lambda-code"
}

variable "TF_VAR_S3_KEY" {
  description = "S3 key for the Lambda code"
  type        = string
  default     = "lambda.zip"
}