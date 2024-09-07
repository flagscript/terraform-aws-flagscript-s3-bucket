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
      kms_master_key_id = var.kms_key_arn == "" ? null : var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = var.enable_bucket_key
  }
}

# Standard Bucket policy
data "aws_iam_policy_document" "bucket_policy_document" {

  # Enforce secure transport
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    effect = "Deny"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.bucket.id}",
      "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  # Enforce server-side sses3 if no kms key provided
  dynamic "statement" {
    for_each = var.kms_key_arn == "" ? ["require_sse_s3"] : []
    content {
      actions   = ["s3:PutObject"]
      effect    = "Deny"
      resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]
      sid       = "DenyObjectsThatAreNotSSES3"

      condition {
        test     = "StringNotEquals"
        variable = "s3:x-amz-server-side-encryption"
        values   = ["AES256"]
      }
      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }

  # Enforce server-side sse kms if kms key provided
  dynamic "statement" {
    for_each = var.kms_key_arn != "" ? ["require_sse_kms"] : []

    content {
      actions = ["s3:PutObject"]
      effect  = "Deny"
      resources = [
        "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
      ]
      sid = "DenyUnEncryptedObjectUploads"

      condition {
        test     = "StringNotEquals"
        variable = "s3:x-amz-server-side-encryption"
        values   = ["aws:kms"]
      }
      condition {
        test     = "Null"
        variable = "s3:x-amz-server-side-encryption-aws-kms-key-id"
        values   = ["true"]
      }
      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }

}

# Combined bucket policy
data "aws_iam_policy_document" "merged_s3_policy_document" {
  source_policy_documents = [
    data.aws_iam_policy_document.bucket_policy_document.json,
  ]
}

# Bucket policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.merged_s3_policy_document.json
}
