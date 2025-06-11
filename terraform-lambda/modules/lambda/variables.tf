variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "sqs_queue_arn" {
  description = "The ARN of the SQS queue to trigger the Lambda"
  type        = string
}

variable "handler" {
  description = "The handler function for the Lambda"
  type        = string
  default     = "index.handleMessage"
}

variable "runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "nodejs18.x"
}

variable "s3_bucket" {
  description = "The S3 bucket containing the Lambda code"
  type        = string
}

variable "s3_key" {
  description = "The S3 key for the Lambda code"
  type        = string
}

variable "s3_object_version" {
  description = "The version of the S3 object containing the Lambda code"
  type        = string
  default     = null
}
