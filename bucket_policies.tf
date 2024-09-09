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
    for_each = local.use_owned_kms ? [] : ["require_sse_s3"]
    content {
      actions   = ["s3:PutObject"]
      effect    = "Deny"
      resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]
      sid       = "DenyObjectsThatAreNotSSES3"

      condition {
        test     = "StringNotEquals"
        variable = "s3:x-amz-server-side-encryption"
        values   = [local.kms_key_type]
      }
      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }

  # Enforce server-side sse kms if kms key provided
  dynamic "statement" {
    for_each = local.use_owned_kms ? ["require_sse_kms"] : []

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

# Cloudfront policies
locals {
  oac_sid        = var.allow_cloudfront_write ? "AllowCloudFrontServicePrincipalReadWrite" : "AllowCloudFrontServicePrincipalReadOnly"
  oac_write_perm = var.allow_cloudfront_write ? ["s3:PutObject"] : []
}

# Cloudfront bucket Policy
## https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html
data "aws_iam_policy_document" "cloudfront_bucket_policy_document" {

  statement {
    actions   = concat(["s3:GetObject"], local.oac_write_perm)
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]
    sid       = local.oac_sid

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = var.cloudfront_distribution_arns
    }
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }

}
