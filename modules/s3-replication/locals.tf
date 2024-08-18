locals {
  destination_bucket_arn = "arn:aws:s3:::${var.destination_bucket_name}"
  source_bucket_arn      = "arn:aws:s3:::${var.source_bucket_name}"

  common_tags = {
    "github:module:repository" = "flagscript/terraform-aws-flagscript-s3-bucket"
    "terraform:module"         = "s3-replication"
  }
}
