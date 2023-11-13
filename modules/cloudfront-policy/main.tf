locals {
  oac_sid        = var.allow_write ? "AllowCloudFrontServicePrincipalReadWrite" : "AllowCloudFrontServicePrincipalReadOnly"
  oac_write_perm = var.allow_write ? ["s3:PutObject"] : []
}

# Cloudfront bucket Policy
## https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html
data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    effect = "Deny"
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
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

  statement {
    actions   = concat(["s3:GetObject"], local.oac_write_perm)
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]
    sid       = local.oac_sid

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [var.distribution_arn]
    }
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }

}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}


# {
#     "Version": "2012-10-17",
#     "Statement": {
#         "Sid": "AllowCloudFrontServicePrincipalReadOnly",
#         "Effect": "Allow",
#         "Principal": {
#             "Service": "cloudfront.amazonaws.com"
#         },
#         "Action": "s3:GetObject",
#         "Resource": "arn:aws:s3:::<S3 bucket name>/*",
#         "Condition": {
#             "StringEquals": {
#                 "AWS:SourceArn": "arn:aws:cloudfront::<AWS account ID>:distribution/<CloudFront distribution ID>"
#             }
#         }
#     }
# }
