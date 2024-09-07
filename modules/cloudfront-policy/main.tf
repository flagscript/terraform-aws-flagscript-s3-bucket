locals {
  oac_sid        = var.allow_write ? "AllowCloudFrontServicePrincipalReadWrite" : "AllowCloudFrontServicePrincipalReadOnly"
  oac_write_perm = var.allow_write ? ["s3:PutObject"] : []
}

# Cloudfront bucket Policy
## https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html
data "aws_iam_policy_document" "bucket_policy_document" {


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
