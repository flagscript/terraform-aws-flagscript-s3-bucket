data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  bucket_name = (
    var.bucket_name_suffix == "" ?
    "${var.bucket_name_prefix}-${local.current_account_id}-${local.current_region}" :
    "${var.bucket_name_prefix}-${local.current_account_id}-${local.current_region}-${var.bucket_name_suffix}"
  )
  current_account_id = data.aws_caller_identity.current.account_id
  current_region     = data.aws_region.current.id
  common_tags = {
    # "flagscript:account-owner:owner"            = var.org_owner
    # "flagscript:automation:environment"         = "root"
    "flagscript:cost-allocation:application-id" = var.application_id
    # "flagscript:cost-allocation:owner"          = var.org_owner
    # "flagscript:data-owner:owner"               = var.org_owner
    # "flagscript:operations:owner"               = var.org_owner
    "github:module:repository" = "flagscript/terraform-aws-flagscript-s3-bucket"
    "terraform:module"         = "terraform-aws-flagscript-s3-bucket"
  }

}
