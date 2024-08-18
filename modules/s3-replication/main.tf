resource "aws_s3_bucket_replication_configuration" "replication" {
  provider = aws.source
  bucket   = var.source_bucket_name
  role     = aws_iam_role.replication_role.arn

  rule {
    id     = "${var.source_bucket_name}-to-${var.destination_bucket_name}-replication"
    status = "Enabled"

    delete_marker_replication {
      status = var.replicate_delete_markers ? "Enabled" : "Disabled"
    }

    destination {
      bucket        = local.destination_bucket_arn
      storage_class = "STANDARD"
    }

    dynamic "filter" {
      for_each = var.filter_prefix == "" ? [] : ["enable-filter"]
      content {
        prefix = var.filter_prefix
      }
    }
  }
}
