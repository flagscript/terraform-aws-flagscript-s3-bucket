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
