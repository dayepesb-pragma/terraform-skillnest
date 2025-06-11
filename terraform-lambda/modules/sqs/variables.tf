variable "queue_name" {
  description = "The name of the SQS queue"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the queue"
  type        = map(string)
  default     = {}
}

variable "message_retention_seconds" {
  description = "The number of seconds that messages should be kept in the queue"
  type        = number
  default     = 345600 # 4 days
}

variable "max_receive_count" {
  description = "The maximum number of times that a message can be received before being sent to the DLQ"
  type        = number
  default     = 3
}
