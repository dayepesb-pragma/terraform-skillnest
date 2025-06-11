# SQS Queue Module

# SQS FIFO Queue
resource "aws_sqs_queue" "queue" {
  name                        = "${var.queue_name}.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope         = "messageGroup"
  fifo_throughput_limit       = "perMessageGroupId"

}

# Dead Letter Queue for failed messages
resource "aws_sqs_queue" "dlq" {
  name                        = "${var.queue_name}-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days

}

# Redrive policy to move failed messages to DLQ
resource "aws_sqs_queue_redrive_policy" "queue_redrive" {
  queue_url = aws_sqs_queue.queue.id
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })
}
