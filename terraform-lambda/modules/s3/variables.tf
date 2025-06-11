variable "bucket_name" {
  description = "Name of the S3 bucket to store Lambda code"
  type        = string
}

variable "lambda_zip_key" {
  description = "The key (path) in the S3 bucket where the Lambda zip will be stored"
  type        = string
}

variable "lambda_zip_path" {
  description = "Local path to the Lambda zip file"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}
