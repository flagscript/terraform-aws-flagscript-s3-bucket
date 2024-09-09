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
  kms_key_type         = local.use_owned_kms || !var.use_aws_owned_kms ? "aws:kme" : "AES256"
  use_owned_kms        = var.kms_key_arn != ""
  common_tags = {
    "github:module:repository" = "flagscript/terraform-aws-flagscript-s3-bucket"
    "terraform:module"         = "terraform-aws-flagscript-s3-bucket"
  }

}
