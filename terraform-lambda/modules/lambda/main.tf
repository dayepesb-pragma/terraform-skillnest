# Lambda Function Module
resource "aws_lambda_function" "function" {
  function_name     = var.function_name
  role              = var.lambda_role_arn
  handler           = var.handler
  runtime           = var.runtime
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version

  environment {
    variables = var.environment_variables
  }
}

# Lambda permission for SQS
resource "aws_lambda_permission" "sqs_invoke" {
  statement_id  = "AllowSQSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = var.sqs_queue_arn
}

# Lambda Event Source Mapping
resource "aws_lambda_event_source_mapping" "sqs_mapping" {
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.function.arn
  batch_size       = 1
}
