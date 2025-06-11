output "queue_arn" {
  description = "The ARN of the main SQS queue"
  value       = aws_sqs_queue.queue.arn
}

output "queue_url" {
  description = "The URL of the main SQS queue"
  value       = aws_sqs_queue.queue.url
}

output "dlq_arn" {
  description = "The ARN of the Dead Letter Queue"
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_url" {
  description = "The URL of the Dead Letter Queue"
  value       = aws_sqs_queue.dlq.url
}
