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

# Block public acls
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket eventbridge notifications
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = aws_s3_bucket.bucket.id
  eventbridge = true
}

# Bucket versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    mfa_delete = "Disabled"
    status     = "Enabled"
  }
}
