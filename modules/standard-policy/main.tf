# Standard Bucket Policy
data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    effect = "Deny"
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
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

  dynamic "statement" {
    for_each = var.require_sse_kms ? ["require_sse_kms"] : []

    content {
      actions = ["s3:PutObject"]
      effect  = "Deny"
      resources = [
        "${aws_s3_bucket.bucket.arn}/*"
      ]
      sid = "DenyUnEncryptedObjectUploads"

      condition {
        test     = "StringNotEquals"
        variable = "s3:x-amz-server-side-encryption"
        values   = ["aws:kms"]
      }
      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }

}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}
