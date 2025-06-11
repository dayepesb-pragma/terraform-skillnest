# S3 Bucket for Lambda code
module "s3" {
  source = "./modules/s3"

  bucket_name     = var.TF_VAR_S3_BUCKET
  lambda_zip_key  = "${local.name_prefix}/lambda.zip"
  lambda_zip_path = "${path.module}/../lambda/dist/lambda.zip"
  tags            = local.common_tags
}

# SQS Queue
module "sqs" {
  source = "./modules/sqs"

  queue_name = "${var.project}-queue"
  tags       = var.default_tags
}
module "dlq" {
  source = "./modules/sqs"

  queue_name = "${var.project}-dlq-queue"
  tags       = var.default_tags
}

# IAM Roles
module "roles" {
  source = "./modules/roles"

  function_name = "${var.project}-function"
  sqs_queue_arn = module.sqs.queue_arn
  sqs_dlq_arn   = module.dlq.queue_arn
}

# Lambda Function12
module "lambda" {
  source = "./modules/lambda"

  s3_key            = "${local.name_prefix}/lambda.zip"
  s3_bucket         = var.TF_VAR_S3_BUCKET
  s3_object_version = module.s3.lambda_s3_version
  function_name     = "${var.project}-function"
  lambda_role_arn   = module.roles.lambda_role_arn
  sqs_queue_arn     = module.sqs.queue_arn

  environment_variables = {
    NODE_ENV      = var.environment
    SQS_QUEUE_URL = module.sqs.queue_url
    DLQ_URL       = module.sqs.dlq_url
  }
}

# Outputs
output "lambda_function_name" {
  value = module.lambda.function_name
}

output "sqs_queue_url" {
  value = module.sqs.queue_url
}

output "sqs_dlq_url" {
  value = module.sqs.dlq_url
}
