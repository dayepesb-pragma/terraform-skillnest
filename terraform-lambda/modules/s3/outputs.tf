output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.lambda_bucket.arn
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.lambda_bucket.id
}

output "lambda_s3_key" {
  description = "The S3 key of the Lambda code"
  value       = aws_s3_object.lambda_code.key
}

output "lambda_s3_version" {
  description = "The version ID of the Lambda code in S3"
  value       = aws_s3_object.lambda_code.version_id
}
