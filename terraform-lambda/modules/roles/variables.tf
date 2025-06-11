variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  type        = string
}

variable "sqs_dlq_arn" {
  description = "The ARN of the SQS Dead Letter Queue"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the IAM role"
  type        = map(string)
  default     = {}
}
