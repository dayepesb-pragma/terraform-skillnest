# Get current AWS region
data "aws_region" "current" {}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Get AWS partition (aws, aws-cn, aws-us-gov)
data "aws_partition" "current" {}

# Common tags for all resources
locals {
  common_tags = merge(var.default_tags, {
    Environment = var.environment
    Region      = data.aws_region.current.name
    Account     = data.aws_caller_identity.current.account_id
    Terraform   = "true"
  })

  # Common naming convention
  name_prefix = "${var.project}-${var.environment}-${data.aws_region.current.name}"
}


