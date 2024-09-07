data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  bucket_name = (
    var.bucket_name_suffix == "" ?
    "${var.bucket_name_prefix}-${local.current_account_id}-${local.current_region}" :
    "${var.bucket_name_prefix}-${local.current_account_id}-${local.current_region}-${var.bucket_name_suffix}"
  )
  current_account_id   = data.aws_caller_identity.current.account_id
  current_region       = data.aws_region.current.id
  do_cloudfront_policy = length(var.cloudfront_distribution_arns) > 0
  common_tags = {
    "github:module:repository" = "flagscript/terraform-aws-flagscript-s3-bucket"
    "terraform:module"         = "terraform-aws-flagscript-s3-bucket"
  }

}
