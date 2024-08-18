data "aws_iam_policy_document" "s3_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "replication_role" {
  provider           = aws.destination
  assume_role_policy = data.aws_iam_policy_document.s3_assume_role.json
  description        = "Role to allow s3 replication from the ${var.source_bucket_name} bucket to the ${var.destination_bucket_name} bucket."
  name_prefix        = "S3ReplicationRole"
  path               = "/s3/"

  tags = merge(
    local.common_tags,
    {
      Name = "S3ReplicationRole"
    }
  )
}

data "aws_iam_policy_document" "replication_policy_document" {
  statement {
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]
    effect    = "Allow"
    resources = [local.source_bucket_arn]
  }

  statement {
    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]
    effect    = "Allow"
    resources = ["${local.source_bucket_arn}/*"]
  }

  statement {
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]
    effect    = "Allow"
    resources = ["${local.destination_bucket_arn}/*"]
  }
}

resource "aws_iam_policy" "replication_policy" {
  provider    = aws.destination
  description = "Policy to allow s3 replication from the ${var.source_bucket_name} bucket to the ${var.destination_bucket_name} bucket."
  name_prefix = "S3ReplicationPolicy"
  path        = "/s3/"
  policy      = data.aws_iam_policy_document.replication_policy_document.json

  tags = merge(
    local.common_tags,
    {
      Name = "S3ReplicationPolicy"
    }
  )
}

resource "aws_iam_role_policy_attachment" "replication_role_policy_attachment" {
  provider   = aws.destination
  role       = aws_iam_role.replication_role.name
  policy_arn = aws_iam_policy.replication_policy.arn
}
