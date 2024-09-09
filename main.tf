# S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
  tags = merge(
    local.common_tags,
    {
      Name = local.bucket_name
    }
  )
}

## Block public acls
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## Bucket eventbridge notifications
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = aws_s3_bucket.bucket.id
  eventbridge = true
}

## Bucket versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    mfa_delete = var.enable_mfa_delete ? "Enabled" : "Disabled"
    status     = "Enabled"
  }
}

## Bucket ownership
resource "aws_s3_bucket_ownership_controls" "bucket_ownership_controls" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.object_ownership
  }
}

## Bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = local.use_owned_kms ? var.kms_key_arn : null
      sse_algorithm     = local.kms_key_type
    }
    bucket_key_enabled = var.enable_bucket_key
  }
}

# Combined bucket policy
data "aws_iam_policy_document" "merged_s3_policy_document" {
  source_policy_documents = concat(
    [data.aws_iam_policy_document.bucket_policy_document.json],
    local.do_cloudfront_policy ? [data.aws_iam_policy_document.cloudfront_bucket_policy_document.json] : []
  )
}

# Bucket policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.merged_s3_policy_document.json
}
